#!/usr/bin/env bash
# Sync root skills/references/scripts into plugins/plugin-factory for Codex marketplace layout.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/plugins/plugin-factory"

rm -rf "$DEST/skills" "$DEST/references" "$DEST/scripts"
cp -R "$ROOT/skills" "$DEST/skills"
cp -R "$ROOT/references" "$DEST/references"
cp -R "$ROOT/scripts" "$DEST/scripts"
chmod +x "$DEST/scripts/"*.sh 2>/dev/null || true

echo "Synced to $DEST"
