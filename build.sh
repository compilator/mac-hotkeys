#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

echo "Building MacHotkeys (Release)..."
xcodebuild \
  -project MacHotkeys.xcodeproj \
  -scheme MacHotkeys \
  -configuration Release \
  -derivedDataPath build \
  CODE_SIGN_IDENTITY="-" \
  CODE_SIGNING_ALLOWED=NO \
  build

APP_SRC="build/Build/Products/Release/MacHotkeys.app"
APP_DST="MacHotkeys.app"

rm -rf "$APP_DST"
cp -R "$APP_SRC" "$APP_DST"

echo "Done: $APP_DST"
