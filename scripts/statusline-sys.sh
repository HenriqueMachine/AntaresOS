#!/usr/bin/env zsh
# AntaresOS · statusline — sistema (CPU / RAM / bateria) para zjstatus command_*

# CPU total (user+sys), arredondado
local cpu
cpu=$(top -l1 -n0 2>/dev/null | awk -F'[ %]' '/CPU usage/{printf "%.0f", $3+$6}')

# RAM usada (100 - free%)
local freep ram
freep=$(memory_pressure 2>/dev/null | awk -F': ' '/free percentage/{gsub(/[^0-9]/,"",$2); print $2}')
ram=$(( 100 - ${freep:-0} ))

# bateria
local bat
bat=$(pmset -g batt 2>/dev/null | grep -o '[0-9]*%' | head -1 | tr -d '%')

print -n " ${cpu:-?}%  ${ram}%  ${bat:-?}%"
