#!/bin/sh

mkdir -p "$HOME/.cache/unity3d"
mkdir -p "$HOME/.local/share/unity3d/Unity/"
if [ x"$UNITY_LICENSE_CONTENT" != x"" ]; then
  # Write $UNITY_LICENSE_CONTENT to license file
  # $HOME/.local/share/unity3d/Unity/Unity_lic.ulf
  echo "$UNITY_LICENSE_CONTENT" | tr -d '\r' > "$HOME/.local/share/unity3d/Unity/Unity_lic.ulf"
fi

exec "$@"
