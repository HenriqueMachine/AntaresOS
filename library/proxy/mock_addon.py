"""AntaresOS · addon de mock/rewrite para o mitmproxy.

Lê regras de library/proxy/mocks.json e, quando uma request casa, responde
localmente (sem ir ao servidor) — o "Map Local / Rewrite" do Charles.

Regra (mocks.json):
  {
    "enabled": true,
    "match": "api.exemplo.com/users",   // substring OU regex na URL
    "status": 200,
    "headers": {"Content-Type": "application/json"},
    "body": "{\"ok\": true}",           // corpo inline
    "body_file": "mocks/users.json"      // OU arquivo (relativo a mocks.json)
  }
"""
import json
import logging
import os
import re

from mitmproxy import http

RULES_PATH = os.environ.get(
    "ANTARES_PROXY_MOCKS",
    os.path.expanduser("~/Github/AntaresOS/library/proxy/mocks.json"),
)


def _load():
    try:
        with open(RULES_PATH, encoding="utf-8") as f:
            return json.load(f) or []
    except FileNotFoundError:
        return []
    except Exception as exc:  # noqa: BLE001
        logging.warning("antares-proxy: erro lendo %s: %s", RULES_PATH, exc)
        return []


class AntaresMock:
    def __init__(self):
        self.rules = _load()
        active = [r for r in self.rules if r.get("enabled", True)]
        logging.info("antares-proxy: %d regra(s) de mock ativa(s)", len(active))

    def request(self, flow: http.HTTPFlow) -> None:
        url = flow.request.pretty_url
        for rule in self.rules:
            if not rule.get("enabled", True):
                continue
            pat = rule.get("match", "")
            if not pat:
                continue
            if pat in url or re.search(pat, url):
                body = rule.get("body", "")
                bf = rule.get("body_file")
                if bf:
                    path = bf if os.path.isabs(bf) else os.path.join(os.path.dirname(RULES_PATH), bf)
                    if os.path.exists(path):
                        with open(path, encoding="utf-8") as fh:
                            body = fh.read()
                flow.response = http.Response.make(
                    int(rule.get("status", 200)),
                    body.encode() if isinstance(body, str) else body,
                    rule.get("headers", {"Content-Type": "application/json"}),
                )
                logging.info("antares-proxy: mock → %s", url)
                return


addons = [AntaresMock()]
