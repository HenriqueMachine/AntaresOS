#!/usr/bin/env bash
# deepdeck-lib — shared helpers for the Deepdeck scripts. Source it; do not run it.
# shellcheck disable=SC2034  # the variables are used by the scripts that source this file
# Agent identity (emoji, colour) comes from ONE place: the vault note 11-Agentes/Identidade.md.

FOODBOT_ROOT=${FOODBOT_ROOT:-$HOME/Foodbot}
DD_VAULT=$FOODBOT_ROOT/obsidian-vault/knowledge
DD_IDENTITY=$DD_VAULT/11-Agentes/Identidade.md

# Palette
DD_M=$'\e[38;2;255;42;109m'; DD_C=$'\e[38;2;5;217;232m'; DD_Y=$'\e[38;2;249;240;2m'; DD_G=$'\e[38;2;0;255;159m'
DD_W=$'\e[38;2;245;245;245m'; DD_D=$'\e[38;2;92;92;112m'; DD_B=$'\e[1m'; DD_R=$'\e[0m'

# "#rrggbb" -> ANSI truecolor foreground
dd_fg() {
    local h=${1#\#}
    [ ${#h} -eq 6 ] || { printf '%s' "$DD_W"; return; }
    printf '\e[38;2;%d;%d;%dm' "0x${h:0:2}" "0x${h:2:2}" "0x${h:4:2}"
}

# Prints "key<TAB>emoji<TAB>#hex" for each agent of the identity table.
dd_identity() {
    [ -f "$DD_IDENTITY" ] || return 0
    awk -F'|' '/^\| *[a-z]+ *\| / && $2 !~ /agente/ {
        k=$2; e=$3; c=$4; gsub(/^ +| +$/, "", k); gsub(/^ +| +$/, "", e); gsub(/^ +| +$/, "", c)
        if (c ~ /^#[0-9a-fA-F]{6}$/) print k "\t" e "\t" c }' "$DD_IDENTITY"
}

# dd_who <name> -> sets DD_EMOJI and DD_COLOR (ANSI). Unknown name: a dot and white.
dd_who() {
    local key line
    key=$(printf '%s' "$1" | tr '[:upper:]' '[:lower:]')
    line=$(dd_identity | awk -F'\t' -v k="$key" '$1==k {print; exit}')
    if [ -n "$line" ]; then
        DD_EMOJI=$(cut -f2 <<<"$line")
        DD_COLOR=$(dd_fg "$(cut -f3 <<<"$line")")
    else
        DD_EMOJI="·"
        DD_COLOR=$DD_W
    fi
}
