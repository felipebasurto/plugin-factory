# Eval Case: customer email

Type: trigger

## Scenario

User asks to validate a short customer email.

## Input

```text
Validate this email to a prospect: "We work with BMW and guarantee delivery in 5 days on all orders."
```

## Expected behavior

- [ ] Skill is selected.
- [ ] BMW named customer flagged unless approved.
- [ ] "Guarantee" delivery flagged Overpromising or Forbidden.
