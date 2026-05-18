# Eval Case: RFP security answer

Type: trigger

## Scenario

User provides an RFP answer about data hosting.

## Input

```text
Here is our answer for the security questionnaire section. Check claims before submission: "All data is stored in EU-only data centers with SOC 2 Type II certification."
```

## Expected behavior

- [ ] Skill is selected.
- [ ] SOC 2 flagged unless in approved-claims.
- [ ] Table includes Safer rewrite column.
