#!/bin/sh

set -oue pipefail

# Wayland support is enabled by default, it can be disabled by changing the environment variable in flatseal or by running:
# flatpak override --user --env=USE_WAYLAND=0 com.slack.Slack
declare -i USE_WAYLAND="${USE_WAYLAND:-1}"

if [[ "${USE_WAYLAND}" -eq 1 && "${XDG_SESSION_TYPE:-''}" == "wayland" ]]; then
	EXTRA_ARGS="--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --enable-wayland-ime --ozone-platform=wayland"
else
	EXTRA_ARGS="--enable-features=WebRTCPipeWireCapturer"
fi

zypak-wrapper /app/extra/bin/slack -s "${EXTRA_ARGS}" "$@"
