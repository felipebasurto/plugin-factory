---
name: writing-followups
description: Drafts professional follow-up emails and short messages after customer meetings using approved tone and facts from provided context. Use when the user asks for a follow-up email, meeting recap email, or post-call message to a customer or prospect.
---

# Writing Followups

## Goal

Draft a clear follow-up message that recaps agreements and next steps without adding unapproved claims.

## When to use

- Post-meeting or post-call follow-up to customer or prospect.
- Request for short or detailed follow-up variants.

## Do not use this skill when

- No meeting context or notes provided.
- Internal-only status update with no external recipient.
- User asks to send automatically (draft only).

## Inputs

Required: meeting outcome or summary (notes acceptable).

Optional: recipient name, tone (formal/casual), language.

## Workflow

1. Confirm recipient and purpose.
2. Recap facts only from input.
3. State next steps and owner.
4. Mark as DRAFT; list items needing human approval.
5. Offer short and long variants if useful.

## Rules

- Never send; human approves before external use.
- Check `../../shared/forbidden-claims.md` before stating product claims.
- No pricing or SLA unless in approved sources.

## Output

1. Email draft (subject + body).
2. Optional bullet version for CRM.
3. Approval checklist.

## References

- `../../shared/tone-of-voice.md`
- `../../shared/approval-policy.md`

## Version

Skill version: 0.1.0
