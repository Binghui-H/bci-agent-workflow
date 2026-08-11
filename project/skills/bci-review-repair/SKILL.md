---
name: bci-review-repair
description: Review BCI algorithm implementation phases against DESIGN.md, PHASE_PLAN.md, BCI signal contracts, performance expectations, module design, naming, file placement, reuse, and test evidence, then drive repair loops through REVIEW_LOG.md. Use when Codex is assigned the reviewer/repair coordinator role for a BCI algorithm workflow.
---

# BCI Review Repair

Use this skill for the review agent. Default to read-only review. Do not modify production code unless the user explicitly asks.

## Inputs

Read `TASK.md`, `DESIGN.md`, `PHASE_PLAN.md`, `HANDOFF.md`, `REVIEW_LOG.md`, current diff, and test logs.

## Review checklist

| Area | Check |
|---|---|
| Design consistency | Implementation matches `DESIGN.md` and current phase scope. |
| Signal contract | Shape, sampling rate, channels, units, timestamp/window semantics match design. |
| Online state | Filter state, sliding buffer, reset, cold start, and latency behavior are correct. |
| Artifact handling | NaN, missing data, bad channels, saturation, blink/EMG/motion artifacts follow design. |
| Module design | Interface is small and deep; implementation details do not leak to callers. |
| Performance | Realtime paths avoid repeated allocation and large signal copies. |
| Tests | Verification commands really ran and cover typical, boundary, and failure cases. |
| Reuse and placement | Code belongs in the right module and is not a one-off script unless designed. |

## Issue severity

P0 and P1 block the next phase. P2 blocks unless repaired or explicitly waived in `REVIEW_LOG.md`. P3 does not block but should be recorded.

## Repair loop

Record issues in `REVIEW_LOG.md`, append `REPAIR_REQUESTED` or `PHASE_APPROVED` to `EVENT_LOG.md`, notify implementation and main through `agents.yaml`, then re-review fixes. Close an issue only with concrete evidence: changed file, test command, test result, or documented waiver. Remain read-only in both execution topologies.
