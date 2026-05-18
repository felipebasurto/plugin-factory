# Changelog

All notable changes to plugin-factory are documented here.

## Unreleased

## 0.0.1 — 2026-05-18

Initial release of plugin-factory.

### Superskills

- `super-parse-discovery`: turns any client information into `intake.md`, `process-map.md`, and `skill-map.yaml` (max 10 skills). Single entry point for all client plugin builds. Requires user Gate A approval before building.
- `super-build-client-plugin`: orchestrates building a client Claude plugin from an approved skill-map. Auto-scaffolds the plugin shell. One skill per run by default; batch available for low-risk base skills after pilot approval (Gate B).
- `super-create-skill`: authors, reviews, and packages a single skill or plugin from templates and best-practices. Supports platform adapters to Codex, Cursor, and OpenWork.

### Base skill catalog (`references/catalog/base/`)

Nine ready-to-adapt base skills:

- `answering-rfps`
- `documenting-design-system` (SKILL.md v1.0.0, tests, templates; `super-parse-discovery` maps brand/UI mentions to this skill automatically)
- `drafting-technical-quotes`
- `drafting-weekly-reports`
- `searching-documentation`
- `summarizing-discovery-calls`
- `summarizing-support-tickets`
- `validating-claims` (full test suite: 3 trigger, 2 non-trigger, 2 output-contract, 2 safety cases)
- `writing-followups`

### Pipeline infrastructure

- `skill-map.schema.yaml`: contract for `approved`, `build.mode` (`phase_1` / `mvp` / `all`), `mvp_skills`, per-skill `status` enum, `priority`, `phase`, and `risk`.
- `references/pipeline/runbook.md`: fast path (~1 h) from any client context to installable client plugin.
- `references/pipeline/inputs.md`: accepted discovery input formats.
- `references/delivery/discovery-intake.md`: intake template for qualification calls.

### Scripts

- `scripts/scaffold-client-plugin.sh`: creates empty client plugin tree under `clients/<slug>/<plugin-name>/`.
- `scripts/new-client-plugin.sh`: orchestrator — scaffold + optional Gate A YAML patch + next-step prompts.
- `scripts/validate-client-plugin.sh`: checks skill-map consistency and plugin directory structure.
- `scripts/sync-codex-plugin.sh`: syncs root `skills/` and `references/` into `.agents/plugins/plugin-factory/` for Codex installs.

### Templates and standards

- `references/templates/SKILL.md.template`: canonical skill authoring template.
- `references/templates/client-pack/`: six shared-pack files (`approved-claims`, `forbidden-claims`, `company-positioning`, `tone-of-voice`, `data-boundaries`, `approval-policy`).
- `references/templates/plugin-claude/`, `plugin-cursor/`, `plugin-codex/`: per-platform plugin stubs with manifest and README.
- `references/best-practices/01` through `12` + `sources.md`: full authoring standards for skill definition, structure, descriptions, progressive disclosure, testing, anti-patterns, review checklist, and platform packaging.
- `references/adapters/to-codex.md`, `to-cursor.md`, `to-openwork.md`: step-by-step platform adaptation guides.

### Multi-platform manifests and marketplaces

- `.claude-plugin/plugin.json`: Claude Code manifest with `homepage`, `repository`, and `license` fields.
- `.claude-plugin/marketplace.json`: Claude Code marketplace catalog (spec-compliant: `owner` required, `source: github` pointing to `felipebasurto/plugin-factory`). Users add with `/plugin marketplace add felipebasurto/plugin-factory` and install with `/plugin install plugin-factory@plugin-factory`.
- `.cursor-plugin/plugin.json`: Cursor manifest with `homepage`, `repository`, and `license` fields.
- `.agents/plugins/plugin-factory/.codex-plugin/plugin.json`: Codex plugin manifest.
- `.agents/plugins/marketplace.json`: Codex marketplace catalog using `source: git-subdir` pointing to `.agents/plugins/plugin-factory` in `felipebasurto/plugin-factory` on `main`. Codex users always pull the latest committed state from GitHub — no local path required on the consumer side.
