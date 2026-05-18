# 09. Packaging As A Claude Code Plugin

A plugin is how a set of skills becomes shareable, versioned, and installable. This file is the standard for turning a skill folder into a Claude Code plugin without surprises.

This document covers Claude Code packaging only. Skill authoring is covered in `01`-`08`. For Codex, Cursor, and OpenWork packaging, see `10`, `11`, and `12`.

## When To Use A Plugin

Use standalone `.claude/` configuration when:

- The skill is personal or project-only.
- The skill is an experiment that may not survive a week.
- Short names like `/hello` are fine.

Use a plugin when:

- The skill must be shared across projects, teams, or clients.
- The skill needs versioned releases.
- The skill will be distributed via marketplace or as a `.zip`.
- Namespaced names like `/plugin-name:skill-name` are acceptable and even desirable.

Default for DMKINGS deliverables: plugin. Standalone is the prototype mode.

## Minimum Plugin Layout

```text
plugin-name/
├── .claude-plugin/
│   └── plugin.json
└── skills/
    └── skill-name/
        └── SKILL.md
```

Hard rules:

- `plugin.json` must live inside `.claude-plugin/`.
- Component directories (`skills/`, `agents/`, `commands/`, `hooks/`, `bin/`, `settings.json`) must live at the plugin root, not inside `.claude-plugin/`.
- Plugin folder name should match the `name` field in `plugin.json`.

A common mistake is to put `skills/` inside `.claude-plugin/`. The plugin will appear to load but components will not be discovered.

## Full Plugin Layout

```text
plugin-name/
├── .claude-plugin/
│   └── plugin.json
├── README.md
├── LICENSE
├── skills/
│   ├── skill-one/
│   │   ├── SKILL.md
│   │   ├── references/
│   │   ├── templates/
│   │   ├── assets/
│   │   └── scripts/
│   └── skill-two/
│       └── SKILL.md
├── agents/                 # only if the plugin ships agents
├── hooks/
│   └── hooks.json          # only if the plugin ships hooks
├── commands/               # flat .md commands, optional
├── bin/                    # executables added to PATH while enabled
├── settings.json           # default settings, optional
├── .mcp.json               # MCP server config, optional
└── shared/                 # cross-skill resources owned by the plugin
```

Only include directories that actually have files. Empty folders are noise.

## plugin.json Manifest

The manifest is optional. If omitted, Claude Code auto-discovers components from default locations and uses the directory name as the plugin name. Include a manifest when metadata or custom paths matter, which is almost always for DMKINGS.

Minimum manifest:

```json
{
  "name": "plugin-name",
  "description": "One-sentence purpose, under 200 characters.",
  "version": "1.0.0",
  "author": {
    "name": "DMKINGS"
  }
}
```

Recommended manifest for a serious deliverable:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "One-sentence purpose, under 200 characters.",
  "author": {
    "name": "DMKINGS",
    "email": "contact@dmkings.example",
    "url": "https://dmkings.example"
  },
  "homepage": "https://dmkings.example/plugins/plugin-name",
  "repository": "https://github.com/dmkings/plugin-name",
  "license": "MIT",
  "keywords": ["dmkings", "workflow"]
}
```

Field notes:

- `name`: unique kebab-case identifier. Becomes the skill namespace prefix, for example `/plugin-name:skill-name`.
- `version`: when set, users only receive updates when this string changes. If omitted on git-distributed plugins, the commit SHA is used and every commit is a new version. Always set `version` for shipped plugins.
- `description`: shown in the plugin manager. Keep under 200 characters.
- `author`, `homepage`, `repository`, `license`, `keywords`: optional but strongly recommended.

## Component Path Rules

Default discovery scans `skills/`, `agents/`, `commands/`, `hooks/hooks.json`, `.mcp.json`, and other defaults at the plugin root.

You can override paths in the manifest, but be careful:

- `skills` field adds to the default `skills/` directory.
- `commands`, `agents`, `outputStyles`, `experimental.themes`, `experimental.monitors` replace defaults. To keep both, list them explicitly: `"commands": ["./commands/", "./extras/"]`.
- All paths must be relative and start with `./`.
- No parent traversal. `../shared-utils` will not work after installation because external files are not copied into the cache.

If you need to share files between skills inside the same plugin, use a top-level `shared/` folder owned by the plugin and reference it from each `SKILL.md`. Do not cross plugin boundaries.

## Namespacing

Plugin skills are always invoked with the plugin name as prefix:

```text
/plugin-name:skill-name
```

This prevents conflicts between plugins. To change the prefix, change the `name` field in `plugin.json`. There is no way to remove the prefix.

## Environment Variables

Three variables are available in skill content, agent content, hook commands, MCP server configs, monitor commands, and as environment variables for subprocesses:

- `${CLAUDE_PLUGIN_ROOT}`: absolute path to the plugin's installation directory. Use this to reference scripts and assets bundled with the plugin. Path changes when the plugin updates. Treat it as ephemeral, never write state here.
- `${CLAUDE_PLUGIN_DATA}`: persistent directory that survives updates. Use it for installed dependencies, caches, and other files that must persist across versions. Created on first reference.
- `${CLAUDE_PROJECT_DIR}`: the project root where Claude Code was launched.

Always wrap these variables in double quotes when used in shell commands to handle paths with spaces.

## User Configuration

When the plugin needs user-specific values like API endpoints or tokens, declare them in `userConfig`:

```json
{
  "userConfig": {
    "api_endpoint": {
      "type": "string",
      "title": "API endpoint",
      "description": "Your team's API endpoint",
      "required": true
    },
    "api_token": {
      "type": "string",
      "title": "API token",
      "description": "API authentication token",
      "sensitive": true
    }
  }
}
```

Notes:

- Sensitive values go to the system keychain (or `~/.claude/.credentials.json` if no keychain). Keep them small, the keychain budget is around 2 KB total per scope.
- Non-sensitive values are stored in `settings.json` and can be substituted in skill or agent content as `${user_config.api_endpoint}`.
- All values are exported as `CLAUDE_PLUGIN_OPTION_*` to subprocesses.

Use `userConfig` instead of asking users to hand-edit settings.

## Local Development Loop

While building a plugin, run Claude Code with the local plugin directory:

```bash
claude --plugin-dir ./plugin-name
```

After editing files, reload without restarting:

```text
/reload-plugins
```

Reload picks up updates for skills, agents, hooks, MCP servers, and LSP servers. Monitors require restart.

To test multiple plugins together, repeat the flag:

```bash
claude --plugin-dir ./plugin-one --plugin-dir ./plugin-two
```

For zipped or hosted plugins:

```bash
claude --plugin-dir ./plugin-name.zip
claude --plugin-url https://example.com/plugin-name.zip
```

When a `--plugin-dir` plugin shares a name with an installed marketplace plugin, the local copy wins for that session.

## Installation Scopes

Plugins install into one of four scopes:

- `user`: `~/.claude/settings.json`. Personal, available across all projects.
- `project`: `.claude/settings.json`. Team-shared via version control.
- `local`: `.claude/settings.local.json`. Per-project, gitignored.
- `managed`: managed settings file. Read-only, update only.

Pick the scope that matches the customer's adoption pattern. For client-shipped plugins, `project` is usually right because it travels with the repository.

## Versioning

Set `version` in `plugin.json` for any plugin that leaves the laptop. Without it, Claude Code uses the commit SHA and every commit is treated as a new version, which floods users with updates.

Use semantic versioning:

- Bump patch for fixes and clarifications inside skills.
- Bump minor for new skills, new templates, or new tools that do not break existing usage.
- Bump major for renames, removed skills, changed output contracts, or any breaking change.

Document changes in a `CHANGELOG.md` at the plugin root. Reviewers should be able to read the changelog and decide whether to upgrade in under a minute.

## README

Every plugin must ship a `README.md` at the plugin root. Minimum content:

- One-paragraph purpose.
- List of skills with their invocation names.
- Install instructions for local use, project scope, and marketplace if applicable.
- Required user configuration with examples.
- Known limitations.
- Link to the changelog.

## Distribution Options

Three realistic paths for DMKINGS:

1. Private git repository. Clients install via `--plugin-dir` from a cloned repo or via a private marketplace. Most common for early engagements.
2. Private marketplace. A marketplace repo lists plugins and supports installation through `/plugin install`. Best for clients with multiple plugins.
3. Official marketplace. Submit through the in-app forms on `claude.ai` or `platform.claude.com`. Only for generic, non-client plugins.

Avoid public distribution of client-specific knowledge packs. Generic skills can be public, client packs cannot.

## Validation Before Shipping

Before merging or releasing:

- Run `claude --plugin-dir ./plugin-name` and load every skill at least once.
- Run `/reload-plugins` after a small edit and confirm it picks up.
- Confirm every skill has the required structure from `02-skill-structure.md`.
- Confirm every skill passes its tests from `06-testing-skills.md`.
- Confirm the manifest fields are present and accurate.
- Confirm `${CLAUDE_PLUGIN_ROOT}` is used for any bundled script paths.
- Confirm no path uses parent traversal.
- Confirm `README.md` and `CHANGELOG.md` are up to date.

A plugin that does not pass this list is not ready to ship.

## Anti-Patterns Specific To Plugins

- Putting `skills/` inside `.claude-plugin/`. The plugin will appear to load and nothing will work.
- Omitting `version` and shipping anyway. Users get an update on every commit.
- Hardcoded absolute paths in `SKILL.md` or scripts. Will break on the user's machine.
- Sharing files across plugin boundaries with `../`. Will fail after install because external files are not copied to the cache.
- Putting sensitive defaults in `settings.json` instead of `userConfig` with `sensitive: true`. Leaks credentials into version control.
- Mixing generic skills and client-specific knowledge in the same plugin. Splits poorly when the client changes.
- Shipping a plugin without `README.md`. Adoption dies on contact.
