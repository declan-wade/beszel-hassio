# Beszel Home Assistant app

This repository is an unofficial Home Assistant app wrapper for the Beszel monitoring agent.

It follows the app model documented at https://contributors.home-assistant.io/apps/ and uses the upstream Beszel agent container/runtime described at https://github.com/henrygd/beszel.

## Why this exists

Beszel ships a native agent binary and a Docker image named `henrygd/beszel-agent`. This app packages that runtime into a Home Assistant custom app so it can run alongside Home Assistant in the Supervisor-managed environment.

## Repository layout

- `repository.yaml` — custom repository metadata for Home Assistant
- `beszel-agent/` — the app package
  - `build.yaml` — image architecture definitions
  - `config.yaml` — app options and settings exposed to Home Assistant
  - `Dockerfile` — builds the app image from the Home Assistant base image and downloads the upstream Beszel agent binary

## Install

1. Add this repository in Home Assistant under Settings > Add-ons > Add-on Store > Three dots > Repositories.
2. Install the Beszel Agent app.
3. Generate or copy the Beszel hub public key and token from the Beszel hub UI.
4. Configure the app with:
   - `hub_url` — the URL of your Beszel hub, for example `http://homeassistant.local:8090`
   - `token` — the Beszel agent token
   - `key` — the Beszel public key
   - `listen` — the port or bind address the agent should listen on, usually `45876`

## Notes

- This is an unofficial app and is intended as a starting point for a custom Home Assistant deployment.
- The Home Assistant app config should be reviewed against your host environment before production use, especially permissions and network access.
- For best results, keep the Beszel hub and the Home Assistant host reachable over the same network.
