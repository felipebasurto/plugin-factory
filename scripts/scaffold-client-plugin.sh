#!/usr/bin/env bash
set -euo pipefail

# Plugin root (where references/ and scripts/ live)
PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE_ROOT="$(pwd)"
CLIENT_SLUG=""
PLUGIN_NAME=""

usage() {
  echo "Usage: $0 --client-slug <slug> --plugin-name <name> [--workspace-root <path>]"
  echo "  Creates <workspace>/clients/<slug>/discovery/ and client plugin shell."
  echo "  Default workspace root: current working directory ($(pwd))."
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --client-slug) CLIENT_SLUG="$2"; shift 2 ;;
    --plugin-name) PLUGIN_NAME="$2"; shift 2 ;;
    --workspace-root) WORKSPACE_ROOT="$(cd "$2" && pwd)"; shift 2 ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

[[ -n "$CLIENT_SLUG" && -n "$PLUGIN_NAME" ]] || usage

CLIENT_DIR="$WORKSPACE_ROOT/clients/$CLIENT_SLUG"
PLUGIN_DIR="$CLIENT_DIR/$PLUGIN_NAME"
DISCOVERY_DIR="$CLIENT_DIR/discovery"
TEMPLATES="$PLUGIN_ROOT/references/templates"

if [[ ! -d "$TEMPLATES" ]]; then
  echo "Error: templates not found at $TEMPLATES"
  echo "Is plugin-factory installed correctly?"
  exit 1
fi

if [[ -d "$PLUGIN_DIR" ]]; then
  echo "Plugin directory already exists: $PLUGIN_DIR"
  echo "Remove it first or use a different --plugin-name."
  exit 1
fi

mkdir -p "$DISCOVERY_DIR/raw"
mkdir -p "$PLUGIN_DIR/skills"
mkdir -p "$PLUGIN_DIR/shared"

mkdir -p "$PLUGIN_DIR/.claude-plugin"
sed "s/REPLACE-plugin-name/$PLUGIN_NAME/g" \
  "$TEMPLATES/plugin-claude/.claude-plugin/plugin.json" \
  > "$PLUGIN_DIR/.claude-plugin/plugin.json"

cp "$TEMPLATES/client-pack/"*.md "$PLUGIN_DIR/shared/"

sed -e "s/REPLACE Plugin Display Name/$PLUGIN_NAME/g" \
    -e "s/PLUGIN-NAME/$PLUGIN_NAME/g" \
    -e "s/REPLACE-plugin-folder/$PLUGIN_NAME/g" \
    "$TEMPLATES/README-plugin.md.template" \
    > "$PLUGIN_DIR/README.md"

touch "$DISCOVERY_DIR/raw/.gitkeep"
if [[ ! -f "$DISCOVERY_DIR/intake.md" ]]; then
  if [[ -f "$PLUGIN_ROOT/references/delivery/discovery-intake.md" ]]; then
    cp "$PLUGIN_ROOT/references/delivery/discovery-intake.md" "$DISCOVERY_DIR/intake.md"
  else
    touch "$DISCOVERY_DIR/intake.md"
  fi
fi

echo "Workspace: $WORKSPACE_ROOT"
echo "Created:"
echo "  $DISCOVERY_DIR/"
echo "  $PLUGIN_DIR/"
echo ""
echo "Next: /plugin-factory:super-parse-discovery then super-build-client-plugin."
