---
name: bci-implement
description: Implement an approved BCI algorithm phase from .agent-workflow/DESIGN.md and PHASE_PLAN.md, preserving signal contracts, module interfaces, tests, and review handoff evidence. Use when Codex is assigned the implementation role for a BCI algorithm workflow phase.
---

# BCI Implement

Use this skill for the implementation agent. Modify code only within the current approved phase.

## Before editing

1. Read `TASK.md`, `DESIGN.md`, `PHASE_PLAN.md`, `RUN_STATE.md`, and any open `REVIEW_LOG.md` issues.
2. Confirm the current phase, allowed modification scope, and verification commands.
3. Stop if design is not approved in `gated` or `phase_gated` mode.
4. Confirm `RUN_STATE.md` names implementation as the current writer.

## Implementation rules

- Preserve input/output signal contracts from `DESIGN.md`.
- Keep algorithm behavior behind the designed Interface.
- Avoid widening scope, changing labels, changing shape conventions, or adding dependencies without a gate.
- Keep realtime paths allocation-aware; avoid repeated large signal copies in loops.
- Prefer tests through public Interfaces rather than internal implementation details.

## Phase handoff

After each phase:

1. Run the phase verification commands.
2. Update `HANDOFF.md` with changed files, commands, results, and known risks.
3. Append `PHASE_READY_FOR_REVIEW` or `REPAIR_READY` to `EVENT_LOG.md`.
4. Notify review and main through the transports recorded in `agents.yaml`.
5. Let main update `RUN_STATE.md` after validating the event and gate.
