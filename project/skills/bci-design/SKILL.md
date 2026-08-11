---
name: bci-design
description: Design BCI algorithms before implementation by producing TASK.md, DESIGN.md, and PHASE_PLAN.md with signal contracts, clarification gates, module interfaces, state handling, performance budgets, and tests. Use when Codex must turn a BCI/EEG/EMG/EOG/IMU algorithm request into an implementable technical design and phased plan.
---

# BCI Design

Use this skill for the background-design agent. Do not modify production code.

## Required outputs

- `.agent-workflow/TASK.md`
- `.agent-workflow/DESIGN.md`
- `.agent-workflow/PHASE_PLAN.md`
- Update `.agent-workflow/RUN_STATE.md`
- Append `DESIGN_READY` to `.agent-workflow/EVENT_LOG.md`

## Clarification gate

Classify every important BCI contract item before writing the final design:

| Status | Meaning |
|---|---|
| Confirmed | User, code, config, data, or docs explicitly establish it. |
| Inferred | Reliable local evidence implies it; record the source. |
| Assumed | Low-risk assumption; record it and continue. |
| Needs User | Missing answer changes algorithm behavior, interface, tests, or safety. |
| N/A | Not relevant to this task. |

Ask the user only for blocking items. Do not ask about information already present in code, docs, configs, metadata, or tests. If an item is not involved in this task, mark it `N/A`.

## Design contents

Include signal type, shape, channels, units, sampling rate, timestamp/sample index semantics, window length, step, latency, filter causal behavior, state reset, artifact handling, feature extraction, classifier/detector outputs, evaluation metrics, tests, and safety boundaries.

## Module design

Use Module / Interface / Implementation / Seam / Adapter vocabulary. Prefer a small, deep Interface that hides filtering, windowing, feature extraction, and decision logic behind testable modules.

## Phase planning

Split complex work into phases with allowed files, verification commands, deliverables, and pass criteria. Do not let implementation begin if blocking clarification questions remain.

Read `execution.topology` and `agents.yaml` before notifying completion. Notify main through the registered subagent or thread transport; never advance the workflow directly.
