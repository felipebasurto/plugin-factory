---
name: new-client-plugin
description: Bootstraps a client plugin workspace — scaffold shell, optional Gate A approval on skill-map, and prints next Codex prompts. Use after super-parse-discovery or when starting build from an approved map.
---

# New Client Plugin

Run from the **client workspace root** (where `clients/<slug>/` should live).

## Arguments

Ask the user for:

- `client_slug` (kebab-case)
- `plugin_name` (kebab-case)
- Whether to approve Gate A now (`--approve-gate-a`) — only if skill-map already reviewed

## Execute

```bash
"$HOME/.cursor/plugins/local/plugin-factory/scripts/new-client-plugin.sh" \
  --client-slug <client_slug> \
  --plugin-name <plugin_name> \
  [--approve-gate-a]
```

Use the actual plugin-factory install path if not under `~/.cursor/plugins/local/`.

Run with `cwd` = client workspace root.

## After script output

- If discovery not parsed → run `/plugin-factory:super-parse-discovery`
- If Gate A pending → user reviews skill-map, then re-run with `--approve-gate-a`
- If build prompt printed → run `/plugin-factory:super-build-client-plugin` as shown
