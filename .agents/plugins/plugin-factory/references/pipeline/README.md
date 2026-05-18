# Discovery → Client Plugin Pipeline

Automates turning a discovery document into a client plugin with up to 10 skills, with human gates.

Install **plugin-factory** first; run all client outputs in a separate workspace repo.

## Flow

```text
Discovery doc
  → /plugin-factory:super-parse-discovery
  → skill-map.yaml          [Gate A: human approves map]
  → scaffold-client-plugin.sh (from client workspace)
  → /plugin-factory:super-build-client-plugin (one skill at a time)
  → SKILL.md per skill      [Gate B: human approves each]
  → installable client plugin
```

## Superskills (plugin-factory)

| Skill | Role |
| ----- | ---- |
| `super-parse-discovery` | Parse discovery → intake, process-map, skill-map |
| `super-build-client-plugin` | Orchestrate plugin build after map approval |
| `super-create-skill` | Author one custom skill (called by build) |

Invoke as `/plugin-factory:<skill-name>` in Cursor or Claude Code.

## Docs

- [inputs.md](inputs.md) — what to accept as discovery input
- [skill-map.schema.yaml](skill-map.schema.yaml) — skill-map contract
- [runbook.md](runbook.md) — step-by-step for a client day

## Bootstrap (recommended)

From the **client workspace root** after Gate A:

```bash
/path/to/plugin-factory/scripts/new-client-plugin.sh \
  --client-slug <slug> --plugin-name <plugin-name> --approve-gate-a
```

Or scaffold only:

```bash
/path/to/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> --plugin-name <plugin-name>
```

Validate before handover:

```bash
/path/to/plugin-factory/scripts/validate-client-plugin.sh \
  --client-slug <slug> --plugin-name <plugin-name>
```

## Output layout (client workspace)

```text
clients/<client-slug>/
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
