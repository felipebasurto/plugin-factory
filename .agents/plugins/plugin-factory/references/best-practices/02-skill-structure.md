# 02. Skill Structure

Every skill is a folder. The folder name equals the skill name.

## Minimal Layout

```text
skill-name/
└── SKILL.md
```

A minimal skill is valid if `SKILL.md` is well written. Add more files only when they earn their place.

## Full Layout

```text
skill-name/
├── SKILL.md              # main instructions, loaded when triggered
├── references/           # detailed docs loaded only when needed
│   ├── taxonomy.md
│   └── examples.md
├── templates/            # output formats and skeletons
│   ├── short-answer.md
│   └── long-answer.md
├── assets/               # static files (images, sample data, fixtures)
└── scripts/              # executable helpers (Python, shell, etc.)
    ├── extract.py
    └── validate.py
```

Rules:

- `SKILL.md` is required. Everything else is optional.
- Use folders only when they will have at least one real file at commit time.
- Keep references one level deep. Do not link reference files to other reference files.

## Frontmatter

`SKILL.md` must start with YAML frontmatter:

```yaml
---
name: answering-rfps
description: Answers RFPs, procurement questionnaires, security questionnaires, and customer technical requirements using approved company references. Use when the user provides an RFP, tender, questionnaire, spreadsheet of requirements, or asks for customer-ready procurement answers.
---
```

Required fields:

- `name`: lowercase, hyphens, max 64 chars, matches folder name.
- `description`: third person, includes what the skill does and when to use it. Max 1024 chars but usually 1-3 sentences.

Do not invent extra fields unless the runtime supports them. Extra metadata is better placed in the body or in a `metadata.md` reference.

## Recommended Body Sections

The body of `SKILL.md` should usually contain, in this order:

1. `# Skill name` heading.
2. `## Goal` - one paragraph stating the outcome.
3. `## When to use` - explicit triggers.
4. `## Do not use this skill when` - explicit non-triggers.
5. `## Inputs` - what the user must provide and what is optional.
6. `## Workflow` - numbered, checkable steps.
7. `## Rules` - hard constraints, refusals, and approvals.
8. `## Output` - exact format of the response.
9. `## References` - links to files inside the skill folder, one level deep.

Skip any section that does not add value, but keep the order consistent across skills.

## Size

Target less than 500 lines in `SKILL.md`. When you approach the limit:

- Move long examples to `references/examples.md`.
- Move taxonomies and lookup tables to `references/`.
- Move output formats to `templates/`.
- Move fragile or repetitive logic to `scripts/`.

The body should be readable in a single screen scroll for an experienced author.

## Cross-File Discipline

- Link references with relative paths only.
- Do not link from one reference to another. Always come back through `SKILL.md`.
- Do not reference files that do not exist.
- Do not use absolute paths or parent traversal.
- Use forward slashes, never backslashes.

## Versioning

When a skill is owned inside a plugin, its version follows the plugin version. Inside this folder, breaking changes to a skill should be reflected in a short "Old patterns" section at the bottom of `SKILL.md`, not by keeping a parallel old skill alive.
