# Outline: client design-system skill (generated artifact)

Use this outline when writing `skills/applying-{{client}}-design-system/SKILL.md` for the client plugin.

```markdown
---
name: applying-{{client}}-design-system
description: Applies {{CLIENT}} brand and UI rules when drafting slides, emails, one-pagers, or UI copy layouts. Use when the user asks for on-brand design, visual structure, or review against the design system.
---

# Applying {{CLIENT}} Design System

## Goal
Apply documented tokens and components from shared/design-system.md.

## When to use
- On-brand documents, UI descriptions, slide structure, HTML/email layout guidance
- Reviewing whether a draft matches brand

## Do not use this skill when
- Pure internal text with no visual/brand dimension
- design-system.md is missing or empty

## Inputs
- Draft or request
- shared/design-system.md (required)

## Workflow
1. Load design-system.md
2. Map request to tokens and components
3. Output with explicit token names and sections
4. Flag NEEDS_BRAND_APPROVAL for anything not in the spec

## Output
- Structured recommendation OR annotated review table
- List of violations and fixes

## References
- ../../shared/design-system.md
```

Adapt triggers to client industry and channels from discovery.
