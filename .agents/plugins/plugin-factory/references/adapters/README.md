# Platform Adapters

plugin-factory uses a **Claude-first** canonical format. The source of truth is `SKILL.md` (and `shared/`, `references/`, `templates/`, `scripts/`) inside a Claude plugin or skill folder.

Codex, Cursor, and OpenWork outputs are **generated artifacts**. Regenerate on major releases. Do not maintain parallel hand-edited copies unless there is a documented platform-specific exception.

| Adapter | Target |
| ------- | ------ |
| [to-codex.md](to-codex.md) | OpenAI Codex plugin |
| [to-cursor.md](to-cursor.md) | Cursor plugin |
| [to-openwork.md](to-openwork.md) | OpenWork workspace skill |

Packaging references:

- Claude: [../best-practices/09-packaging-claude-plugin.md](../best-practices/09-packaging-claude-plugin.md)
- Codex: [../best-practices/10-packaging-codex-plugin.md](../best-practices/10-packaging-codex-plugin.md)
- Cursor: [../best-practices/11-packaging-cursor-plugin.md](../best-practices/11-packaging-cursor-plugin.md)
- OpenWork: [../best-practices/12-packaging-openwork-skill.md](../best-practices/12-packaging-openwork-skill.md)
