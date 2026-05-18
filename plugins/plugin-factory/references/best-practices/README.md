# Skill Authoring Best Practices

This folder is the internal standard for designing, reviewing, and maintaining Claude Skills inside DMKINGS.

It is not a catalog of skills. It is the quality bar that every future skill, plugin, or vertical pack must respect before being added to the catalog.

## Core Tesis

A good skill is a packaged operational workflow, not a clever prompt.

It encodes:

- A specific, repeatable task.
- Clear triggers for when to use it and when not.
- A concrete procedure with checkable steps.
- Required inputs, sources, and output format.
- Guardrails, refusals, and human review points.
- Reference material loaded only when needed.
- Tests that prove the skill works on real cases.

If a skill cannot point to a single, repeatable workflow, it is not a skill yet. It is a draft.

## How To Read This Folder

Read in order:

1. `01-skill-definition.md` - what counts as a skill and what does not.
2. `02-skill-structure.md` - file layout, frontmatter, and supporting files.
3. `03-descriptions-and-triggers.md` - how to make the skill discoverable.
4. `04-progressive-disclosure.md` - keep `SKILL.md` light, push detail to references.
5. `05-workflows-scripts-and-validators.md` - choose the right level of freedom.
6. `06-testing-skills.md` - how to prove a skill works.
7. `07-anti-patterns.md` - what to refuse to ship.
8. `08-review-checklist.md` - the gate before a skill enters the catalog.
9. `09-packaging-claude-plugin.md` - how to ship skills as a Claude Code plugin.
10. `10-packaging-codex-plugin.md` - how to ship skills as a Codex plugin.
11. `11-packaging-cursor-plugin.md` - how to ship skills as a Cursor plugin.
12. `12-packaging-openwork-skill.md` - how to ship skills to OpenWork.
13. `sources.md` - upstream references this standard is built on.

## Scope

This document covers skill authoring and packaging across Claude Code, Codex, Cursor, and OpenWork. It does not cover:

- How to adapt skills per client or vertical.
- How to build RAGs, agents, or full workflows.

Those layers come later and will reference this standard.

## Templates And Factory

Actionable scaffolds live in [../../templates/](../../templates/).

Orchestration entry point: [../../super-create-skill/SKILL.md](../../super-create-skill/SKILL.md).

Platform adapters (Claude-first to Codex/Cursor/OpenWork): [../../adapters/](../../adapters/).

Catalog conventions: [../../catalog/conventions.md](../../catalog/conventions.md).

## Prime Directive

If a skill does not encode a specific procedure with checkable steps, defined output, and known limits, it does not enter the catalog. Reduce scope before reducing rigor.
