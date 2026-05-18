---
name: answering-rfps
description: Answers RFPs, procurement questionnaires, security questionnaires, and technical customer requirements using approved company references. Use when the user provides an RFP, tender, questionnaire, spreadsheet of requirements, or asks for customer-ready procurement answers.
---

# Answering RFPs

## Goal

Produce accurate, concise, customer-ready answers with confidence levels and flags for human review.

## When to use

- RFP, procurement or security questionnaire.
- Spreadsheet of customer requirements.

## Do not use this skill when

- Generic marketing copy without a questionnaire.
- No source documents or approved claims available.

## Inputs

Required: questions or requirement list.

Optional: deadline, answer format (table vs prose).

## Workflow

1. Extract all questions/requirements.
2. Classify: product, technical, security, commercial, unknown.
3. Answer from `../../shared/approved-claims.md` only; else flag.
4. Assign confidence: High / Medium / Low.
5. Output table + reviewer notes.

## Rules

- Never invent certifications, SLAs, pricing, or customer names.
- Low confidence → human review required.

## Output

1. Completed answers.
2. Assumptions.
3. Low-confidence list.
4. Claims requiring approval.

## References

- `../../shared/approved-claims.md`
- `../../shared/forbidden-claims.md`

## Version

Skill version: 0.1.0
