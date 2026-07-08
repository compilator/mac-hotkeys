# Mac Hotkeys — Release Guide

Instructions for building the app, packaging a DMG, and publishing a GitHub Release.

## Requirements

- macOS with Xcode Command Line Tools
- Native tools only: `xcodebuild`, `hdiutil`, `ln`, `cp`, `mkdir`, `rm`

No third-party DMG utilities are required.

## Quick release (recommended)

From the repository root:

```bash
./release/build_dmg.sh
```

This single command will:

1. Build the app in **Release** configuration
2. Verify `MacHotkeys.app` was produced
3. Create `dist/` if needed
4. Remove any previous `dist/MacHotkeys-1.0.dmg`
5. Build a new compressed DMG with volume name **Mac Hotkeys**

Output:

```
dist/MacHotkeys-1.0.dmg
```

## Step-by-step

### 1. Build the app

`build_dmg.sh` runs Release via `xcodebuild`. The built app is expected at:

```
build/Build/Products/Release/MacHotkeys.app
```

### 2. Create the DMG

`build_dmg.sh` calls `create_dmg.sh`, which:

- Creates and mounts a temporary read-write DMG
- Copies `MacHotkeys.app` onto the volume
- Creates an `Applications` symlink for drag-and-drop install
- Sets the volume name to **Mac Hotkeys**
- Detaches the volume
- Converts to a compressed UDZO image at `dist/MacHotkeys-1.0.dmg`

### 3. Publish a GitHub Release

1. Tag the version (if not already tagged):

   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. Create a GitHub Release for that tag (website or `gh`):

   ```bash
   gh release create v1.0.0 \
     dist/MacHotkeys-1.0.dmg \
     --title "Mac Hotkeys 1.0" \
     --notes "Initial release of Mac Hotkeys."
   ```

3. Attach `dist/MacHotkeys-1.0.dmg` as the release asset (included above when using `gh`).

## Scripts

| Script | Purpose |
|--------|---------|
| `release/build_dmg.sh` | Full pipeline: build + package DMG |
| `release/create_dmg.sh` | Package an existing `.app` into the DMG |

## Install from DMG

1. Open `MacHotkeys-1.0.dmg`
2. Drag **MacHotkeys** into **Applications**
3. Launch from Applications (or Spotlight)
