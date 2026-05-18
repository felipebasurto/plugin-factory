# 08. Review Checklist

This is the gate. A skill enters the catalog only when every required item is checked.

Use this list when proposing a new skill, when reviewing a peer's skill, and when auditing existing skills.

## Identity

- [ ] Folder name matches `name` in frontmatter.
- [ ] `name` uses lowercase letters, numbers, and hyphens only.
- [ ] `name` is in gerund form or a clear action-oriented noun phrase.
- [ ] `name` is not a reserved word and not generic (no `helper`, `utils`, `tools`).

## Description

- [ ] Written in third person.
- [ ] Names the artifact or domain.
- [ ] Includes at least three concrete trigger contexts.
- [ ] Reads as one or two short sentences.
- [ ] Distinguishable from any sibling skill.
- [ ] No marketing adjectives.

## Body Structure

- [ ] Body is under 500 lines.
- [ ] `## Goal` is one paragraph and outcome-focused.
- [ ] `## When to use` lists concrete triggers.
- [ ] `## Do not use this skill when` lists concrete non-triggers.
- [ ] `## Inputs` names required and optional inputs.
- [ ] `## Workflow` is a numbered, checkable list.
- [ ] `## Rules` includes refusals and human-approval points where needed.
- [ ] `## Output` defines the shape of the response.
- [ ] `## References` lists supporting files, one level deep.

## Workflow Quality

- [ ] Each step has an imperative verb.
- [ ] Each step names its input and output.
- [ ] The workflow has an explicit end condition.
- [ ] Steps are independently testable.
- [ ] Long workflows include a copyable checklist.

## Output Quality

- [ ] Output sections are defined exactly.
- [ ] A template exists for any non-trivial format.
- [ ] Confidence, assumptions, and open questions are first-class fields when relevant.
- [ ] No invented sections.

## Safety And Governance

- [ ] Hard refusals are listed for forbidden claims and sensitive categories.
- [ ] Any write, send, publish, or delete action requires human approval.
- [ ] Sensitive data handling is explicit, not implicit.
- [ ] The skill does not promise pricing, SLAs, or roadmap unless explicitly allowed.

## Progressive Disclosure

- [ ] References live in `references/`, `templates/`, or `assets/`.
- [ ] No reference links to another reference.
- [ ] No reference is loaded on every run (would belong in the body).
- [ ] Long reference files have a table of contents.

## Scripts

- [ ] Scripts exist only where consistency matters.
- [ ] Each script has a documented invocation.
- [ ] Dependencies are explicit.
- [ ] No Windows-style paths.
- [ ] Scripts state whether they should be executed or read.

## Testing

- [ ] `tests/` folder exists.
- [ ] At least three trigger cases.
- [ ] At least two non-trigger cases.
- [ ] At least two output contract cases.
- [ ] At least two safety cases.
- [ ] At least one messy real-world input case.
- [ ] Regression cases recorded for any past failure.

## Hygiene

- [ ] No time-sensitive content in the active path.
- [ ] Consistent terminology throughout.
- [ ] No links to files that do not exist.
- [ ] No cross-skill file references.
- [ ] Relative paths only.

## Final Gate

- [ ] The skill solves one repeatable task end to end.
- [ ] A new reviewer can understand the skill in under five minutes.
- [ ] The skill could fail safely if the input is wrong.
- [ ] The skill earns its place in the catalog.

If any required item is unchecked, the skill is a draft. Reduce scope, fix gaps, and review again.
