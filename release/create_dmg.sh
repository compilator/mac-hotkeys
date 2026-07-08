#!/bin/bash
set -euo pipefail

if [[ $# -ne 2 ]]; then
  echo "usage: $0 <path-to-MacHotkeys.app> <output-dmg-path>" >&2
  exit 1
fi

APP_SRC="$1"
DMG_PATH="$2"
VOLUME_NAME="Mac Hotkeys"

if [[ ! -d "$APP_SRC" ]]; then
  echo "error: app not found: ${APP_SRC}" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d "${TMPDIR:-/tmp}/machotkeys-dmg.XXXXXX")"
RW_DMG="${TMP_DIR}/temp.dmg"
MOUNT_POINT="${TMP_DIR}/mnt"

cleanup() {
  if [[ -d "$MOUNT_POINT" ]] && mount | grep -q " on ${MOUNT_POINT} "; then
    hdiutil detach "$MOUNT_POINT" -force >/dev/null 2>&1 || true
  fi
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$MOUNT_POINT"

APP_SIZE_KB="$(du -sk "$APP_SRC" | awk '{print $1}')"
# Leave headroom for the Applications symlink and volume metadata.
DMG_SIZE_KB=$((APP_SIZE_KB + 10240))

echo "    Creating temporary DMG (${DMG_SIZE_KB} KB)..."
# Blank images: do not pass -format (newer hdiutil requires -srcfolder with -format).
hdiutil create \
  -size "${DMG_SIZE_KB}k" \
  -fs HFS+ \
  -volname "$VOLUME_NAME" \
  "$RW_DMG" \
  >/dev/null

echo "    Mounting temporary DMG..."
hdiutil attach "$RW_DMG" \
  -mountpoint "$MOUNT_POINT" \
  -nobrowse \
  -quiet

echo "    Copying MacHotkeys.app..."
cp -R "$APP_SRC" "${MOUNT_POINT}/MacHotkeys.app"

echo "    Creating Applications symlink..."
ln -s /Applications "${MOUNT_POINT}/Applications"

sync

echo "    Detaching volume..."
hdiutil detach "$MOUNT_POINT" -quiet

echo "    Compressing to UDZO..."
mkdir -p "$(dirname "$DMG_PATH")"
rm -f "$DMG_PATH"
hdiutil convert "$RW_DMG" \
  -format UDZO \
  -imagekey zlib-level=9 \
  -o "$DMG_PATH" \
  >/dev/null

echo "    Created $(basename "$DMG_PATH")"
