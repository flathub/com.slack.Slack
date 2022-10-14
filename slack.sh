#!/bin/sh

set -oue pipefail

export TMPDIR=$XDG_CACHE_HOME

# Wayland support can be optionally enabled by changing the environment variable in flatseal or by running:
# flatpak override --user --env=USE_WAYLAND=1 com.Slack.slack
declare -i USE_WAYLAND="${USE_WAYLAND:-0}"

if [[ "${USE_WAYLAND}" -eq 1 && "${XDG_SESSION_TYPE}" == "wayland" ]]; then
    EXTRA_ARGS="--enable-features=UseOzonePlatform,WaylandWindowDecorations,WebRTCPipeWireCapturer --ozone-platform=wayland"
else
    EXTRA_ARGS="--enable-features=WebRTCPipeWireCapturer"
fi

zypak-wrapper /app/extra/bin/slack -s $EXTRA_ARGS "$@"
