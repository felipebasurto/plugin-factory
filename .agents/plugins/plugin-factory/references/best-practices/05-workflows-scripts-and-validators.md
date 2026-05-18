# 05. Workflows, Scripts, And Validators

A skill is judged by its workflow. The workflow is what makes a skill different from a clever prompt.

## Degrees Of Freedom

Pick the right level of specificity for each step.

- High freedom: prose instructions. Use when multiple approaches are valid and context decides. Example: a content review where tone depends on audience.
- Medium freedom: pseudocode or parameterized templates. Use when there is a preferred pattern with acceptable variation. Example: drafting a proposal with optional sections.
- Low freedom: a specific script or fixed command. Use when the operation is fragile, error-prone, or must be consistent. Example: extracting questions from a complex RFP spreadsheet.

A useful mental model: if the path has cliffs on both sides, give exact instructions. If the field is open, give direction and trust the model.

## Workflow Format

Use a numbered list with short, checkable steps. Add a copyable checklist when the workflow has more than four steps.

```markdown
## Workflow

Copy this checklist into your response and check items off as you go:

```

Progress:

- [ ] Step 1: Identify the customer, industry, and deadline.
- [ ] Step 2: Extract all explicit questions.
- [ ] Step 3: Classify each question by category.
- [ ] Step 4: Draft answers using approved references.
- [ ] Step 5: Assign confidence to each answer.
- [ ] Step 6: Flag questions that require human review.

```

**Step 1: Identify the customer, industry, and deadline.**

Read the source document and capture: customer name, industry, deadline, output format, and any explicit constraints.

**Step 2: Extract all explicit questions.**

Pull every question, requirement, or checkbox into a flat list. Do not paraphrase.

[...]
```

Each step should:

- Start with an imperative verb.
- Name the input and the output.
- Be testable on its own.

## Scripts

Scripts exist when prose is fragile. Use them for:

- Parsing structured input (spreadsheets, PDFs, JSON).
- Validating output against rules.
- Producing files in a strict format.
- Any task where consistency matters more than flexibility.

Reference them clearly:

```markdown
## Scripts

- `scripts/extract_questions.py`: extracts questions from an RFP spreadsheet.
  Usage: `python scripts/extract_questions.py input.xlsx > questions.json`
- `scripts/check_forbidden_claims.py`: validates a draft against the forbidden claims list.
  Usage: `python scripts/check_forbidden_claims.py draft.md`
```

State whether the script should be executed or read. Most should be executed.

Document dependencies inside the script header or in a `references/scripts.md`. Avoid hidden assumptions about the environment.

## Validators

A validator is a script or a checklist that catches failure modes before the output reaches the user.

Two common shapes:

- Code validator: runs and prints OK or a list of issues.
- Documentation validator: a checklist the model walks before finishing.

Example of a documentation validator inside the workflow:

```markdown
## Self-check before finishing

Walk this list before returning the answer:

- [ ] Every claim is supported by an approved reference.
- [ ] No customer or partner names appear without approval.
- [ ] No SLA, pricing, or roadmap commitments.
- [ ] Every low-confidence answer is flagged for human review.
- [ ] The output follows `templates/short-answer.md`.
```

If a self-check fails, the skill must say so and not pretend the output is final.

## Feedback Loops

For quality-critical skills, build a loop:

1. Draft.
2. Validate.
3. If issues, fix and revalidate.
4. Only finalize when validation passes.

This pattern catches errors before they reach the customer-facing layer, which is exactly where skills earn or lose trust.

## Picking The Right Tool For Each Step

| Step characteristic                | Best tool                |
| ---------------------------------- | ------------------------ |
| Open-ended, judgment-driven        | Prose instruction        |
| Repeatable shape with variation    | Template + instruction   |
| Strict structure or parsing        | Script                   |
| Risk of inventing claims           | Validator + refusal rule |
| Multi-step with many failure modes | Checklist + feedback loop |

When in doubt, prefer the more rigid tool. A skill that constrains too much is easy to relax. A skill that constrains too little produces inconsistent outputs and erodes client trust.
