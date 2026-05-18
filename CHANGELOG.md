# Changelog

## Unreleased

- Base skill `documenting-design-system`: extract tokens from PDF/Office/screenshots, write `shared/design-system.md` and client `applying-*-design-system` skill.
- `super-parse-discovery` maps brand/UI mentions to this skill.
- Removed `commands/` folder — workflows are skills only (see README).

## 0.2.0 — 2026-05-18

- `new-client-plugin.sh` orchestrator (scaffold + Gate A + prompts).
- `validate-client-plugin.sh` for skill-map and plugin tree.
- `build.mode` / `mvp_skills` in skill-map schema.
- `super-build-client-plugin` v1.1: auto-scaffold, phase_1/mvp scope, Gate B tiers, shared/ drafting.
- `new-client-plugin` Cursor command; runbook fast path.

## 0.1.0 — 2026-05-18

- Initial meta-plugin: super-parse-discovery, super-build-client-plugin, super-create-skill.
- Bundled references: pipeline, catalog/base, templates, adapters, best-practices.
- Scaffold script writes client plugins to the active workspace (not inside this repo).
