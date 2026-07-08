#!/bin/bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

APP_SRC="build/Build/Products/Release/MacHotkeys.app"
DMG_NAME="MacHotkeys-1.0.dmg"
DIST_DIR="dist"
DMG_PATH="${DIST_DIR}/${DMG_NAME}"

echo "==> Building MacHotkeys (Release)..."
xcodebuild \
  -project MacHotkeys.xcodeproj \
  -scheme MacHotkeys \
  -configuration Release \
  -derivedDataPath build \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_ALLOWED=NO \
  build

if [[ ! -d "$APP_SRC" ]]; then
  echo "error: expected app not found at ${APP_SRC}" >&2
  exit 1
fi

echo "==> Found ${APP_SRC}"

mkdir -p "$DIST_DIR"

if [[ -f "$DMG_PATH" ]]; then
  echo "==> Removing previous ${DMG_PATH}"
  rm -f "$DMG_PATH"
fi

echo "==> Creating ${DMG_PATH}"
"${ROOT_DIR}/release/create_dmg.sh" "$APP_SRC" "$DMG_PATH"

echo "Done: ${DMG_PATH}"
