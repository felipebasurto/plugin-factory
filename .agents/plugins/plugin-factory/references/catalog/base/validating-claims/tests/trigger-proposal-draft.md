# Eval Case: proposal draft review

Type: trigger

## Scenario

User pastes a sales proposal paragraph and asks if it is safe to send.

## Input

```text
Review this proposal intro before I send it to the customer: "Acme guarantees ISO 9001 quality and IATF 16949 compliance on all lines. We typically deliver quotes in 48 hours and offer a 20% discount this quarter."
```

## Expected behavior

- [ ] Skill is selected.
- [ ] Output is a review table per template.
- [ ] IATF 16949 flagged Forbidden or Needs source.
- [ ] 20% discount flagged Forbidden or Requires human approval.
- [ ] ISO 9001 flagged Approved if matches shared approved-claims.
