# 01. Skill Definition

A Claude Skill is a packaged operational workflow that the model can discover and apply when a specific situation appears.

It is not a prompt, not a persona, and not an assistant. It is a procedure.

## What A Skill Is

A skill is:

- A folder with a `SKILL.md` file.
- A frontmatter `name` and `description` that make it discoverable.
- A markdown body that describes when to use it, the procedure, inputs, outputs, and limits.
- Optional `references/`, `templates/`, `assets/`, and `scripts/` for detail and consistency.

A skill solves one repeatable task end to end.

## What A Skill Is Not

A skill is not:

- A general assistant ("be a great consultant").
- A pile of tips ("write better emails").
- A long persona document.
- A knowledge dump of company information.
- A single example without procedure.
- A wrapper around a model that does not change behavior.

If the description could apply to ten unrelated tasks, the skill is too broad.

## The Test

A candidate becomes a skill only if all of these are true:

1. There is a clearly named workflow with start and end.
2. A human could follow the steps and produce the same kind of output.
3. The output has a defined shape.
4. There are obvious cases where the skill should not be used.
5. There is at least one realistic input example and one expected output.
6. There is a meaningful failure mode that the skill explicitly guards against.

If any of these is missing, the candidate is a draft, not a skill.

## Good vs Bad Candidates

Good candidates:

- Extract questions from an RFP spreadsheet and classify each by category.
- Convert discovery call notes into a structured summary with next steps.
- Review customer-facing text for unsupported claims and propose safer rewrites.
- Draft a technical quote from product specs and previous quotes.
- Turn release notes into a changelog with reviewer-ready entries.

Bad candidates:

- "Help with sales."
- "Improve writing."
- "Generate content."
- "Be helpful with documents."
- "Act as an expert in industry X."

## Skill Granularity

Prefer small, sharp skills over one large skill.

Two strong reasons:

- Discovery: Claude picks a skill from the `description` of many candidates. A focused description wins.
- Testing: a small skill has a small, testable contract.

When a skill grows past one workflow, split it. When two skills overlap, merge them and rewrite the description.

## Naming

Use gerund form when possible: `answering-rfps`, `summarizing-discovery-calls`, `validating-claims`.

Constraints from the spec:

- Lowercase letters, numbers, and hyphens only.
- Max 64 characters.
- Must match the folder name.
- Cannot use reserved words like `anthropic` or `claude`.

Avoid generic names: `helper`, `utils`, `tools`, `assistant`.
