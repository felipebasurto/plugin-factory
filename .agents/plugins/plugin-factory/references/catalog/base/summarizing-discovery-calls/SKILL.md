---
name: summarizing-discovery-calls
description: Turns raw discovery call notes or transcripts into a structured summary with pain points, stakeholders, decision criteria, risks, and next steps. Use when the user provides discovery notes, call notes, meeting notes, or asks to summarize a commercial discovery conversation.
---

# Summarizing Discovery Calls

## Goal

Produce a structured discovery summary and optional follow-up email draft from messy call notes, without inventing facts.

## When to use

- Raw notes or transcript from a discovery or qualification call.
- Request to structure "what we learned" after a customer meeting.

## Do not use this skill when

- The user wants a full technical proposal (use proposal or quote skills).
- There are no notes or transcript to work from.
- The task is internal code or engineering design only.

## Inputs

Required: call notes or transcript.

Optional: attendee list, deal stage, target output language.

## Workflow

1. Extract: company, attendees, date context, stated pains, tools mentioned, timeline, budget signals.
2. Structure: context, pain points, decision criteria, stakeholders, urgency, risks, open questions.
3. Draft optional follow-up email marked DRAFT — requires human approval before send.
4. List unknowns explicitly.

## Rules

- Label inferred items as inferred.
- Do not invent certifications, pricing, or commitments.
- Follow `../../shared/tone-of-voice.md` if present.

## Output

1. Structured summary (fixed sections).
2. Optional follow-up email draft.
3. Open questions for next call.
4. Assumptions.

## References

- `templates/summary-format.md` if present.
- `../../shared/approval-policy.md`

## Version

Skill version: 0.1.0
