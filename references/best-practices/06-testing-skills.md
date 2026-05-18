# 06. Testing Skills

A skill without tests is a draft. Testing is what turns a workflow into a maintained asset.

The goal is not academic coverage. The goal is to prevent silent regressions, surprise outputs, and customer-facing mistakes.

## Test Categories

Every serious skill should have cases in each of these categories.

### 1. Trigger Tests

Does the model load this skill when it should?

Cases:

- A realistic user message that should activate the skill.
- A pasted artifact (file content, transcript, spreadsheet excerpt).
- A short ambiguous request that still maps clearly to the skill.

Expected behavior: the skill is selected and applied.

### 2. Non-Trigger Tests

Does the model avoid this skill when it should not run?

Cases:

- A request that mentions trigger words but is out of scope.
- A nearby task that belongs to a sibling skill.
- A casual or social request.

Expected behavior: the skill is not selected.

### 3. Output Contract Tests

Does the output respect the format defined in `## Output`?

Cases:

- Standard input, standard output.
- Input with missing optional fields.
- Input that should produce an empty section.

Expected behavior: every required section is present, no extra sections, structure matches the template.

### 4. Safety Tests

Does the skill refuse to invent or overpromise?

Cases:

- Input with a deliberately unanswerable question.
- Input requesting a forbidden claim (pricing, SLA, roadmap).
- Input with a sensitive category that requires human review.

Expected behavior: the skill flags uncertainty, refuses forbidden claims, and routes to human review where required.

### 5. Real-World Messy Input Tests

Does the skill survive ugly inputs?

Cases:

- A long, poorly formatted document.
- A spreadsheet with merged cells, blank rows, or mixed languages.
- Notes with typos, fragments, and inconsistent style.

Expected behavior: the skill still produces a structured output or asks a clarifying question, but does not hallucinate.

### 6. Cross-Skill Tests

Does the skill compose with other skills?

Cases:

- Output of skill A is the input of skill B.
- Two skills run in the same conversation without confusion.

Expected behavior: stable inputs and outputs across boundaries.

### 7. Regression Tests

When the skill changes, do old cases still pass?

Cases:

- A frozen set of input/output pairs from previous good runs.
- Edge cases that were fixed in past iterations.

Expected behavior: results match the recorded baseline, or differences are explicitly accepted.

## Where Tests Live

Recommended layout next to the skill:

```text
skill-name/
├── SKILL.md
└── tests/
    ├── triggers.md
    ├── non-triggers.md
    ├── output-contract.md
    ├── safety.md
    ├── messy-input.md
    └── regression/
        ├── 2026-05-rfp-sample-01/
        │   ├── input.md
        │   └── expected.md
        └── 2026-05-rfp-sample-02/
            ├── input.md
            └── expected.md
```

Each test file describes:

- The scenario in one sentence.
- The input, inline or via a file path.
- The expected behavior, not necessarily the exact wording.

## Test Case Template

```markdown
### Case: short discovery call notes

Scenario: the user pastes 6 lines of messy notes from a 20-minute call.

Input:

> rough notes here...

Expected behavior:

- The skill is triggered.
- The output uses the standard summary template.
- Pain points, decision criteria, and next steps are present.
- Anything not in the input is flagged as "unknown" instead of invented.
```

## Sizing The Test Set

Initial target per skill:

- 3 trigger cases.
- 2 non-trigger cases.
- 2 output contract cases.
- 2 safety cases.
- 1 messy input case.
- 1 cross-skill case if relevant.

Grow the set every time a real failure appears in production. Failed runs become regression cases.

## Testing Across Models

Skills behave differently on different models. Test on every model the skill is expected to run on. A skill that is clear for a strong model may be too thin for a smaller one.

When a single skill needs to support multiple models, write the body for the weakest model in the target set, and let stronger models naturally do better.
