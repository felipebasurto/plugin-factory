# DMKINGS Skill Templates

Empty scaffolds to **copy** when authoring a new skill or plugin. Not the same as [../examples/](../examples/), which are filled reference implementations.

Standards: [../docs/best-practices/](../docs/best-practices/)

| Template | Use |
| -------- | --- |
| `SKILL.md.template` | New skill body (Claude-first canonical) |
| `eval-case.md.template` | One test case per skill |
| `README-plugin.md.template` | Client-facing plugin README |
| `plugin-claude/` | Claude Code plugin shell (manifest + layout) |
| `plugin-codex/` | Codex shell only; prefer regenerating from Claude via adapter |
| `plugin-cursor/` | Cursor shell only; prefer regenerating from Claude via adapter |
| `client-pack/` | Empty `shared/` files with `REPLACE` markers |

Orchestration: use the [super-create-skill](../super-create-skill/SKILL.md) superskill (not a client-deliverable skill).
