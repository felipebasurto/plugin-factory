# Catalog Conventions

Rules for naming, versioning, ownership, and multi-platform delivery when using **plugin-factory**.

## Canonical source

- **Source of truth**: Claude `SKILL.md` files in the **client workspace** (inside `clients/<client-slug>/<plugin-name>/skills/`).
- **Factory catalog**: Reusable bases under `references/catalog/base/` in the plugin-factory install (adapt per client; do not ship raw to clients).
- **No command duplicates**: catalog workflows are invoked via `skill-map` + `super-build-client-plugin` or by referencing the catalog `SKILL.md` — not via a parallel `commands/` markdown file.
- **Generated artifacts**: Codex, Cursor, and OpenWork copies are outputs of [../adapters/](../adapters/). Record generation date and plugin version in the target README footer.
- **Rule**: Do not hand-edit generated SKILL bodies in platform folders without syncing back to Claude canonical.

## Naming

### Skills

- Format: gerund or clear action, kebab-case, max 64 chars.
- Examples: `validating-claims`, `summarizing-discovery-calls`, `answering-rfps`, `documenting-design-system`.
- Avoid: `helper`, `utils`, `assistant`, `tools`.

### Plugins

- Format: kebab-case, describes pack not single skill.
- Examples: `acme-industrial-workflows`, `piezas-norte-workflows`.
- Plugin `name` in manifest = namespace prefix (`/plugin-name:skill-name` on Claude).

### Layout

```text
<client-workspace>/
└── clients/<client-slug>/
    ├── discovery/              # Gate A: skill-map.yaml
    └── <plugin-name>/          # Gate B: installable client plugin
        ├── .claude-plugin/
        ├── shared/
        └── skills/
```

Factory install (meta-plugin only):

```text
plugin-factory/
├── skills/                     # super-parse-discovery, super-build-client-plugin, super-create-skill
└── references/catalog/base/    # library to adapt from
```

## Versioning

### Plugin (Claude/Codex/Cursor)

- Semver in `plugin.json`: `MAJOR.MINOR.PATCH`.
- **Patch**: typo fixes, clarifications, no behavior change.
- **Minor**: new skill, new template, non-breaking output addition.
- **Major**: renamed skill, removed skill, changed output contract, breaking rule.

### Skill body (OpenWork)

- Add `## Version` in SKILL.md; align with plugin semver on release.

### Changelog

- `CHANGELOG.md` at **client** plugin root for client-facing releases.

## Platform delivery

| Need | Ship |
| ---- | ---- |
| Default client delivery | Claude plugin only |
| Client uses Codex | Claude + regenerate Codex via `to-codex.md` |
| Client uses Cursor | Claude + regenerate Cursor via `to-cursor.md` |
| Client uses OpenWork UI | Export SKILL files via `to-openwork.md` |

Ship Claude first. Adapt only after canonical passes review checklist.

## Quality gate

Every customer-facing skill release must:

1. Pass [../best-practices/08-review-checklist.md](../best-practices/08-review-checklist.md).
2. Run `validating-claims` on at least one realistic sample output.
3. Include minimum tests per [../best-practices/06-testing-skills.md](../best-practices/06-testing-skills.md).

## Drift prevention

On client plugin **minor** or **major** release:

1. Bump `plugin.json` version.
2. Update skill `## Version` lines.
3. Regenerate Codex/Cursor artifacts if those platforms are in scope.
4. Note regeneration date in generated README footers.
