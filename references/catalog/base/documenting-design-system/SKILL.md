---
name: documenting-design-system
description: Extracts a complete client design system from brand PDFs, Word/PowerPoint decks, Figma links, and website screenshots, then writes shared/design-system.md and a client-specific applying-*-design-system skill. Use when the user provides brand guidelines, style guides, marketing assets, or asks to document or codify a client's visual identity for agents.
---

# Documenting Design System

## Goal

Turn scattered brand materials into a **single source of truth** (`shared/design-system.md`) and a **reusable client skill** so every other skill in the plugin can stay on-brand without re-reading PDFs.

## Invocation

- **Client plugin build:** add to `skill-map.yaml` with `source: base` and `base_skill: documenting-design-system`, Gate A approved, then `/plugin-factory:super-build-client-plugin`.
- **Ad-hoc:** attach brand files under `clients/<slug>/brand-intake/raw/` and ask to document the design system — follow this `SKILL.md` directly.
- Do not add a separate `commands/` file; this skill is the entry point.

## When to use

- User drops brand PDF, `.docx`, `.pptx`, screenshot folder, or live site captures.
- Discovery or build phase needs visual consistency (slides, emails, landing copy structure, UI handoff).
- User asks: "document the design system", "create a brand skill", "extract tokens from these files".

## Do not use this skill when

- There are zero brand/visual inputs (no files, no screenshots, no URLs).
- Task is only copy tone with no visual dimension (use tone-of-voice skill instead).
- User wants implementation in code/CSS only — still run this first for tokens, then hand off to engineering.

## Inputs

**Required (at least one):**

| Type | How to process |
| ---- | -------------- |
| PDF brand guide | Read text layer; use vision on pages if scanned/image-only |
| Word `.docx` | Extract text and embedded images |
| PowerPoint `.pptx` | Per-slide: layout, colors, fonts, master styles |
| Images / screenshots | Vision: infer colors, type scale, components, spacing |
| Public URL | Describe visible UI; note responsive variants if multiple captures provided |

**Optional:**

- Figma / Adobe link (describe what user must export if agent cannot open file)
- Existing CSS / Tailwind config (merge as authoritative for web)
- Client name, slug, output language

**Intake folder (recommended):**

```
clients/<slug>/brand-intake/
  raw/           # originals untouched
  notes.md       # user context
  exports/       # PNG/PDF page exports if needed
```

## Outputs

1. **`shared/design-system.md`** — filled from `templates/design-system-spec.md`
2. **`skills/applying-<client>-design-system/SKILL.md`** — from `templates/generated-skill-outline.md`, client-specific triggers
3. **`brand-intake/source-index.md`** — what file contributed which token (audit trail)
4. **Gap list** — inferred vs confirmed, NEEDS_BRAND_APPROVAL items

## Workflow

### Phase A — Collect and inventory

1. List every file: name, type, date, pages/slides.
2. Classify source reliability: **official brand PDF** > marketing deck > website screenshot > single social post.
3. If binary files are unreadable, ask user for: text export, PDF with text layer, or PNG per page — do not guess silently.

### Phase B — Extract (parallel by domain)

Work domain by domain; merge conflicts explicitly.

| Domain | Extract |
| ------ | ------- |
| Color | Hex/RGB, semantic names (primary, accent), gradients, backgrounds |
| Typography | Families, weights, sizes, line-height, letter-spacing, hierarchy |
| Logo | Variants, clear space, min size, misuse rules |
| Spacing | Base unit, scale, grid, breakpoints |
| Components | Buttons, forms, cards, nav, tables — only if shown |
| Imagery | Photo/illustration/icon rules |
| Motion | Only if documented |
| Channels | Web, email, print, presentation differences |

**Screenshot / vision rules:**

- Sample multiple regions (hero, nav, footer, form, card) before declaring tokens.
- Prefer values repeated across pages over one-off marketing accents.
- Label **INFERRED** when picking from anti-aliased pixels; never present as official without source.

**PDF / Office rules:**

- Prefer explicit tables in brand guide over visual guess.
- Slide masters in PPTX often define real heading/body fonts — capture them.
- Note page/slide number for every token in source index.

### Phase C — Normalize tokens

1. Name tokens consistently: `color.primary`, `font.heading`, `space.4`, etc.
2. Resolve conflicts: official guide wins; else newest dated asset; else ask user.
3. Document **do not** rules (logo stretch, off-palette CTAs, unapproved fonts).

### Phase D — Write design-system.md

1. Copy structure from `templates/design-system-spec.md`.
2. Replace every `NEEDS_CONFIRMATION` with value or keep flag with reason.
3. Keep a **Source** column on color/type tables where possible.

### Phase E — Generate client skill

1. Use `templates/generated-skill-outline.md`.
2. Set `name: applying-<client-slug>-design-system`.
3. Write **description** with 3–5 real trigger phrases from discovery (industry + deliverables).
4. Add **When to use** examples: "email header layout", "proposal cover", "slide title slide".
5. Point all references to `../../shared/design-system.md`.

### Phase F — Gate and handoff

1. Mark document header: `DRAFT — requires brand owner approval`.
2. If used inside plugin-factory build: add skill to client `skill-map.yaml` with `risk: medium`, `customer_facing: partial`.
3. Tell user what to approve: colors, fonts, logo rules before Gate B customer-facing skills use this.

## Rules

- **No fabrication:** missing token → `NEEDS_BRAND_APPROVAL`, not invented hex codes.
- **Provenance:** every non-obvious value ties to a source in section 12 / source-index.
- **Separation:** visual system here; verbal tone stays in `tone-of-voice.md` (cross-link only).
- **Accessibility:** only state WCAG/contrast if source claims it or you measured with stated method; else flag confirmation.
- **Copyright:** do not reproduce full logo SVGs or licensed font files in repo — describe usage and file location only.

## Integration with other skills

| Skill | Relationship |
| ----- | -------------- |
| `super-parse-discovery` | If brand/UI mentioned, propose this skill in skill-map phase 1 |
| `super-build-client-plugin` | Install outputs under client plugin `shared/` + `skills/` |
| `drafting-proposals` / slide skills | Reference `design-system.md` in Rules section |
| `super-create-skill` | Use generated skill as pattern for more brand-adjacent skills |

## Output checklist

- [ ] `shared/design-system.md` complete (all sections filled or explicitly N/A)
- [ ] `skills/applying-*-design-system/SKILL.md` with client-specific triggers
- [ ] `source-index.md` or section 12 populated
- [ ] Gap list with NEEDS_BRAND_APPROVAL items
- [ ] No invented values without INFERRED label

## References

- `templates/design-system-spec.md` — canonical output shape
- `templates/generated-skill-outline.md` — client skill scaffold
- Client `discovery/skill-map.yaml` when mapping pilot scope

## Version

1.0.0
