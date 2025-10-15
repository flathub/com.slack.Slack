#!/bin/bash

WAYLAND_SOCKET=${WAYLAND_DISPLAY:-"wayland-0"}

EXTRA_ARGS='--enable-features=WebRTCPipeWireCapturer'

if [[ -e "${XDG_RUNTIME_DIR}/${WAYLAND_SOCKET}" || -e "${WAYLAND_DISPLAY}" ]]
then
    EXTRA_ARGS="${EXTRA_ARGS} --enable-wayland-ime --wayland-text-input-version=3"

    # work around electron's broken wayland detection
    # TODO: remove when Slack uses an electron release that includes the fix
    # https://github.com/electron/electron/pull/48301
    EXTRA_ARGS="${EXTRA_ARGS} --ozone-platform=wayland"
fi

env TMPDIR=${XDG_CACHE_HOME} XDG_DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD) zypak-wrapper /app/extra/slack -s ${EXTRA_ARGS} "$@"
