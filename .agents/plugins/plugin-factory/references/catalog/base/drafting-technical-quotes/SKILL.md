---
name: drafting-technical-quotes
description: Drafts technical-commercial quotes from requirements, prior quotes, and product data using structured sections and explicit assumptions. Use when the user mentions technical quote, commercial offer, presupuesto técnico, cotización, or RFQ response draft.
---

# Drafting Technical Quotes

## Goal

Produce a structured quote draft with technical and commercial sections, assumptions, and gaps — not a final priced offer without approval.

## When to use

- New RFQ or quote request with requirements and reference materials.
- Request to draft from similar past quotes.

## Do not use this skill when

- User needs only a price number without context.
- No product or scope information available.
- Legal contract terms only (escalate to human).

## Inputs

Required: scope or requirements (even partial).

Optional: past quotes, product catalog excerpts, delivery constraints.

## Workflow

1. Parse requirements into line items and open questions.
2. Map to standard quote sections (scope, specs, assumptions, exclusions, timeline).
3. Flag missing data for human input.
4. Draft body; mark pricing as REQUIRES APPROVAL unless in approved-claims.
5. List technical risks and dependencies.

## Rules

- Never invent specifications or certifications.
- Pricing and delivery dates require explicit approval per `approval-policy`.
- Run validating-claims mindset on commercial statements.

## Output

1. Quote draft (structured).
2. Assumptions and exclusions.
3. Open questions.
4. Approval required list.

## References

- `templates/quote-outline.md`
- `../../shared/approved-claims.md`

## Version

Skill version: 0.1.0
