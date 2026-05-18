---
name: super-build-client-plugin
description: Orchestrates building a client Claude plugin from an approved skill-map.yaml in the user workspace. Respects build.mode for MVP or phase_1 scope. Auto-scaffolds plugin shell. One skill per run by default; optional batch for low-risk base skills after pilot is approved.
---

# Super Build Client Plugin

## Goal

Produce `clients/<client_slug>/<plugin_name>/` as an installable Claude plugin in the **user's workspace**, with human gates on each SKILL.md.

## When to use

- `clients/<client_slug>/discovery/skill-map.yaml` exists and user said **OK skill-map** (Gate A done).
- User asks to build skill N of the client plugin.

## Do not use this skill when

- skill-map `approved: false`.
- User has not approved the current skill draft (Gate B), unless batch waiver applies (see below).
- Single skill only without client context (use super-create-skill).

## Inputs

Required:

- `client_slug`
- `plugin_name`

Optional:

- `skill_id` or skill `name` to build (default: next in-scope `pending`).
- User may say **OK skills 2-3** for batch (see Gate B tiers).

## Build scope (read skill-map first)

Read `build.mode` from skill-map (default `phase_1` if missing):

| mode | Skills eligible to build |
| ---- | ------------------------ |
| `phase_1` | `phase: 1` and `status: pending` |
| `mvp` | Names in `build.mvp_skills`, or if empty: pilot skill + `validating-claims` |
| `all` | All `pending` skills in map |

Announce at start: *"Build mode &lt;mode&gt;: N skills in scope for this plugin version."*

Do not propose phase 2 skills until phase 1 skills are `approved` or `excluded`, unless `build.mode: all`.

## Workflow

### Phase 0 — Verify Gate A

Read `clients/<client_slug>/discovery/skill-map.yaml`. If `approved: false`, stop and request Gate A.

### Phase 1 — Scaffold and shared pack (once)

If `clients/<client_slug>/<plugin_name>/` is missing, **run** (do not only tell the user):

```bash
"${CLAUDE_PLUGIN_ROOT}"/scripts/scaffold-client-plugin.sh \
  --client-slug <slug> --plugin-name <name> \
  --workspace-root <workspace-root>
```

Use the workspace root where `clients/` lives.

Then draft `shared/` from intake + process-map + discovery notes:

- Fill `company-positioning.md` with factual, non-marketing bullets.
- Mark every unverified claim `NEEDS_CLIENT_APPROVAL`.
- Add industry-specific forbidden patterns to `forbidden-claims.md` when known.
- Do not leave bare `REPLACE` markers without a flag.

### Phase 2 — Build skills (Gate B)

**Pick next skill:** lowest `priority` among in-scope skills with `status: pending`.

**Adaptation:**

1. If `source: base`: read `references/catalog/base/<base_skill>/SKILL.md` and adapt (triggers, examples, client terms).
2. If `source: custom`: follow [../super-create-skill/SKILL.md](../super-create-skill/SKILL.md).
3. Write `clients/<slug>/<plugin>/skills/<name>/SKILL.md`.
4. Add `tests/` stubs per [../../references/templates/eval-case.md.template](../../references/templates/eval-case.md.template).
5. Set `status: draft` in skill-map.yaml.

**Gate B — default (one skill):**

- **STOP.** Ask: **Approve skill &lt;name&gt;? Reply OK skill &lt;name&gt;.**
- On **OK skill &lt;name&gt;** → set `status: approved`.

**Gate B — batch (only if ALL true):**

- Pilot skill in map is already `status: approved`.
- User explicitly said **OK skills N-M** or **OK batch skills** listing names.
- Every skill in batch: `source: base` and `risk` is `low` or `medium` (never `high`).
- Maximum **3 skills** per batch run.
- Still present each SKILL.md path for review; user OK applies to the batch.

**Never batch:** `risk: high`, `source: custom`, or `validating-claims` on first build (always review claims skill individually at least once).

### Phase 3 — Finalize (when user asks)

When all in-scope skills for current `build.mode` are `approved` or `excluded`:

- Update plugin README from template.
- Run validation mentally per [../../references/best-practices/08-review-checklist.md](../../references/best-practices/08-review-checklist.md).
- Suggest:
  ```bash
  "${CLAUDE_PLUGIN_ROOT}"/scripts/validate-client-plugin.sh --client-slug <slug> --plugin-name <name>
  claude --plugin-dir ./clients/<slug>/<plugin_name>
  ```

## Rules

- Auto-scaffold when plugin folder missing; only ask user to run scripts if execution fails.
- Never skip `validating-claims` in customer-facing packs.
- Never generate more than one skill per run unless batch rules apply.
- Client deliverables only under `clients/<slug>/<plugin_name>/` in the user workspace.

## Output

1. Actions taken (scaffold yes/no, skill(s) built).
2. Paths to SKILL.md files.
3. skill-map status updates.
4. Next pending in-scope skill or finalize + validate command.

## References

- [../super-parse-discovery/SKILL.md](../super-parse-discovery/SKILL.md)
- [../super-create-skill/SKILL.md](../super-create-skill/SKILL.md)
- [../../references/pipeline/runbook.md](../../references/pipeline/runbook.md)
- [../../references/catalog/conventions.md](../../references/catalog/conventions.md)

## Version

Superskill version: 1.1.0
