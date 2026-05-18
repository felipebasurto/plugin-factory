#!/usr/bin/env bash
# Bootstrap client workspace: scaffold plugin shell, optional Gate A approval, next-step prompts.
set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE_ROOT="$(pwd)"
CLIENT_SLUG=""
PLUGIN_NAME=""
APPROVE_GATE_A=false
SCAFFOLD_ONLY=false

usage() {
  cat <<EOF
Usage: $0 --client-slug <slug> --plugin-name <name> [options]

Options:
  --workspace-root <path>   Workspace containing clients/ (default: cwd)
  --approve-gate-a        Set skill-map.yaml approved: true (requires existing map)
  --scaffold-only         Run scaffold only; do not print build prompts
  -h, --help

Examples:
  $0 --client-slug hiperbaric --plugin-name hiperbaric-workflows
  $0 --client-slug hiperbaric --plugin-name hiperbaric-workflows --approve-gate-a
EOF
  exit 1
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --client-slug) CLIENT_SLUG="$2"; shift 2 ;;
    --plugin-name) PLUGIN_NAME="$2"; shift 2 ;;
    --workspace-root) WORKSPACE_ROOT="$(cd "$2" && pwd)"; shift 2 ;;
    --approve-gate-a) APPROVE_GATE_A=true; shift ;;
    --scaffold-only) SCAFFOLD_ONLY=true; shift ;;
    -h|--help) usage ;;
    *) echo "Unknown option: $1"; usage ;;
  esac
done

[[ -n "$CLIENT_SLUG" && -n "$PLUGIN_NAME" ]] || usage

CLIENT_DIR="$WORKSPACE_ROOT/clients/$CLIENT_SLUG"
PLUGIN_DIR="$CLIENT_DIR/$PLUGIN_NAME"
SKILL_MAP="$CLIENT_DIR/discovery/skill-map.yaml"
SCAFFOLD="$PLUGIN_ROOT/scripts/scaffold-client-plugin.sh"

echo "Workspace: $WORKSPACE_ROOT"
echo "Client:    $CLIENT_SLUG"
echo "Plugin:    $PLUGIN_NAME"
echo ""

if [[ -d "$PLUGIN_DIR" ]]; then
  echo "Plugin directory already exists (skipping scaffold): $PLUGIN_DIR"
else
  "$SCAFFOLD" --client-slug "$CLIENT_SLUG" --plugin-name "$PLUGIN_NAME" --workspace-root "$WORKSPACE_ROOT"
  echo ""
fi

if [[ "$APPROVE_GATE_A" == true ]]; then
  if [[ ! -f "$SKILL_MAP" ]]; then
    echo "Error: skill-map not found: $SKILL_MAP"
    echo "Run super-parse-discovery first."
    exit 1
  fi
  python3 - "$SKILL_MAP" "${USER:-cli}" <<'PY'
import sys
from datetime import date

path, by = sys.argv[1], sys.argv[2]
text = open(path, encoding="utf-8").read()
lines = text.splitlines()
out = []
for line in lines:
    if line.startswith("approved:"):
        out.append("approved: true")
    elif line.startswith("approved_at:"):
        out.append(f'approved_at: "{date.today().isoformat()}"')
    elif line.startswith("approved_by:"):
        out.append(f'approved_by: "{by}"')
    else:
        out.append(line)
open(path, "w", encoding="utf-8").write("\n".join(out) + ("\n" if text.endswith("\n") else ""))
print(f"Gate A: approved skill-map at {path}")
PY
  echo ""
fi

if [[ "$SCAFFOLD_ONLY" == true ]]; then
  exit 0
fi

if [[ ! -f "$SKILL_MAP" ]]; then
  echo "=== Next: parse discovery ==="
  echo ""
  cat <<EOF
/plugin-factory:super-parse-discovery

Client slug: $CLIENT_SLUG
Plugin name: $PLUGIN_NAME
Discovery: @clients/$CLIENT_SLUG/discovery/raw/notes.md

Produce intake.md, process-map.md, skill-map.yaml (max 10 skills).
Set build.mode: phase_1. Map to catalog/base/.
EOF
  exit 0
fi

if grep -q '^approved: false' "$SKILL_MAP" 2>/dev/null || grep -q '^approved: false$' "$SKILL_MAP" 2>/dev/null; then
  echo "=== Next: Gate A ==="
  echo "Review $SKILL_MAP then run:"
  echo "  $0 --client-slug $CLIENT_SLUG --plugin-name $PLUGIN_NAME --approve-gate-a"
  echo "Or reply in Codex: OK skill-map"
  echo ""
fi

echo "=== Next: build skill 1 (Gate B) ==="
cat <<EOF
/plugin-factory:super-build-client-plugin

Client slug: $CLIENT_SLUG
Plugin name: $PLUGIN_NAME
skill-map approved. Respect build.mode (phase_1 default). Scaffold if missing.
Generate ONLY the next pending skill in scope. STOP for SKILL.md approval.

Validate when done:
  $PLUGIN_ROOT/scripts/validate-client-plugin.sh \\
    --client-slug $CLIENT_SLUG --plugin-name $PLUGIN_NAME \\
    --workspace-root $WORKSPACE_ROOT
EOF
