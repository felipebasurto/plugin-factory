# Adapter: Claude Plugin → OpenWork

OpenWork does not use a plugin manifest. Distribution is per-skill `SKILL.md` plus optional workspace folder layout.

## Inputs

- Source: `skills/<name>/SKILL.md` from Claude plugin (canonical).
- `shared/` applies when the workspace needs client knowledge (copy to a documented location or inline critical rules).

## Per-skill export

For each skill to ship on OpenWork:

1. Copy `skills/<name>/SKILL.md` unchanged if frontmatter is valid (`name`, `description`).
2. If the skill references `../../shared/`, either:
   - Install client pack under workspace and keep relative paths valid, or
   - Paste critical rules from `shared/forbidden-claims.md` and `shared/approved-claims.md` into a `references/client-rules.md` and update the References section (one level deep).
3. Add or update `## Version` in the skill body (OpenWork has no manifest version).

## Workspace layout (technical install)

```text
.opencode/skills/<skill-name>/SKILL.md
```

Repeat for each skill in the plugin.

## Cloud / share flows

| Method | When |
| ------ | ---- |
| share.openworklabs.com | One-off handoff, single skill |
| Skills → Cloud | Team org, ongoing sync |
| `/skill-creator` in chat | Quick import from pasted SKILL |

See [../best-practices/12-packaging-openwork-skill.md](../best-practices/12-packaging-openwork-skill.md).

## README note for client

```markdown
OpenWork install: import each SKILL.md via Cloud or share link. Canonical Claude plugin version X.Y.Z (YYYY-MM-DD). Re-import when canonical minor/major version changes.
```

## Do not

- Expect `/plugin-name:skill` namespacing; OpenWork uses skill name from frontmatter.
- Ship multi-file skills via share link only (share carries single file). Use Cloud or `.opencode/skills/` for references and scripts.

## Post-adaptation checklist

- [ ] Frontmatter validates on share site.
- [ ] Skill runs in target workspace after reload.
- [ ] Customer-facing skill run through validating-claims if applicable.
- [ ] Version line in body matches canonical release.

## Prompt for an agent (copy-paste)

```text
Export skills from Claude plugin SOURCE_PATH for OpenWork.

Follow references/adapters/to-openwork.md.
For each skill, output a ready-to-import SKILL.md.
Resolve shared/ references for OpenWork (workspace install or references/client-rules.md).
Add Version line matching plugin semver.
List install steps for Cloud vs .opencode/skills/.
```
