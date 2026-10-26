#!/usr/bin/with-contenv bashio
set -eu

export HUB_URL="${HUB_URL:-$(bashio::config 'hub_url')}"
export TOKEN="${TOKEN:-$(bashio::config 'token')}"
export KEY="${KEY:-$(bashio::config 'key')}"
export LISTEN="${LISTEN:-$(bashio::config 'listen')}"

if [ -z "${KEY:-}" ]; then
    echo "Missing Beszel public key. Set the 'key' option in the app config."
    exit 1
fi

if [ -z "${TOKEN:-}" ]; then
    echo "Missing Beszel agent token. Set the 'token' option in the app config."
    exit 1
fi

if [ -z "${HUB_URL:-}" ]; then
    echo "Missing Beszel hub URL. Set the 'hub_url' option in the app config."
    exit 1
fi

if [ -z "${LISTEN:-}" ]; then
    export LISTEN="45876"
fi

exec /usr/local/bin/beszel-agent
