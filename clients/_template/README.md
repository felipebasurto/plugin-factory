# Client workspace template

Client deliverables live in **your project repo**, not inside the plugin-factory install.

## Scaffold

From your workspace root:

```bash
~/.cursor/plugins/local/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> \
  --plugin-name <plugin-name>
```

Or run `/plugin-factory:super-parse-discovery` then `/plugin-factory:super-build-client-plugin` (auto-scaffolds when the plugin folder is missing).

## Layout

```text
your-workspace/
└── clients/<slug>/
    ├── discovery/
    │   ├── raw/
    │   ├── intake.md
    │   ├── process-map.md
    │   └── skill-map.yaml
    └── <plugin-name>/
        ├── .claude-plugin/plugin.json
        ├── shared/
        └── skills/
```

Do not commit real client secrets or unapproved claims.
