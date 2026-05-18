---
name: super-parse-discovery
description: Parses discovery call notes or transcripts into structured intake, process map, and skill-map.yaml for client plugin planning. Use when starting a new client from discovery documents, AI Process Sprint notes, or qualification call transcripts. Writes under clients slash client-slug slash discovery in the user's workspace.
---

# Super Parse Discovery

## Goal

Turn a messy discovery document into three files ready for Gate A approval: `intake.md`, `process-map.md`, `skill-map.yaml` (max 10 skills).

## When to use

- New client after discovery or Process Sprint.
- User provides notes, transcript, or summary and a `client_slug`.

## Do not use this skill when

- Skill-map already approved and user wants to build plugin (use super-build-client-plugin).
- No discovery content provided.

## Inputs

Required:

- `client_slug` (kebab-case).
- `plugin_name` (kebab-case).
- Discovery content (file path or pasted text).

Optional: industry hint, language (es/en).

## Workspace

Write all outputs under **`clients/<client_slug>/`** in the **user's open workspace** (consulting repo), not inside the plugin-factory install directory.

## Workflow

1. Save or confirm raw input at `clients/<client_slug>/discovery/raw/notes.md`.
2. Fill `clients/<client_slug>/discovery/intake.md` using [../../references/delivery/discovery-intake.md](../../references/delivery/discovery-intake.md).
3. Write `clients/<client_slug>/discovery/process-map.md` with 3-8 processes: name, frequency, pain, tools, data, risk, metric hypothesis.
4. List available base skills from [../../references/catalog/base/](../../references/catalog/base/) (read folder names and metadata.yaml).
5. Write `clients/<client_slug>/discovery/skill-map.yaml` per [../../references/pipeline/skill-map.schema.yaml](../../references/pipeline/skill-map.schema.yaml):
   - Max 10 skills, priority ordered.
   - Prefer `source: base` + `base_skill` when match exists.
   - `source: custom` only if no base fit.
   - Exactly one `pilot_candidate: true`.
   - Include `validating-claims` if any skill produces customer-facing output.
   - Mark RAG-heavy workflows `phase: 2`.
   - Set `approved: false` and all skill `status: pending`.
   - **Always set** `build.mode: phase_1` unless user requests `mvp` or `all`.
   - If discovery is hypothetical, add `build.mvp_skills` with pilot + `validating-claims` in notes.
6. Stop. Tell user to review skill-map and reply **OK skill-map** for Gate A, or run:
   `plugin-factory/scripts/new-client-plugin.sh --client-slug <slug> --plugin-name <name> --approve-gate-a`

## Rules

- Do not write plugin SKILL.md files in this step.
- Do not set `approved: true` without explicit user confirmation.
- Do not invent client certifications or customer names in intake; use NEEDS_CONFIRMATION.
- Map to [../../references/catalog/base/](../../references/catalog/base/) before inventing custom skills.

## Output

Return paths written and summary table: skill name, source, priority, pilot_candidate, phase.

## References

- [../../references/pipeline/inputs.md](../../references/pipeline/inputs.md)
- [../../references/pipeline/skill-map.schema.yaml](../../references/pipeline/skill-map.schema.yaml)
- [../../references/pipeline/runbook.md](../../references/pipeline/runbook.md)

## Version

Superskill version: 1.1.0
