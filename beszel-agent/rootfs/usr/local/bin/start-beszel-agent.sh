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

# Supervisor mounts the Docker socket only when docker_api is enabled
# and protection mode is disabled for this app.
if [ -z "${DOCKER_HOST:-}" ]; then
    for sock in /run/docker.sock /var/run/docker.sock; do
        if [ -S "$sock" ]; then
            export DOCKER_HOST="unix://${sock}"
            break
        fi
    done
fi

if [ -z "${DOCKER_HOST:-}" ]; then
    bashio::log.warning "Docker socket not found. Disable 'Protection mode' for this app to enable container stats."
else
    bashio::log.info "Using Docker socket at ${DOCKER_HOST}"
fi

exec /usr/local/bin/beszel-agent
