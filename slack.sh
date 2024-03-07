#!/bin/bash

EXTRA_ARGS='--enable-features=WebRTCPipeWireCapturer'

if [[ -e "${XDG_RUNTIME_DIR}/${WAYLAND_DISPLAY:-'wayland-0'}" || -e "${WAYLAND_SOCKET}" ]]
then
    EXTRA_ARGS="${EXTRA_ARGS} --enable-wayland-ime --ozone-platform-hint=auto"
fi

env TMPDIR=${XDG_CACHE_HOME} XDG_DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD) zypak-wrapper /app/extra/slack -s ${EXTRA_ARGS} "$@"
