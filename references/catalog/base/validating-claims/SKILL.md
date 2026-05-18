---
name: validating-claims
description: Reviews customer-facing content for unsupported, risky, forbidden, or overconfident claims using approved company references. Use before sending proposals, RFP answers, security questionnaires, sales decks, website copy, case studies, emails to customers, or executive summaries.
---

# Validating Claims

## Goal

Identify claims that may be unsupported, risky, exaggerated, confidential, or inconsistent with approved positioning, and return a review table with safer rewrites.

## When to use

Use when the user provides:

- A draft proposal, email, deck, or web copy.
- RFP or questionnaire answers marked ready to send.
- Any customer-facing text before external distribution.

## Do not use this skill when

- The content is internal-only notes with no customer audience.
- The user asks for creative brainstorming without a draft to review.
- The task is code review or developer documentation.

## Inputs

Required:

- The full draft to review.

Optional:

- Target audience (customer, partner, regulator).
- Document type (proposal, email, RFP answer).

## Workflow

```
Progress:
- [ ] Read draft and classify each factual claim
- [ ] Compare against shared references
- [ ] Build review table
- [ ] List escalations
```

**Step 1: Read the draft**

Extract every factual claim: certifications, metrics, customer names, product capabilities, timelines, pricing, SLAs, comparisons.

**Step 2: Load references**

Read before judging:

- `../../shared/approved-claims.md`
- `../../shared/forbidden-claims.md`
- `../../shared/company-positioning.md`

**Step 3: Classify each claim**

Use exactly one label per claim:

- Approved
- Needs source
- Too vague
- Overpromising
- Confidential / internal
- Legally risky
- Forbidden

**Step 4: Propose safer rewrites**

For anything not Approved, suggest replacement text or mark "Requires human approval from [role per approval-policy]."

**Step 5: Return output**

Follow `templates/review-table.md`. Do not edit the original draft unless the user asks.

## Rules

- Never add new claims while rewriting.
- Never remove the review table in favor of prose-only feedback.
- If approved-claims is empty for a topic, label Needs source or Requires human approval.
- Benchmarks, certifications, customer names, and pricing always require explicit approval match.

## Output

Return:

1. Review table (required format in template).
2. Summary: count by risk label.
3. Blockers: items that must be fixed before send.
4. Assumptions made during review.

## References

- `templates/review-table.md` for output shape.
- `../../shared/approved-claims.md`
- `../../shared/forbidden-claims.md`
- `../../shared/approval-policy.md`

## Version

Skill version: 0.1.0
