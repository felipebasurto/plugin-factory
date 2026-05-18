---
name: super-create-skill
description: Factory superskill that authors, reviews, and packages operational skills and Claude plugins from templates and best-practices. Use when creating a new skill, converting a workflow into a skill, packaging a client plugin, adapting to Codex or Cursor, or reviewing skill quality before delivery. Not for end-user business workflows.
---

# Super Create Skill

## Goal

Produce a shippable skill or Claude plugin that meets factory standards, using Claude-first authoring and optional platform adapters.

## When to use

Use when the user wants to:

- Create a new skill from a workflow or pain point.
- Package skills as a Claude Code plugin for a client.
- Review an existing skill against the quality gate.
- Adapt a canonical Claude plugin to Codex, Cursor, or OpenWork.

## Batch client delivery

For a full client plugin from discovery (skill-map + multiple skills with human approval per file), use [../super-build-client-plugin/SKILL.md](../super-build-client-plugin/SKILL.md) and [../super-parse-discovery/SKILL.md](../super-parse-discovery/SKILL.md). Use **this** superskill for a single net-new skill or one-off packaging.

## Do not use this skill when

- The user only wants generic prompt advice without a repeatable workflow.
- The task is RAG, agent orchestration, or ERP integration design (out of scope for this factory).
- There is no identifiable process, output shape, or success metric.
- The user wants to run a client workflow (e.g. validate a proposal); use a domain skill such as `validating-claims` in the **client** plugin instead.

## Inputs

Required:

- What workflow the skill performs (one sentence).
- Who uses it and how often.
- What triggers should activate the skill.

Optional:

- Client name and whether this is a client delivery.
- Target platforms (Claude only, or also Codex/Cursor/OpenWork).
- Existing documents, examples, or drafts.

## Workflow

```
Progress:
- [ ] Intake complete
- [ ] Skill vs plugin decision made
- [ ] Canonical SKILL.md drafted
- [ ] Client pack if needed
- [ ] Tests written
- [ ] Review checklist passed
- [ ] Plugin packaged (if applicable)
- [ ] Platform adapters run (if requested)
```

**Step 1: Intake**

Confirm: workflow name, triggers, inputs, output sections, risk level (low/medium/high), human approval points, client-specific (yes/no).

If any required item is missing, ask one focused question. Do not proceed to authoring without a single clear workflow.

**Step 2: Decide scope**

- One skill = one repeatable procedure. Split if multiple unrelated outcomes.
- Plugin if sharing, versioning, or client delivery. Standalone `.claude/skills/` only for quick experiments.
- Default deliverable: Claude plugin in `clients/<slug>/<plugin-name>/` when client-specific.

**Step 3: Author canonical SKILL.md**

1. Copy [../../references/templates/SKILL.md.template](../../references/templates/SKILL.md.template).
2. Apply [../../references/best-practices/01-skill-definition.md](../../references/best-practices/01-skill-definition.md) through [08-review-checklist.md](../../references/best-practices/08-review-checklist.md).
3. `name` must match folder name; `description` third person with concrete triggers.
4. Keep SKILL.md under 500 lines; use `references/` and `templates/` for detail.

**Step 4: Client pack (if enterprise delivery)**

Copy [../../references/templates/client-pack/](../../references/templates/client-pack/) to plugin `shared/` and replace REPLACE markers with client-approved content.

**Step 5: Tests**

Under `skills/<name>/tests/`, create at minimum:

- 3 trigger cases
- 2 non-trigger cases
- 2 output-contract cases
- 2 safety cases

Use [../../references/templates/eval-case.md.template](../../references/templates/eval-case.md.template).

**Step 6: Review**

Walk [../../references/best-practices/08-review-checklist.md](../../references/best-practices/08-review-checklist.md). Reject shipping if any required item fails.

For customer-facing skills, require validating-claims on sample output before sign-off.

**Step 7: Package Claude plugin**

1. Scaffold from [../../references/templates/plugin-claude/](../../references/templates/plugin-claude/).
2. Place skills under `skills/<name>/`.
3. Write README from [../../references/templates/README-plugin.md.template](../../references/templates/README-plugin.md.template).
4. Follow [../../references/best-practices/09-packaging-claude-plugin.md](../../references/best-practices/09-packaging-claude-plugin.md).

**Step 8: Adapt to other platforms (only if requested)**

| Platform | Adapter |
| -------- | ------- |
| Codex | [../../references/adapters/to-codex.md](../../references/adapters/to-codex.md) |
| Cursor | [../../references/adapters/to-cursor.md](../../references/adapters/to-cursor.md) |
| OpenWork | [../../references/adapters/to-openwork.md](../../references/adapters/to-openwork.md) |

Regenerate artifacts; do not hand-maintain parallel SKILL bodies.

## Rules

- Canonical source is always Claude `SKILL.md` in the client or project repo.
- Never ship without `## Do not use this skill when` and `## Output`.
- Never invent client claims; use `shared/approved-claims.md` only.
- Point to best-practices docs instead of duplicating them in chat.

## Output

Return to the user:

1. Paths created or updated.
2. Skill name and invocation (`/plugin-name:skill-name` for Claude).
3. Review checklist summary (pass/fail per section).
4. Next steps (test locally, client pack gaps, adapter commands).

## References

- Discovery → plugin pipeline: [../../references/pipeline/README.md](../../references/pipeline/README.md)
- Standards index: [../../references/best-practices/README.md](../../references/best-practices/README.md)
- Templates: [../../references/templates/README.md](../../references/templates/README.md)
- Catalog rules: [../../references/catalog/conventions.md](../../references/catalog/conventions.md)

## Version

Superskill version: 1.0.0
