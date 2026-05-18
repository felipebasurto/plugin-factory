# 10. Packaging As A Codex Plugin

OpenAI Codex has its own plugin system. The shape is similar to Claude Code, but the conventions, manifest fields, and distribution model are different. This file is the standard for shipping skills as a Codex plugin.

Skill authoring rules from `01`-`08` apply unchanged. Codex skills follow the same open Agent Skills standard as Claude, so the `SKILL.md` itself is portable.

## When To Use A Codex Plugin

Use a direct skill folder under `.agents/skills/` when:

- The skill is local to one repo or one personal workflow.
- The skill is an experiment.

Use a Codex plugin when:

- You want to share the skill across teams or repos.
- You want to bundle skills with app integrations or MCP servers.
- You want lifecycle hooks tied to the skill.
- You want a stable, versioned package distributed via a marketplace.

Default for DMKINGS deliverables on Codex: plugin.

## Minimum Plugin Layout

```text
plugin-name/
├── .codex-plugin/
│   └── plugin.json
└── skills/
    └── skill-name/
        └── SKILL.md
```

Hard rules:

- `plugin.json` must live inside `.codex-plugin/`.
- All component directories (`skills/`, `hooks/`, `assets/`) live at the plugin root, not inside `.codex-plugin/`.
- Plugin folder name should match the `name` field.

## Full Plugin Layout

```text
plugin-name/
├── .codex-plugin/
│   └── plugin.json
├── README.md
├── LICENSE
├── skills/
│   └── skill-name/
│       ├── SKILL.md
│       ├── references/
│       ├── templates/
│       ├── assets/
│       └── scripts/
├── hooks/
│   └── hooks.json
├── .app.json                # app/connector mapping, optional
├── .mcp.json                # MCP server configuration, optional
├── assets/
│   ├── logo.png
│   ├── icon.png
│   └── screenshot-1.png
└── shared/                  # cross-skill resources, optional
```

Only include directories that have real files.

## plugin.json Manifest

Minimum manifest:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Reusable workflow for X.",
  "skills": "./skills/"
}
```

Recommended manifest for a serious deliverable:

```json
{
  "name": "plugin-name",
  "version": "1.0.0",
  "description": "Bundle reusable skills and app integrations for X.",
  "author": {
    "name": "DMKINGS",
    "email": "contact@dmkings.example",
    "url": "https://dmkings.example"
  },
  "homepage": "https://dmkings.example/plugins/plugin-name",
  "repository": "https://github.com/dmkings/plugin-name",
  "license": "MIT",
  "keywords": ["dmkings", "workflow"],
  "skills": "./skills/",
  "mcpServers": "./.mcp.json",
  "apps": "./.app.json",
  "hooks": "./hooks/hooks.json",
  "interface": {
    "displayName": "Plugin Name",
    "shortDescription": "One-line summary",
    "longDescription": "Two or three sentence summary.",
    "developerName": "DMKINGS",
    "category": "Productivity",
    "capabilities": ["Read", "Write"],
    "websiteURL": "https://dmkings.example",
    "privacyPolicyURL": "https://dmkings.example/privacy",
    "termsOfServiceURL": "https://dmkings.example/terms",
    "defaultPrompt": [
      "Use Plugin Name to summarize new CRM notes.",
      "Use Plugin Name to triage customer follow-ups."
    ],
    "brandColor": "#10A37F",
    "composerIcon": "./assets/icon.png",
    "logo": "./assets/logo.png",
    "screenshots": ["./assets/screenshot-1.png"]
  }
}
```

Field notes:

- `name`: kebab-case identifier. Becomes the plugin identifier and component namespace.
- `version`: required for published plugins. Use semver.
- `skills`, `mcpServers`, `apps`, `hooks`: relative paths to bundled components, must start with `./`.
- `interface`: presentation metadata for install surfaces (CLI, IDE, Codex app).

## Path Rules

- All manifest paths are relative to the plugin root and start with `./`.
- Visual assets live under `./assets/`.
- `skills` points to a folder of skill folders.
- `apps` points to `.app.json`. `mcpServers` points to `.mcp.json`.
- `hooks` points to a hooks file. Plugin hooks are off by default; enable with `[features].plugin_hooks = true` in `~/.codex/config.toml`.

## Skill Discovery Locations Outside Plugins

For reference, Codex reads skills from four scopes when not packaged as a plugin:

| Scope    | Location                       |
| -------- | ------------------------------ |
| Repo     | `$CWD/.agents/skills`          |
| Repo     | `$REPO_ROOT/.agents/skills`    |
| User     | `~/.agents/skills`             |
| Admin    | `/etc/codex/skills`            |
| System   | bundled with Codex             |

Plugins are the right answer once you need to distribute. Use direct folders only to prototype.

## Skill Frontmatter For Codex

Each `SKILL.md` must include `name` and `description`. Optional `agents/openai.yaml` next to the skill controls UI metadata, invocation policy, and tool dependencies in the Codex app:

```yaml
interface:
  display_name: "User-facing name"
  short_description: "User-facing description"
  icon_small: "./assets/small-logo.svg"
  icon_large: "./assets/large-logo.png"
  brand_color: "#3B82F6"
  default_prompt: "Optional starter prompt"

policy:
  allow_implicit_invocation: false

dependencies:
  tools:
    - type: "mcp"
      value: "internalDocs"
      description: "Internal docs MCP server"
      transport: "streamable_http"
      url: "https://example.com/mcp"
```

Set `allow_implicit_invocation: false` for skills that must only be triggered explicitly with `$skill-name`.

## Invocation Model

Codex activates skills in two ways:

- Explicit: the user types `$skill-name` or runs `/skills`.
- Implicit: Codex matches the skill `description` against the task.

To avoid crowding the initial skill list (capped at about 2% of context or 8000 characters), write tight descriptions with key trigger words at the front.

## Lifecycle Hooks

When `[features].plugin_hooks = true`, Codex loads hooks from `hooks/hooks.json` (or a manifest path). Hook commands receive these environment variables:

- `PLUGIN_ROOT`: installed plugin root.
- `PLUGIN_DATA`: persistent writable data directory for the plugin.
- `CLAUDE_PLUGIN_ROOT`, `CLAUDE_PLUGIN_DATA`: aliases for compatibility with Claude plugin hooks.

Example:

```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "python3 ${PLUGIN_ROOT}/hooks/session_start.py",
            "statusMessage": "Loading plugin context"
          }
        ]
      }
    ]
  }
}
```

Quote `${PLUGIN_ROOT}` when used in shell commands.

## Bundled MCP Servers

`mcpServers` can point to an `.mcp.json` containing a direct server map or a wrapped `mcp_servers` object:

```json
{
  "mcp_servers": {
    "docs": {
      "command": "docs-mcp",
      "args": ["--stdio"]
    }
  }
}
```

Users can tune approval policy per server in `~/.codex/config.toml`:

```toml
[plugins."plugin-name".mcp_servers.docs]
enabled = true
default_tools_approval_mode = "prompt"
enabled_tools = ["search"]
```

## Marketplace File

A marketplace is a JSON catalog Codex reads to find plugins. Codex reads marketplace files from:

- The official Plugin Directory.
- Repo: `$REPO_ROOT/.agents/plugins/marketplace.json`.
- Legacy-compatible: `$REPO_ROOT/.claude-plugin/marketplace.json`.
- Personal: `~/.agents/plugins/marketplace.json`.

Minimum marketplace file for testing one plugin locally:

```json
{
  "name": "local-dmkings",
  "interface": {
    "displayName": "Local DMKINGS Plugins"
  },
  "plugins": [
    {
      "name": "plugin-name",
      "source": {
        "source": "local",
        "path": "./plugins/plugin-name"
      },
      "policy": {
        "installation": "AVAILABLE",
        "authentication": "ON_INSTALL"
      },
      "category": "Productivity"
    }
  ]
}
```

Notes:

- `source.path` is relative to the marketplace root and must start with `./`.
- For local entries, `source` may also be a plain string.
- For git-backed plugins, use `"source": "url"` or `"source": "git-subdir"` with `ref` or `sha`.

Add a marketplace from the CLI instead of editing config by hand:

```bash
codex plugin marketplace add owner/repo
codex plugin marketplace add owner/repo --ref main
codex plugin marketplace add https://github.com/example/plugins.git --sparse .agents/plugins
codex plugin marketplace add ./local-marketplace-root
```

Refresh and remove:

```bash
codex plugin marketplace upgrade
codex plugin marketplace upgrade marketplace-name
codex plugin marketplace remove marketplace-name
```

## Local Development Loop

1. Place the plugin under `$REPO_ROOT/plugins/plugin-name/` or `~/.codex/plugins/plugin-name/`.
2. Add or update the marketplace file so `source.path` points at the plugin directory.
3. Restart Codex.
4. Open `/plugins` and install the plugin.
5. Invoke a skill with `$skill-name` or `/skills`.

When you change the plugin, update the directory the marketplace points at and restart Codex.

Plugins are installed into `~/.codex/plugins/cache/$MARKETPLACE_NAME/$PLUGIN_NAME/$VERSION/`. For local plugins `$VERSION` is `local`.

## Enable / Disable

Each installed plugin has an enabled flag in `~/.codex/config.toml`:

```toml
[plugins."plugin-name"]
enabled = true
```

Set `enabled = false` and restart Codex to disable without uninstalling.

## Validation Before Shipping

- The plugin loads without errors after restart.
- Every skill triggers as expected from `$skill-name`.
- Every skill matches its description on at least one realistic implicit prompt.
- Hooks (if any) execute and write the expected logs.
- MCP servers (if any) start and expose the expected tools.
- `interface` metadata renders correctly in the Codex app or plugin directory view.
- `README.md` documents install, configuration, and known limitations.

## Anti-Patterns Specific To Codex

- Putting `skills/` inside `.codex-plugin/`. The plugin will not work.
- Shipping with implicit invocation on for skills that should only run explicitly.
- Writing skill descriptions that lose their trigger words when truncated by the 2% budget.
- Hardcoded absolute paths in hooks or scripts. Use `${PLUGIN_ROOT}` and `${PLUGIN_DATA}`.
- Plugin hooks that assume `plugin_hooks = true` is on without documenting it in the README.
- Mixing Codex-only features (`apps`, `.app.json`) into a plugin you also want to ship to Claude. Keep platform-specific manifests separate.
