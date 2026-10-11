#!/bin/sh
# BTC/USD price for tmux status-right. Cached for a minute because CoinGecko's
# free API rate-limits (HTTP 429) at tmux's 15s refresh.
cache=/tmp/tmux-btc-price
if [ -z "$(find "$cache" -mmin -1 2>/dev/null)" ]; then
  touch "$cache" # back off a minute even if the fetch fails; keeps the last price
  price=$(curl -s --max-time 5 "https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd,idr" | jq -r '.bitcoin | select(.usd and .idr) | "\(.usd) \(.idr)"')
  if [ -n "$price" ]; then
    set -- $price
    idr=$(echo "$2" | sed ':a;s/\B[0-9]\{3\}\>/.&/;ta') # 1481334555 -> 1.481.334.555
    echo "BTC \$$1 Rp$idr" > "$cache"
  fi
fi
cat "$cache"
