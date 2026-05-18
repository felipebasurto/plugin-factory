---
name: summarizing-support-tickets
description: Summarizes support tickets and incident threads, suggests diagnosis steps, and drafts customer-safe responses from manuals and history. Use when the user provides a support ticket, SAT incident, customer complaint thread, or post-sales issue description.
---

# Summarizing Support Tickets

## Goal

Structured incident summary, suggested next steps, and optional draft reply for human approval.

## When to use

- Long ticket thread needs summary.
- Technician needs diagnosis checklist from known docs.

## Do not use this skill when

- Safety-critical instructions without verified sources.
- User asks to close ticket in ERP automatically.

## Inputs

Required: ticket content or thread.

Optional: machine model, customer tier.

## Workflow

1. Summarize timeline, symptoms, actions taken.
2. Suggest diagnosis from provided docs only.
3. Draft customer reply marked DRAFT.
4. Escalation criteria if severity high.

## Rules

- Safety and warranty statements require human approval.
- No automatic send.

## Output

1. Incident summary.
2. Suggested steps.
3. Draft reply.
4. Escalation flags.

## Version

Skill version: 0.1.0
