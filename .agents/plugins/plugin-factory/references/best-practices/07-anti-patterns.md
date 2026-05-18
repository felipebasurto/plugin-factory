# 07. Anti-Patterns

These are the failure modes that turn a skill into noise. If a candidate skill matches one of these, fix it before merging.

## 1. The Mega-Skill

Symptom: a single skill that tries to handle sales, presales, RFPs, proposals, and follow-ups in one body.

Why it fails:

- Description must be generic to cover everything.
- Discovery becomes unreliable.
- Tests become impossible to scope.
- Maintenance breaks every time one of the sub-tasks changes.

Fix: split into focused skills. One workflow per skill.

## 2. The Prompt In Disguise

Symptom: the body is a paragraph that says "You are an expert. Do a great job."

Why it fails:

- No procedure.
- No checkable steps.
- No output contract.
- No way to test.

Fix: write the workflow. If you cannot, the skill is not ready.

## 3. The Encyclopedia

Symptom: `SKILL.md` is 1500 lines of background, history, product details, glossaries, and rationale.

Why it fails:

- Burns context every time the skill triggers.
- Hides the actual procedure.
- Discourages updates.

Fix: keep `SKILL.md` under 500 lines. Move detail to `references/` with one-level links.

## 4. No "When Not To Use"

Symptom: the skill activates on any vaguely related message and pollutes responses where it should not.

Why it fails:

- Wastes tokens.
- Confuses the user.
- Crowds out the skill that should have been picked.

Fix: add a `## Do not use this skill when` section with concrete non-triggers.

## 5. No Output Contract

Symptom: the skill produces different shapes every run.

Why it fails:

- Clients expect consistency, especially for customer-facing outputs.
- Downstream skills and humans cannot rely on the shape.
- Regression testing becomes guesswork.

Fix: define an explicit `## Output` section and link a template when needed.

## 6. Invented Claims

Symptom: the skill happily produces certifications, benchmarks, customer names, SLAs, or roadmap promises that nobody approved.

Why it fails:

- Direct business and legal risk.
- Destroys trust faster than any other failure mode.

Fix: add hard refusals in `## Rules`, route uncertainty to human review, and consider a companion `validating-claims` skill.

## 7. Time-Sensitive Content

Symptom: the body says "before August 2025 do X, after August 2025 do Y".

Why it fails:

- The skill silently becomes wrong on a future date.
- Nobody remembers to update it.

Fix: write the current method as the main path. Put deprecated patterns in a collapsed "Old patterns" section.

## 8. Inconsistent Terminology

Symptom: the same concept is called "field", "box", "control", and "element" across different steps.

Why it fails:

- Confuses the model.
- Confuses reviewers.
- Breaks search and grep.

Fix: pick one term per concept and use it everywhere.

## 9. Deeply Nested References

Symptom: `SKILL.md` links to `advanced.md`, which links to `details.md`, which links to `internals.md`.

Why it fails:

- The model may partially read nested files.
- Context becomes incomplete without anyone noticing.

Fix: keep references one level deep. Always link directly from `SKILL.md`.

## 10. Hidden Side Effects

Symptom: a skill silently sends an email, writes to a CRM, deletes files, or calls a paid API.

Why it fails:

- Violates trust.
- Breaks governance.
- Cannot be unwound.

Fix: require explicit human approval for any write or external action. Skills draft, humans approve.

## 11. Marketing Voice

Symptom: descriptions and bodies use words like "powerful", "best-in-class", "magical", "intelligent".

Why it fails:

- Adds tokens.
- Adds no information.
- Sets unrealistic expectations.

Fix: write plain, specific, third-person language. Verbs and artifacts only.

## 12. Skills That Reuse Files They Do Not Own

Symptom: a skill links to `../other-skill/templates/x.md`.

Why it fails:

- Coupling breaks when the other skill moves.
- Ownership becomes unclear.

Fix: keep skill folders self-contained. If a resource is truly shared, move it to a `shared/` folder at the plugin root and reference it explicitly.

## 13. Skills Without Tests

Symptom: no `tests/` folder, no example inputs, no recorded behavior.

Why it fails:

- No way to catch regressions.
- No way to onboard reviewers.
- No proof the skill ever worked.

Fix: ship at least the minimum set from `06-testing-skills.md` before adding the skill to the catalog.
