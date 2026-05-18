# plugin-factory

Installable meta-plugin that turns discovery notes into client Claude/Cursor plugins—one approved skill at a time.

**Client deliverables** (`clients/<slug>/...`) are created in **your project workspace**, not inside this repository.

## Skills

| Skill | Invocation (Cursor / Claude) |
| ----- | ---------------------------- |
| `super-parse-discovery` | `/plugin-factory:super-parse-discovery` |
| `super-build-client-plugin` | `/plugin-factory:super-build-client-plugin` |
| `super-create-skill` | `/plugin-factory:super-create-skill` |

## Install from GitHub

```bash
git clone https://github.com/felipebasurto/plugin-factory.git
cd plugin-factory
```

### Cursor

```bash
cp -r "$(pwd)" ~/.cursor/plugins/local/plugin-factory
```

Reload plugins in Cursor, then use `@plugin-factory` or slash commands above.

### Claude Code

```bash
claude --plugin-dir /path/to/plugin-factory
```

Then `/reload-plugins`.

### OpenWork

OpenWork has no plugin manifest. Export each skill from `skills/*/SKILL.md` via [share.openworklabs.com](https://share.openworklabs.com) or install under `.opencode/skills/`. See [references/adapters/to-openwork.md](references/adapters/to-openwork.md).

## Typical workflow

1. Open a **client workspace** repo (with or without a `clients/` folder).
2. Run `super-parse-discovery` with notes → review `clients/<slug>/discovery/skill-map.yaml`.
3. Reply **OK skill-map** (Gate A).
4. Scaffold:

```bash
/path/to/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> --plugin-name <name>
```

Or use the Cursor command `scaffold-client-plugin` from this plugin.

5. Run `super-build-client-plugin` for skill 1; approve each `SKILL.md` (Gate B).

## Repository layout

```text
plugin-factory/          # this repo root = plugin root
├── skills/              # invocable superskills only
├── references/          # pipeline, catalog, templates, adapters, best-practices
├── scripts/
└── commands/            # Cursor command wrappers
```

## References

- [references/pipeline/runbook.md](references/pipeline/runbook.md)
- [references/catalog/conventions.md](references/catalog/conventions.md)
