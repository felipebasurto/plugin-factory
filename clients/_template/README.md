# Client workspace template

Client deliverables live in **your project repo**, not inside the plugin-factory install.

## Scaffold

From your workspace root:

```bash
~/.cursor/plugins/local/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> \
  --plugin-name <plugin-name>
```

Or use the **scaffold-client-plugin** command from the plugin-factory Cursor plugin.

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
