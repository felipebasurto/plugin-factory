# Adapter: Claude Plugin → Cursor Plugin

Use this checklist when converting a Claude-first client plugin to Cursor.

## Inputs

- Source: Claude plugin with `.claude-plugin/plugin.json` and `skills/`.
- Standards: [../best-practices/](../best-practices/) `01`-`08`.

## Copy as-is

- All `skills/<name>/SKILL.md` and supporting folders.
- `shared/` client-pack.

## Rewrite or add

### Manifest

1. Create `.cursor-plugin/plugin.json` from [../templates/plugin-cursor/.cursor-plugin/plugin.json](../templates/plugin-cursor/.cursor-plugin/plugin.json).
2. Map `name`, `version`, `description`, `author`, `keywords`, `logo` if applicable.

### Optional Cursor-only components

Only add if the delivery requires them:

- `rules/*.mdc` for persistent coding or writing standards.
- `agents/*.md` for specialized subagents.
- `commands/*.md` for explicit slash commands.
- `hooks/hooks.json` for format-on-save, audit, etc.
- `mcp.json` for MCP servers.

Do not add empty component folders.

### Paths

- Component dirs at plugin root, not inside `.cursor-plugin/`.
- Hook commands: use paths relative to plugin root (e.g. `./scripts/format.sh`).

### Install note for README

```markdown
Local install: copy plugin to ~/.cursor/plugins/local/<plugin-name>/ or add via team marketplace.
```

### README footer

```markdown
Generated from Claude canonical source on YYYY-MM-DD. Plugin version X.Y.Z. Regenerate via references/adapters/to-cursor.md.
```

## Do not

- Nest `skills/` under `.cursor-plugin/`.
- Duplicate long best-practices text inside SKILL files.

## Post-adaptation checklist

- [ ] Valid `.cursor-plugin/plugin.json`.
- [ ] Skills discovered under `skills/*/SKILL.md`.
- [ ] Frontmatter `name` and `description` on every skill.
- [ ] Test in Cursor; rules/agents/hooks if present.
- [ ] Subset of [08-review-checklist.md](../best-practices/08-review-checklist.md).

## Prompt for an agent (copy-paste)

```text
Adapt the Claude plugin at SOURCE_PATH to a Cursor plugin at DEST_PATH.

Follow references/adapters/to-cursor.md exactly.
Copy all skills and shared/ unchanged.
Create .cursor-plugin/plugin.json from references/templates/plugin-cursor/ (in plugin-factory) or client templates.
Add Cursor-only components only if listed in the request.
Add README footer with generation date and version.
```
