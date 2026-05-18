# 11. Packaging As A Cursor Plugin

Cursor has its own plugin system. The manifest lives in `.cursor-plugin/plugin.json` and the plugin can bundle rules, skills, agents, commands, hooks, and MCP servers. This file is the standard for shipping skills as a Cursor plugin.

Skill authoring rules from `01`-`08` apply unchanged. The `SKILL.md` is portable.

## When To Use A Cursor Plugin

Use standalone `.cursor/` configuration when:

- The skill is personal or repo-local.
- You are still iterating.

Use a Cursor plugin when:

- You want shareable, versioned distribution.
- You want to bundle skills with rules, agents, commands, hooks, or MCP servers in one package.
- You want to submit to the Cursor Marketplace or a private team marketplace.

Default for DMKINGS deliverables on Cursor: plugin.

## Minimum Plugin Layout

```text
plugin-name/
├── .cursor-plugin/
│   └── plugin.json
└── skills/
    └── skill-name/
        └── SKILL.md
```

Hard rules:

- `plugin.json` must live inside `.cursor-plugin/`.
- Component directories live at the plugin root.
- Plugin folder name should match the `name` field.

## Full Plugin Layout

```text
plugin-name/
├── .cursor-plugin/
│   └── plugin.json
├── README.md
├── LICENSE
├── rules/                    # .mdc files
├── skills/                   # subdirectories with SKILL.md
├── agents/                   # custom agent definitions
├── commands/                 # agent-executable commands
├── hooks/
│   └── hooks.json
├── mcp.json                  # MCP servers, optional
├── assets/
│   └── logo.svg
└── scripts/                  # hook and utility scripts
```

Only include directories that have real files.

## plugin.json Manifest

Required field: `name`.

Minimum manifest:

```json
{
  "name": "plugin-name",
  "description": "Reusable workflow for X.",
  "version": "1.0.0"
}
```

Recommended manifest:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Reusable workflow for X.",
  "author": {
    "name": "DMKINGS",
    "email": "contact@dmkings.example"
  },
  "homepage": "https://dmkings.example/plugins/plugin-name",
  "repository": "https://github.com/dmkings/plugin-name",
  "license": "MIT",
  "keywords": ["dmkings", "workflow"],
  "logo": "assets/logo.svg"
}
```

Optional component path fields when defaults need to be overridden:

```json
{
  "rules": "./rules/",
  "skills": "./skills/",
  "agents": "./agents/",
  "commands": "./commands/",
  "hooks": "./hooks/hooks.json",
  "mcpServers": "./mcp.json"
}
```

Field notes:

- `name`: lowercase kebab-case. Periods are allowed (`prompts.chat`). Must start and end with an alphanumeric character.
- `version`: semver string.
- `logo`: relative path inside the repo. Cursor resolves it to a raw GitHub URL based on the commit SHA. Commit the logo, do not link external URLs unless necessary.
- Specifying a component path replaces folder discovery for that component. The default folder is not also scanned.

## Component Discovery

If you do not set a path in the manifest, Cursor discovers components automatically:

| Component   | Default location  | How it is discovered                                              |
| ----------- | ----------------- | ----------------------------------------------------------------- |
| Skills      | `skills/`         | Each subdirectory containing a `SKILL.md`                         |
| Rules       | `rules/`          | All `.md`, `.mdc`, or `.markdown` files                           |
| Agents      | `agents/`         | All `.md`, `.mdc`, or `.markdown` files                           |
| Commands    | `commands/`       | All `.md`, `.mdc`, `.markdown`, or `.txt` files                   |
| Hooks       | `hooks/hooks.json` | Parsed for hook event names                                       |
| MCP servers | `mcp.json`        | Parsed for server entries                                         |
| Root skill  | `SKILL.md` at root | Treated as a single-skill plugin if no `skills/` and no manifest field |

## Rules

Rules are `.mdc` files in `rules/` that give persistent AI guidance:

```markdown
---
description: Prefer const over let when the variable is never reassigned.
alwaysApply: true
---

Always use `const` for variables that are never reassigned. Use `let` only when reassignment is required. Never use `var`.
```

Frontmatter:

- `description`: short purpose.
- `alwaysApply`: `true` applies the rule globally; `false` keeps it available on request.
- `globs`: file patterns where the rule applies (`"**/*.ts"`).

## Skills

Skills follow the same `SKILL.md` format as Claude and Codex:

```markdown
---
name: api-designer
description: Designs RESTful APIs following OpenAPI 3.0. Use when designing new endpoints, reviewing contracts, or generating API documentation.
---

# API Designer

## When to use

[...]

## Instructions

[...]
```

Frontmatter:

- `name`: lowercase kebab-case.
- `description`: third person, with what and when.

The full authoring standard in `01`-`08` applies.

## Agents

Agents are `.md` files in `agents/` defining specialized behaviors:

```markdown
---
name: security-reviewer
description: Security-focused code reviewer for vulnerabilities, auth, and dependency risk.
---

# Security Reviewer

You are a security-focused reviewer. When reviewing code:

1. Check for injection (SQL, XSS, command).
2. Verify auth and authorization.
3. Look for sensitive data exposure.
4. Review dependency security.
```

## Commands

Commands are agent-executable actions in `commands/`. They support `.md`, `.mdc`, `.markdown`, and `.txt`:

```markdown
---
name: deploy-staging
description: Deploys the current branch to staging.
---

# Deploy To Staging

1. Run tests.
2. Build the project.
3. Push to staging branch.
```

## Hooks

Hooks live in `hooks/hooks.json` and respond to agent, tab, and workspace events:

```json
{
  "hooks": {
    "afterFileEdit": [
      { "command": "./scripts/format-code.sh" }
    ],
    "beforeShellExecution": [
      { "command": "./scripts/validate-shell.sh", "matcher": "rm|curl|wget" }
    ],
    "sessionEnd": [
      { "command": "./scripts/audit.sh" }
    ]
  }
}
```

Available events include agent hooks (`sessionStart`, `sessionEnd`, `preToolUse`, `postToolUse`, `beforeShellExecution`, `afterShellExecution`, `beforeMCPExecution`, `afterMCPExecution`, `beforeReadFile`, `afterFileEdit`, `beforeSubmitPrompt`, `stop`, `afterAgentResponse`, `afterAgentThought`), tab hooks (`beforeTabFileRead`, `afterTabFileEdit`), and app lifecycle (`workspaceOpen`).

## MCP Servers

The `mcp.json` at the plugin root is detected automatically. Only set `mcpServers` in `plugin.json` if you use a custom path or inline config.

```json
{
  "mcpServers": {
    "postgres": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-postgres"],
      "env": {
        "POSTGRES_CONNECTION_STRING": "${POSTGRES_URL}"
      }
    }
  }
}
```

## Multi-Plugin Repositories

A single Git repository can host multiple plugins via a marketplace manifest at `.cursor-plugin/marketplace.json` in the repo root:

```json
{
  "name": "dmkings-marketplace",
  "owner": {
    "name": "DMKINGS",
    "email": "plugins@dmkings.example"
  },
  "metadata": {
    "description": "DMKINGS plugins for industrial AI workflows."
  },
  "plugins": [
    { "name": "plugin-one", "source": "plugin-one", "description": "First plugin" },
    { "name": "plugin-two", "source": "plugin-two", "description": "Second plugin" }
  ]
}
```

Each `source` is a path inside the repo. The per-plugin `plugin.json` merges with the marketplace entry; manifest values win.

Layout:

```text
dmkings-marketplace/
├── .cursor-plugin/
│   └── marketplace.json
├── plugin-one/
│   ├── .cursor-plugin/
│   │   └── plugin.json
│   └── skills/
└── plugin-two/
    ├── .cursor-plugin/
    │   └── plugin.json
    └── rules/
```

## Submission Checklist

Before submitting to the Cursor Marketplace (`cursor.com/marketplace/publish`) or a team marketplace:

- Valid `.cursor-plugin/plugin.json` manifest.
- `name` is unique, lowercase, kebab-case.
- `description` explains the plugin clearly.
- Rules, skills, agents, and commands have proper frontmatter.
- Logo committed to the repo and referenced by relative path.
- `README.md` documents usage and configuration.
- All manifest paths are relative and valid. No `..`, no absolute paths.
- Plugin tested locally end to end.
- For multi-plugin repos: `marketplace.json` at the repo root with unique plugin names.

## Local Development Loop

1. Put the plugin under `~/.cursor/plugins/local/plugin-name/` (immediately available to Cursor) or inside a project directory.
2. Open Cursor and verify the plugin and its components load.
3. Iterate. Cursor picks up most changes on restart.

The `create-plugin-scaffold` skill in this environment can scaffold a valid plugin if you want a starting point.

## Anti-Patterns Specific To Cursor

- Putting `skills/` or other component folders inside `.cursor-plugin/`. They will not be discovered.
- Hardcoded absolute paths in hook scripts. Use paths relative to the plugin root.
- Pointing `logo` at an external URL when a committed asset would work. The relative path is more stable.
- Setting `alwaysApply: true` on rules that should be opt-in. Heavy rules become noise across unrelated files.
- Mixing skills, rules, agents, and commands without clear separation in `README.md`. Reviewers cannot evaluate the plugin.
- Mixing client-specific knowledge into a public marketplace plugin.
