#!/usr/bin/env bash
# deepdeck-notify — Claude Code Notification hook: a macOS notification with the agent's emoji when a Runeterra
# agent waits for the user (a permission prompt or an idle question). The tab icons (⏳/✅) come from the global
# zellij-attention hooks; this adds only the system notification. Runs only in agent sessions (FOODBOT_AGENT set).
# Never fails the hook.
[ -n "${FOODBOT_AGENT:-}" ] || exit 0
# shellcheck source=deepdeck-lib.sh
. "$(dirname "$0")/deepdeck-lib.sh" 2>/dev/null || exit 0
input=$(cat)
msg=$(jq -r '.message // "Esperando você"' <<<"$input" 2>/dev/null | head -c 180)
dd_who "$FOODBOT_AGENT"
name="$(printf '%s' "${FOODBOT_AGENT:0:1}" | tr '[:lower:]' '[:upper:]')${FOODBOT_AGENT:1}"
title="$DD_EMOJI $name"
where=${ZELLIJ_SESSION_NAME:+ · aba do Zellij}
# AppleScript strings: escape backslashes and quotes.
esc() { sed 's/\\/\\\\/g; s/"/\\"/g' <<<"$1"; }
osascript -e "display notification \"$(esc "$msg")\" with title \"$(esc "$title")\" subtitle \"Deepdeck$(esc "$where")\" sound name \"Glass\"" >/dev/null 2>&1 || true
exit 0
