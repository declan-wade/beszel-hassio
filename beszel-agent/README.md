# Beszel Agent for Home Assistant

This app runs the upstream Beszel agent inside a Home Assistant app environment.

## Configuration

Set these values in the app UI:

- `hub_url`: URL of the Beszel hub, for example `http://homeassistant.local:8090`
- `token`: Beszel agent access token
- `key`: Beszel public key
- `listen`: Port or socket the agent listens on, usually `45876`
- `log_level`: logging verbosity

## Runtime behavior

The app wrapper launches the upstream `beszel-agent` binary. It expects the standard Beszel environment variables:

- `HUB_URL`
- `TOKEN`
- `KEY`
- `LISTEN`

This matches the official Docker setup used by Beszel itself.
