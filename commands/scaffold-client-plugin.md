---
name: scaffold-client-plugin
description: Scaffolds clients/slug/discovery and an empty client plugin shell in the current workspace. Requires client slug and plugin name.
---

# Scaffold Client Plugin

Run from the **client workspace root** (the repo where `clients/<slug>/` should be created—not inside the plugin-factory install directory).

## Arguments

Ask the user for:

- `client_slug` (kebab-case)
- `plugin_name` (kebab-case)

## Execute

Run the scaffold script from the plugin-factory installation. Default Cursor local path:

```bash
"$HOME/.cursor/plugins/local/plugin-factory/scripts/scaffold-client-plugin.sh" \
  --client-slug <client_slug> \
  --plugin-name <plugin_name>
```

If plugin-factory is installed elsewhere, use that directory instead of `$HOME/.cursor/plugins/local/plugin-factory`.

The script uses the **current working directory** as the workspace root. `cd` to the client workspace before running if needed.

## After scaffold

Tell the user to run `/plugin-factory:super-parse-discovery` (if discovery not done) or `/plugin-factory:super-build-client-plugin` (if skill-map is approved).
