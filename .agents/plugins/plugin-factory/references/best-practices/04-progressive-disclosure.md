# 04. Progressive Disclosure

`SKILL.md` is a table of contents. It is not the encyclopedia.

Progressive disclosure means: the model loads `SKILL.md` when the skill is triggered, and only loads deeper files when the task requires them. This keeps the context window healthy and the skill fast.

## The Three Layers

1. Metadata layer (always loaded): `name` and `description`.
2. Body layer (loaded when triggered): the body of `SKILL.md`.
3. Detail layer (loaded only when needed): files under `references/`, `templates/`, `assets/`.

Scripts under `scripts/` are executed, not loaded into context.

## What Belongs In SKILL.md

Keep in the body:

- Goal.
- When to use and when not to use.
- Inputs.
- The workflow steps.
- Hard rules and refusals.
- Output format, short version.
- Pointers to references.

Move out:

- Long taxonomies.
- Big example libraries.
- Full output templates beyond a short skeleton.
- Domain glossaries.
- Background explanations.

## Good Pattern

```markdown
## References

Use these files only when needed:

- `references/rfp-taxonomy.md` for question category definitions.
- `references/examples.md` for full sample answers.
- `templates/short-answer.md` for the standard answer format.
- `templates/long-answer.md` for enterprise-style detailed answers.
```

The references are one level deep from `SKILL.md`. The model can choose which to read based on the task.

## Bad Patterns

- `SKILL.md` containing 1500 lines of company knowledge.
- `references/advanced.md` linking to `references/internals/details.md`.
- A `references/all.md` that bundles every detail into one file.
- Templates pasted inline into the workflow instead of linked.

## Size Discipline

Targets:

- `SKILL.md` body under 500 lines.
- Each reference file focused on a single topic.
- Reference files with a table of contents at the top when over 100 lines.

If you are approaching the limit, split before refactoring.

## Templates

Templates live in `templates/` and contain the exact output skeleton the skill should produce. The skill references them like:

```markdown
## Output

Follow the template in `templates/short-answer.md` exactly. Do not add sections.
```

Do not paste the full template inside `SKILL.md` if it is longer than a small skeleton.

## Domain-Specific Organization

For skills that cover multiple sub-domains, organize references by domain so that only the relevant file gets read:

```text
skill-name/
├── SKILL.md
└── references/
    ├── security.md
    ├── pricing.md
    ├── architecture.md
    └── support.md
```

`SKILL.md` lists each file with a short hint of what it contains, and the model picks the one matching the current task.

## When To Pull Things Back In

If a reference file is being loaded on every single run, it probably belongs in `SKILL.md`. Progressive disclosure is about optionality, not about hiding required information.
