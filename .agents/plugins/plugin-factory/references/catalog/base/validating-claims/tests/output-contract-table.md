# Eval Case: output contract

Type: output-contract

## Scenario

Minimal draft with one approved and one forbidden claim.

## Input

```text
Check: "Acme Industrial is ISO 9001 certified and offers the lowest prices in Europe."
```

## Expected behavior

- [ ] Response includes markdown table with required columns.
- [ ] Includes Summary with counts.
- [ ] Includes Blockers section if any Forbidden/Overpromising.
