#!/bin/sh

set -e
set -x
mkdir -p "$HOME/.cache/unity3d"
mkdir -p "$HOME/.local/share/unity3d/Unity/"
set +x
echo 'Writing $UNITY_LICENSE_CONTENT to license file $HOME/.local/share/unity3d/Unity/Unity_lic.ulf'
echo "$UNITY_LICENSE_CONTENT" | tr -d '\r' > "$HOME/.local/share/unity3d/Unity/Unity_lic.ulf"

exec "$@"
