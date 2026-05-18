---
name: super-build-client-plugin
description: Orchestrates building a client Claude plugin from an approved skill-map.yaml in the user workspace, generating one skill at a time with human approval per SKILL.md. Use after super-parse-discovery when skill-map is approved, or when continuing plugin build for a client slug.
---

# Super Build Client Plugin

## Goal

Produce `clients/<client_slug>/<plugin_name>/` as an installable Claude plugin in the **user's workspace**, one approved skill at a time (Gate B).

## When to use

- `clients/<client_slug>/discovery/skill-map.yaml` exists and user said **OK skill-map** (Gate A done).
- User asks to build skill N of the client plugin.

## Do not use this skill when

- skill-map `approved: false`.
- User has not approved the current skill draft (Gate B).
- Single skill only without client context (use super-create-skill).

## Inputs

Required:

- `client_slug`
- `plugin_name`

Optional:

- `skill_id` or skill `name` to build (default: next `pending` in map).

## Workflow

### Phase 0 — Verify Gate A

Read `clients/<client_slug>/discovery/skill-map.yaml` in the workspace. If `approved: false`, stop and request Gate A.

### Phase 1 — Scaffold (once)

If plugin folder missing, tell user to run from their **workspace root**:

```bash
/path/to/plugin-factory/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> --plugin-name <name>
```

Or use the Cursor command `scaffold-client-plugin` from the plugin-factory plugin.

Then draft `shared/` from discovery + [../../references/templates/client-pack/](../../references/templates/client-pack/). Mark unverified claims `NEEDS_CLIENT_APPROVAL`.

### Phase 2 — One skill per run (Gate B)

1. Pick next skill where `status: pending` (lowest `priority` first unless user specifies id).
2. If `source: base`: read `references/catalog/base/<base_skill>/SKILL.md` in this plugin and adapt for client (triggers, examples, industry terms from process-map). Do not copy blindly.
3. If `source: custom`: follow [../super-create-skill/SKILL.md](../super-create-skill/SKILL.md).
4. Write to `clients/<client_slug>/<plugin_name>/skills/<name>/SKILL.md`.
5. Add minimal `tests/` stubs from [../../references/templates/eval-case.md.template](../../references/templates/eval-case.md.template) (3 trigger, 2 non-trigger, 2 output-contract, 2 safety).
6. Set skill `status: draft` in skill-map.yaml.
7. **STOP.** Present SKILL.md path and ask: **Approve skill &lt;name&gt;? Reply OK skill &lt;name&gt; to continue.**

On user **OK skill &lt;name&gt;**:

- Set `status: approved` in skill-map.yaml.
- Do not start next skill until user asks.

### Phase 3 — Finalize (when user asks)

When all target skills `approved`:

- Update plugin README from [../../references/templates/README-plugin.md.template](../../references/templates/README-plugin.md.template).
- Verify [../../references/best-practices/08-review-checklist.md](../../references/best-practices/08-review-checklist.md) per skill.
- Print install command: `claude --plugin-dir ./clients/<slug>/<plugin_name>`.

## Rules

- Never generate more than one skill per run unless user explicitly waives Gate B.
- Never skip validating-claims in customer-facing packs.
- Canonical client paths only under `clients/<slug>/<plugin_name>/` in the user workspace.
- Do not write client deliverables inside the plugin-factory install directory.

## Output

1. Skill built (path).
2. skill-map status update.
3. Next pending skill name or finalize instructions.

## References

- [../super-parse-discovery/SKILL.md](../super-parse-discovery/SKILL.md)
- [../super-create-skill/SKILL.md](../super-create-skill/SKILL.md)
- [../../references/pipeline/runbook.md](../../references/pipeline/runbook.md)
- [../../references/catalog/conventions.md](../../references/catalog/conventions.md)

## Version

Superskill version: 1.0.0
