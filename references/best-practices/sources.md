# Sources

This standard is distilled from upstream documentation and community signal. Use this file when you need to verify a claim, extend the standard, or update guidance after upstream changes.

## Anthropic Official

- Skill authoring best practices: [platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices). Source for: concision, degrees of freedom, frontmatter constraints, description rules, progressive disclosure, workflows and feedback loops, content guidelines, testing across models.
- Skills overview and structure: [platform.claude.com/docs/en/agents-and-tools/agent-skills/overview](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview). Source for: directory layout, runtime behavior, metadata pre-load.
- Equipping agents with Agent Skills: [anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills). Source for: progressive disclosure rationale, real-world usage examples.
- Create plugins guide: [code.claude.com/docs/en/plugins](https://code.claude.com/docs/en/plugins). Source for: when to use plugin vs standalone, quickstart, manifest fields, `--plugin-dir` development loop, `/reload-plugins`, conversion from `.claude/` to plugin, distribution paths.
- Claude Code plugins reference: [code.claude.com/docs/en/plugins-reference](https://code.claude.com/docs/en/plugins-reference). Source for: full manifest schema, component path rules, environment variables (`CLAUDE_PLUGIN_ROOT`, `CLAUDE_PLUGIN_DATA`, `CLAUDE_PROJECT_DIR`), `userConfig`, installation scopes, version management, caching, symlink rules.
- Anthropic plugin-dev skill on plugin structure: [github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/plugin-structure/SKILL.md](https://github.com/anthropics/claude-code/blob/main/plugins/plugin-dev/skills/plugin-structure/SKILL.md). Source for: hard rule that components must live at plugin root, not inside `.claude-plugin/`.
- Plugin marketplaces: [code.claude.com/docs/en/plugin-marketplaces](https://code.claude.com/docs/en/plugin-marketplaces). Source for: marketplace packaging and private distribution.

## Codex Official

- Codex Plugins overview: [developers.openai.com/codex/plugins](https://developers.openai.com/codex/plugins). Source for: plugin install model, `codex /plugins`, enable/disable via `~/.codex/config.toml`.
- Build Codex plugins: [developers.openai.com/codex/plugins/build](https://developers.openai.com/codex/plugins/build). Source for: `.codex-plugin/plugin.json`, manifest fields, `interface` metadata, marketplace files, `codex plugin marketplace add`, `$plugin-creator`, `PLUGIN_ROOT`/`PLUGIN_DATA`, plugin hooks under `[features].plugin_hooks`.
- Codex Agent Skills: [developers.openai.com/codex/skills](https://developers.openai.com/codex/skills). Source for: skill scopes (`.agents/skills`), explicit/implicit invocation, 2% context budget, optional `agents/openai.yaml` UI metadata.
- Codex slash commands: [developers.openai.com/codex/cli/slash-commands](https://developers.openai.com/codex/cli/slash-commands). Source for: `/plugins`, `/skills`, related CLI commands.

## Cursor Official

- Cursor Plugins reference: [cursor.com/docs/reference/plugins](https://cursor.com/docs/reference/plugins). Source for: `.cursor-plugin/plugin.json`, component discovery, rules/skills/agents/commands/hooks/MCP formats, multi-plugin repos and `.cursor-plugin/marketplace.json`, submission checklist.
- Cursor Plugins overview: [cursor.com/docs/plugins](https://cursor.com/docs/plugins). Source for: marketplace context, team and enterprise distribution.
- Plugin template repository: [github.com/cursor/plugin-template](https://github.com/cursor/plugin-template). Source for: starting scaffold.

## OpenWork Official

- OpenWork import a skill: [openworklabs.com/docs/start-here/do-work-with-it/import-a-skill](https://openworklabs.com/docs/start-here/do-work-with-it/import-a-skill). Source for: install flows (share links, paste-and-import, `/skill-creator`, OpenWork Cloud), workspace-local path `.opencode/skills/`, required frontmatter format.
- OpenWork architecture: [github.com/different-ai/openwork/blob/dev/ARCHITECTURE.md](https://github.com/different-ai/openwork/blob/dev/ARCHITECTURE.md). Source for: capability layer model, workspace mutations.
- OpenWork creating skills: [deepwiki.com/different-ai/openwork/3.3.2-creating-skills](https://deepwiki.com/different-ai/openwork/3.3.2-creating-skills). Source for: skill creation patterns and cloud sync model.

## Community Signal

- Reddit: "I tested 30 community Claude skills for a week" - [reddit.com/r/ClaudeAI/comments/1ok9v3d](https://www.reddit.com/r/ClaudeAI/comments/1ok9v3d/i_tested_30_community_claude_skills_for_a_week/). Source for: confirmation that procedure-encoding skills (TDD, debugging, worktrees, branch finishing, generating skills from documentation) outperform generic "be better" skills.
- Awesome Claude Skills: [github.com/ComposioHQ/awesome-claude-skills](https://github.com/ComposioHQ/awesome-claude-skills). Source for: catalog patterns, naming conventions, breadth of accepted use cases.

## Internal References

- `docs/soul/05-brain.md`: DMKINGS view on skills as part of a maintained operating brain.
- `docs/soul/10-governance-and-security.md`: governance rules that every skill must respect (human approval, data boundaries, isolation, logging, risk levels).
- `docs/soul/08-operating-model.md`: where skills fit inside the delivery flow and the internal agent system.

## How To Update This Standard

When upstream documentation or community practice changes:

1. Identify the affected file in `skills/docs/best-practices/`.
2. Update only the part that changed. Do not rewrite the whole document.
3. Add or update the source link here with a one-line note on what it informs.
4. If a change breaks existing skills, record it in the skill itself as an "Old patterns" section, not in this folder.

This folder is the standard. Skills are the implementation. Keep the two layers separate.
