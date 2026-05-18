# plugin-factory

Meta-plugin: discovery notes → client plugins (Gate A skill-map, Gate B per skill).

**Client output** (`clients/<slug>/...`) is created in **your workspace**, not in this repo.

## Install (copy-paste from GitHub)

Repo: `https://github.com/felipebasurto/plugin-factory`

### Claude Code (repo root = plugin)

```bash
git clone https://github.com/felipebasurto/plugin-factory.git
claude --plugin-dir ./plugin-factory
```

Reload: `/reload-plugins` → `/plugin-factory:super-build-client-plugin`

### Cursor (Claude-compatible layout at repo root)

```bash
git clone https://github.com/felipebasurto/plugin-factory.git
cp -r plugin-factory ~/.cursor/plugins/local/plugin-factory
```

Reload plugins → `@plugin-factory` or `/plugin-factory:super-parse-discovery`

### Codex (marketplace from GitHub)

In **Add marketplace**:

| Field | Value |
| ----- | ----- |
| Source | `https://github.com/felipebasurto/plugin-factory` or `felipebasurto/plugin-factory` |
| Git ref | `main` |
| Sparse paths | **`.agents/plugins`** only, or **leave empty** |

Do **not** use `plugins/codex` — that path never existed.

If it failed before: remove the old marketplace, pull latest `main`, add again:

```bash
codex plugin marketplace remove plugin-factory
git pull   # in a clone, or re-add from GitHub
codex plugin marketplace add felipebasurto/plugin-factory --ref main
codex plugin marketplace upgrade plugin-factory
```

Then open the plugin directory → marketplace **Plugin Factory** → install **plugin-factory**.

Repo is **public**; no auth required for clone. If you still see "Failed to add marketplace", say which app (Codex desktop vs OpenWork) and exact sparse path.

## Skills

| Skill | Invocation |
| ----- | ---------- |
| `super-parse-discovery` | `/plugin-factory:super-parse-discovery` |
| `super-build-client-plugin` | `/plugin-factory:super-build-client-plugin` |
| `super-create-skill` | `/plugin-factory:super-create-skill` |

## Repo layout

```text
plugin-factory/                 # Claude + Cursor: use this folder as plugin-dir
├── .claude-plugin/
├── .cursor-plugin/
├── skills/                     # 3 superskills
├── references/                 # pipeline, catalog/base, templates, …
├── scripts/
└── .agents/plugins/
    ├── marketplace.json        # Codex marketplace catalog
    └── plugin-factory/         # Codex install target (synced copy)
        └── .codex-plugin/
```

After editing root `skills/` or `references/`, run `./scripts/sync-codex-plugin.sh` before committing so Codex stays in sync.

## Workflow

1. Open a **client workspace** (separate repo or folder with `clients/`).
2. `/plugin-factory:super-parse-discovery` → approve skill-map (Gate A).
3. From client workspace root:
   ```bash
   /path/to/plugin-factory/scripts/scaffold-client-plugin.sh \
     --client-slug <slug> --plugin-name <name>
   ```
4. `/plugin-factory:super-build-client-plugin` — one skill at a time (Gate B).

See [references/pipeline/runbook.md](references/pipeline/runbook.md).
