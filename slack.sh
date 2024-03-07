#!/bin/bash

EXTRA_ARGS='--enable-features=WebRTCPipeWireCapturer'

if [[ -e "${XDG_RUNTIME_DIR}/${WAYLAND_SOCKET:-'wayland-0'}" || -e "${WAYLAND_DISPLAY}" ]]
then
    EXTRA_ARGS="${EXTRA_ARGS} --enable-wayland-ime --ozone-platform-hint=auto"
fi

env TMPDIR=${XDG_CACHE_HOME} XDG_DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD) zypak-wrapper /app/extra/slack -s ${EXTRA_ARGS} "$@"
