#!/usr/bin/env bash
# Validate skill-map.yaml and client plugin tree.
set -euo pipefail

PLUGIN_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
WORKSPACE_ROOT="$(pwd)"
CLIENT_SLUG=""
PLUGIN_NAME=""
ERRORS=0

warn() { echo "WARN: $*"; }
fail() { echo "ERROR: $*"; ERRORS=$((ERRORS + 1)); }

usage() {
  echo "Usage: $0 --client-slug <slug> --plugin-name <name> [--workspace-root <path>]"
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
SKILL_MAP="$CLIENT_DIR/discovery/skill-map.yaml"

echo "Validating: $CLIENT_DIR"
echo ""

if [[ ! -f "$SKILL_MAP" ]]; then
  fail "Missing skill-map: $SKILL_MAP"
else
  python3 - "$SKILL_MAP" <<'PY' || fail "skill-map.yaml failed Python checks"
import re, sys
path = sys.argv[1]
text = open(path, encoding="utf-8").read()
if "approved: true" not in text and "approved: true\n" not in text:
    print("skill-map not approved (Gate A pending)")
pilot = len(re.findall(r"pilot_candidate:\s*true", text))
if pilot != 1:
    print(f"expected exactly 1 pilot_candidate: true, found {pilot}")
if "build:" not in text:
    print("WARN: missing build: section (add build.mode per schema)")
print("skill-map.yaml: basic checks OK")
PY
fi

if [[ ! -d "$PLUGIN_DIR" ]]; then
  fail "Missing plugin directory: $PLUGIN_DIR"
  echo ""
  [[ $ERRORS -gt 0 ]] && exit 1
  exit 0
fi

if [[ ! -f "$PLUGIN_DIR/.claude-plugin/plugin.json" ]]; then
  fail "Missing .claude-plugin/plugin.json"
else
  python3 -c "import json; json.load(open('$PLUGIN_DIR/.claude-plugin/plugin.json'))" \
    || fail "Invalid plugin.json"
fi

if [[ ! -d "$PLUGIN_DIR/shared" ]]; then
  warn "Missing shared/"
fi

SKILLS_DIR="$PLUGIN_DIR/skills"
if [[ ! -d "$SKILLS_DIR" ]]; then
  fail "Missing skills/"
else
  shopt -s nullglob
  skill_dirs=("$SKILLS_DIR"/*/)
  if [[ ${#skill_dirs[@]} -eq 0 ]]; then
    warn "No skills under skills/ yet"
  fi
  for dir in "${skill_dirs[@]}"; do
    name="$(basename "$dir")"
    skill_md="$dir/SKILL.md"
    if [[ ! -f "$skill_md" ]]; then
      fail "Missing SKILL.md for $name"
      continue
    fi
    if ! grep -q '^name:' "$skill_md" || ! grep -q '^description:' "$skill_md"; then
      fail "$name: SKILL.md missing name or description frontmatter"
    fi
    if [[ -d "$dir/tests" ]]; then
      count=$(find "$dir/tests" -name '*.md' 2>/dev/null | wc -l | tr -d ' ')
      if [[ "$count" -lt 1 ]]; then
        warn "$name: tests/ has no .md cases"
      fi
    else
      warn "$name: no tests/ directory"
    fi
  done
fi

echo ""
if [[ $ERRORS -gt 0 ]]; then
  echo "Validation FAILED ($ERRORS error(s))"
  exit 1
fi
echo "Validation passed."
