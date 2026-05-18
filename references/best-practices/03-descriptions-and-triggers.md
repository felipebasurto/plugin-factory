# 03. Descriptions And Triggers

A skill that cannot be discovered does not exist. The `description` field is the single most important piece of text in the skill.

The model uses `name` and `description` to choose which skill to load from potentially many candidates. Everything else is invisible until that choice is made.

## What A Good Description Does

A good description answers two questions in one or two sentences:

1. What does this skill do?
2. When should it be used?

Plus, implicitly, when it should not be used.

## Mandatory Rules

- Write in third person. The description is injected into the system prompt and inconsistent point of view confuses discovery.
- Include concrete trigger terms a user is likely to type.
- Be specific. Avoid words that could apply to ten skills.
- Keep it under three sentences. Detail belongs in the body.
- Do not start with "I" or "You". Start with the verb or the artifact.

## Good Examples

```yaml
description: Extracts text and tables from PDF files, fills forms, and merges documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

```yaml
description: Answers RFPs, procurement questionnaires, security questionnaires, and customer technical requirements using approved company references. Use when the user provides an RFP, tender, questionnaire, spreadsheet of requirements, or asks for customer-ready procurement answers.
```

```yaml
description: Reviews customer-facing content for unsupported, risky, or forbidden claims. Use before sending proposals, RFP answers, security questionnaires, sales decks, website copy, case studies, or executive summaries.
```

What makes these work:

- They name the artifact ("PDF", "RFP", "customer-facing content").
- They list concrete contexts ("tender", "questionnaire", "executive summary").
- They are third person.
- They imply the boundary by being specific.

## Bad Examples

```yaml
description: Helps with documents.
```

```yaml
description: I can help you write proposals and other content.
```

```yaml
description: Assistant for sales tasks.
```

```yaml
description: Does stuff with files.
```

Why they fail:

- No artifact mentioned.
- No trigger terms.
- Wrong person.
- Too generic to compete with sibling skills.

## Trigger Terms

Inside the description, include the words a real user would type or paste:

- File types and extensions: `PDF`, `.xlsx`, `DOCX`, `Markdown`.
- Artifact names: `RFP`, `proposal`, `quote`, `discovery call`, `battlecard`.
- Actions: `extract`, `summarize`, `draft`, `classify`, `review`, `validate`.
- Domains: `procurement`, `security questionnaire`, `customer technical requirements`.

Avoid trigger words that overlap with skills you do not own. For example, do not put `code review` into a content review skill description.

## Non-Triggers Belong In The Body

Do not try to fit "do not use when..." inside the description.

Use the body, in a `## Do not use this skill when` section. That section is the second filter, applied after discovery. Examples:

```markdown
## Do not use this skill when

- The user is brainstorming informally.
- The content is for internal notes only.
- The user asks for code review or developer documentation.
- The user has not provided the source material this skill needs.
```

## Description Authoring Checklist

- [ ] Third person.
- [ ] Names the artifact.
- [ ] Names at least three concrete trigger contexts.
- [ ] Reads naturally as one or two sentences.
- [ ] Distinguishable from any sibling skill in the catalog.
- [ ] No first or second person pronouns.
- [ ] No marketing adjectives ("powerful", "best", "smart").
