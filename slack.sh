#!/bin/bash

WAYLAND_SOCKET=${WAYLAND_DISPLAY:-"wayland-0"}

EXTRA_ARGS='--enable-features=WebRTCPipeWireCapturer'

if [[ -e "${XDG_RUNTIME_DIR}/${WAYLAND_SOCKET}" || -e "${WAYLAND_DISPLAY}" ]]
then
    EXTRA_ARGS="${EXTRA_ARGS} --enable-wayland-ime --ozone-platform-hint=auto --wayland-text-input-version=3"
fi

# Check for the existence of the keyring before continuing, as the Slack token
# is stored in a keyring, and when it cannot access the keyring it thinks the
# session is destroyed and never tries the token from keyring again once it is
# accessible. This can happen due to race in startup applications where the
# secret service is provided by a non-DE program like keepassxc.
#
# If secret service exists, lookup for a non-existent entry fails silently.
# But if it doesn't, there is an error printed.
tries=3
while (( $tries > 0 )); do
    tries=$(( $tries - 1 ))
    output=$(2>&1 secret-tool lookup anything_random_dont_use_this_key_fgd78gca6ft8wg9tr f7s8frslfjsdkfsfsgjfg)
    if [[ "$output" == "" ]] || [[ $? == 0 ]]; then
        break
    fi
    
    >&2 printf "Cannot access keyring! "
    
    if (( $tries == 0 )); then
        >&2 echo "Max tries exceeded, exiting."
        exit 69  # UNAVAILABLE
    fi

    >&2 echo "Retrying after 5seconds..."
    sleep 5
done

env TMPDIR=${XDG_CACHE_HOME} XDG_DOWNLOAD_DIR=$(xdg-user-dir DOWNLOAD) zypak-wrapper /app/extra/slack -s ${EXTRA_ARGS} "$@"
