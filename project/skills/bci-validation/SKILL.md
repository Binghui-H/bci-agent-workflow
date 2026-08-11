---
name: bci-validation
description: Perform final independent validation for a BCI algorithm workflow by checking implementation against TASK.md, DESIGN.md, PHASE_PLAN.md, REVIEW_LOG.md, BCI signal contracts, tests, performance evidence, and safety boundaries. Use when all BCI implementation phases and reviews appear complete and Codex must produce VALIDATION_REPORT.md.
---

# BCI Validation

Use this skill for the validation agent. Do not modify code. Validate evidence and report the delivery state to the main conversation.

## Required inputs

Read `TASK.md`, `DESIGN.md`, `PHASE_PLAN.md`, `REVIEW_LOG.md`, `HANDOFF.md`, `RUN_STATE.md`, final diff, and available test/benchmark logs.

## Validation matrix

Check:

- User goals and non-goals from `TASK.md`
- Input/output contracts and BCI signal assumptions from `DESIGN.md`
- Phase completion against `PHASE_PLAN.md`
- Open P0/P1/P2 issues in `REVIEW_LOG.md`
- Test evidence exists and appears real
- Realtime/performance claims have evidence or are marked unverified
- Safety boundary avoids medical diagnosis claims

## Output

Write `VALIDATION_REPORT.md` with one conclusion:

| Conclusion | Meaning |
|---|---|
| PASS | Ready to accept. |
| PASS_WITH_RISKS | Usable with explicit non-blocking risks. |
| FAIL | Not ready; list required repairs. |

Notify the main conversation after writing the report.
Append `VALIDATION_COMPLETED` to `EVENT_LOG.md` and use the main transport recorded in `agents.yaml`. Remain read-only in both execution topologies.
