# Pipeline Inputs

## Accepted client context sources

- Meeting notes (bullet points, messy OK)
- Call transcript (partial OK)
- Email thread summary from sales
- AI Process Sprint output pasted as one doc
- Combined: notes + stakeholder list + tool inventory

Formats: `.md`, `.txt`, or pasted text in chat.

## Minimum content required

The discovery doc should allow extraction of:

1. Company name and industry.
2. At least 3 recurring workflows (not vague "use AI everywhere").
3. Who does the work (roles).
4. Tools or document types involved.
5. At least one measurable pain (time, errors, delays).

If fewer than 3 workflows are identifiable, stop and request a follow-up call before generating skill-map.

## Language

Spanish or English. Output artifacts match the language of the discovery doc unless the user requests otherwise.

## What to store

Save the original under:

```text
clients/<client-slug>/discovery/raw/notes.md
```

Never overwrite raw after parse; append version suffix if re-parsing.

## Sensitive data

- Do not put credentials or personal data in skill-map.yaml.
- Flag sensitive categories in process-map for `shared/data-boundaries.md`.
