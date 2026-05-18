# Adapter: Claude Plugin → Codex Plugin

Use this checklist when converting a Claude-first DMKINGS plugin to Codex. Do not re-author the workflow; adapt packaging and platform deltas only.

## Inputs

- Source: `skills/examples/<plugin>-claude/` or `clients/<client>/<plugin>/` with `.claude-plugin/` and `skills/`.
- Standards: [../best-practices/](../best-practices/) docs `01`-`08` for skill quality (unchanged).

## Copy as-is

- Every `skills/<name>/SKILL.md` body (Goal, Workflow, Rules, Output).
- `skills/<name>/references/`, `templates/`, `scripts/`, `assets/` if present.
- `shared/` client-pack files.

## Rewrite or add

### Manifest

1. Create `.codex-plugin/plugin.json` from [../templates/plugin-codex/.codex-plugin/plugin.json](../templates/plugin-codex/.codex-plugin/plugin.json).
2. Map fields from Claude manifest: `name`, `version`, `description`, `author`, `keywords`.
3. Add `"skills": "./skills/"` explicitly.
4. Optional: `"mcpServers": "./.mcp.json"`, `"hooks": "./hooks/hooks.json"`, `"interface": { ... }` for Codex app/catalog (see doc `10`).

### Hooks (if source has hooks)

Replace env vars in hook commands:

| Claude | Codex |
| ------ | ----- |
| `${CLAUDE_PLUGIN_ROOT}` | `${PLUGIN_ROOT}` |
| `${CLAUDE_PLUGIN_DATA}` | `${PLUGIN_DATA}` |

Enable plugin hooks in user config only if needed:

```toml
[features]
plugin_hooks = true
```

### Optional per-skill UI (Codex app)

For skills that need Codex app metadata, add `skills/<name>/agents/openai.yaml` per [Codex skills doc](https://developers.openai.com/codex/skills).

### Marketplace

Add entry to `.agents/plugins/marketplace.json` (repo) or `~/.agents/plugins/marketplace.json` (personal):

```json
{
  "name": "PLUGIN-NAME",
  "source": { "source": "local", "path": "./plugins/PLUGIN-NAME" },
  "policy": { "installation": "AVAILABLE", "authentication": "ON_INSTALL" },
  "category": "Productivity"
}
```

### README

Add footer to plugin README:

```markdown
Generated from Claude canonical source on YYYY-MM-DD. Plugin version X.Y.Z. Regenerate via references/adapters/to-codex.md; do not hand-edit SKILL bodies in this folder without syncing canonical.
```

## Do not

- Put `skills/` inside `.codex-plugin/`.
- Use absolute paths or `..` outside plugin root.
- Edit SKILL workflow to match Codex unless a Codex-specific bug forces it (document in CHANGELOG).

## Post-adaptation checklist

- [ ] `.codex-plugin/plugin.json` valid; `skills` at plugin root.
- [ ] All skills have `name` + `description` in frontmatter.
- [ ] Restart Codex; plugin appears in `/plugins`.
- [ ] Invoke each skill with `$skill-name` or implicit trigger test.
- [ ] Subset of [08-review-checklist.md](../best-practices/08-review-checklist.md) passed.

## Prompt for an agent (copy-paste)

```text
Adapt the Claude plugin at SOURCE_PATH to a Codex plugin at DEST_PATH.

Follow references/adapters/to-codex.md exactly.
Copy SKILL.md bodies and shared/ unchanged.
Create .codex-plugin/plugin.json from skills/templates/plugin-codex/.
Fix hook env vars if hooks exist.
Add README footer with generation date and canonical version.
Do not change workflow logic.
```
