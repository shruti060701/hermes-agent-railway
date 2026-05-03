#!/bin/bash
# Start both gateway (background) and dashboard (foreground) for Railway
set -e

# Gateway handles messaging channels (Telegram, Discord, etc.)
hermes gateway run &

# Dashboard WebUI — bind to 0.0.0.0 so Railway can route to it
exec hermes dashboard --host 0.0.0.0 --port "${PORT:-9119}" --no-open --insecure
