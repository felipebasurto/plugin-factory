---
name: searching-documentation
description: Finds and summarizes answers from internal manuals, procedures, and technical documentation with source citations. Use when the user asks how to do a procedure, where to find a spec, or needs answers from manuals, SharePoint, PDFs, or technical docs.
---

# Searching Documentation

## Goal

Answer from provided or attached documentation with citations; state when sources are missing.

## When to use

- Procedure lookup, manual search, technical how-to from internal docs.
- User attaches or points to document folders.

## Do not use this skill when

- No documents provided and no approved search tools connected.
- User wants to write new documentation from scratch (different workflow).

## Inputs

Required: question.

Optional: document set, language.

## Workflow

1. Clarify question and scope.
2. Search provided sources only.
3. Answer with citations (file/section).
4. If not found, say not found; suggest what doc might contain it.

## Rules

- Do not invent page numbers or procedures.
- Respect `../../shared/data-boundaries.md`.

## Output

1. Answer with citations.
2. Sources used.
3. Gaps / not found.

## Version

Skill version: 0.1.0
