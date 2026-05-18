#!/usr/bin/env bash
# Sync root skills/references/scripts into .agents/plugins/plugin-factory for Codex.
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
DEST="$ROOT/.agents/plugins/plugin-factory"

mkdir -p "$DEST/.codex-plugin"
rm -rf "$DEST/skills" "$DEST/references" "$DEST/scripts"
cp -R "$ROOT/skills" "$DEST/skills"
cp -R "$ROOT/references" "$DEST/references"
cp -R "$ROOT/scripts" "$DEST/scripts"
chmod +x "$DEST/scripts/"*.sh 2>/dev/null || true

if [[ ! -f "$DEST/.codex-plugin/plugin.json" ]]; then
  cp "$ROOT/references/templates/plugin-codex/.codex-plugin/plugin.json" "$DEST/.codex-plugin/plugin.json"
  # Ensure name matches
  sed -i '' 's/REPLACE-plugin-name/plugin-factory/g' "$DEST/.codex-plugin/plugin.json" 2>/dev/null || \
    sed -i 's/REPLACE-plugin-name/plugin-factory/g' "$DEST/.codex-plugin/plugin.json"
fi

echo "Synced Codex package to $DEST"
