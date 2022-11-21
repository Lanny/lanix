#!/usr/bin/env bash

NSTAT="$(nmcli -f IN-USE,SIGNAL,SSID device wifi | awk '/\*/ { print $0 }')"

if [[ "$NSTAT" = "" ]]; then
  echo -e "<span color=\"red\">NO WIFI</span>"
  exit 0
fi

SIG_STR="$(echo "$NSTAT" | awk '{ print $2 }')"
SSID="$(echo "$NSTAT" | awk 'match($0, /\* +[0-9]+ +(.*) +$/, arr) { print arr[1] }')"

SIG_COLOR="green"
if [[ SIG_STR -lt 50 ]]; then
  SIG_COLOR="red"
elif [[ SIG_STR -lt 80 ]]; then
  SIG_COLOR="yellow"
fi

echo -e "$SSID (<span color=\"${SIG_COLOR}\">${SIG_STR}%</span>)"
