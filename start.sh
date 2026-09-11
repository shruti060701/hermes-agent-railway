#!/bin/bash
# Start both gateway (background) and dashboard (foreground) for Railway
set -e

# As of Nous Research's July 2026 security update, HERMES_DASHBOARD_INSECURE / --insecure
# is a deprecated no-op, and the dashboard refuses to start on a non-loopback bind (0.0.0.0,
# required so Railway can route to it) without an auth provider configured. Bootstrap basic
# auth credentials on first boot if the deployer hasn't set their own via Railway variables,
# and persist them to the data volume so they survive restarts/redeploys instead of rotating
# every time the container starts.
export HERMES_DASHBOARD_BASIC_AUTH_USERNAME="${HERMES_DASHBOARD_BASIC_AUTH_USERNAME:-admin}"

DATA_DIR="${HERMES_HOME:-/opt/data}"
mkdir -p "$DATA_DIR"

# persist_or_generate <env-var-name> <file-name> <openssl-args...>
# If the deployer already set the var (Railway variable), use it as-is and don't touch
# the file. Otherwise reuse a previously-generated value from the volume if one exists,
# or generate a fresh one and persist it so it's stable across restarts/redeploys.
persist_or_generate() {
  local var_name="$1" file_name="$2"; shift 2
  local file_path="$DATA_DIR/$file_name"
  if [ -n "${!var_name}" ]; then
    return
  fi
  if [ -f "$file_path" ]; then
    export "$var_name=$(cat "$file_path")"
  else
    local generated
    generated="$(openssl rand "$@")"
    export "$var_name=$generated"
    echo "$generated" > "$file_path"
    chmod 600 "$file_path"
  fi
}

persist_or_generate HERMES_DASHBOARD_BASIC_AUTH_PASSWORD .dashboard_auth_password -hex 12
persist_or_generate HERMES_DASHBOARD_BASIC_AUTH_SECRET .dashboard_auth_secret -hex 16

echo "[hermes-agent-railway] Dashboard login — username: $HERMES_DASHBOARD_BASIC_AUTH_USERNAME  password: $HERMES_DASHBOARD_BASIC_AUTH_PASSWORD"
echo "[hermes-agent-railway] To set your own, add HERMES_DASHBOARD_BASIC_AUTH_PASSWORD as a Railway variable."
echo "[hermes-agent-railway] Fresh deploy — the agent has no LLM provider or messaging platform yet:"
echo "[hermes-agent-railway]   -> Open the dashboard, then go to /models to set your LLM provider/API key"
echo "[hermes-agent-railway]   -> Then go to /channels to connect Telegram, Discord, Slack, etc."
echo "[hermes-agent-railway] The gateway warnings below (no platforms/allowlists configured) are expected until you do."

# Gateway handles messaging channels (Telegram, Discord, etc.)
hermes gateway run &

# Dashboard WebUI — bind to 0.0.0.0 so Railway can route to it
exec hermes dashboard --host 0.0.0.0 --port "${PORT:-9119}" --no-open
