---
name: bci-orchestrator
description: Coordinate a BCI algorithm workflow with shared .agent-workflow documents, role skills, stage gates, event routing, and configurable execution topology. Use when Codex must run design/implementation/review/validation either as internal subagents under one main conversation or as separate persistent Codex threads for each role.
---

# BCI Orchestrator

Use this skill from the main conversation. Own workflow state, user confirmations, role lifecycle, event routing, and final acceptance.

## Initialize

1. Ensure `.agent-workflow/` exists.
2. Read `workflow.config.yaml`, `agents.yaml`, `RUN_STATE.md`, and `EVENT_LOG.md`.
3. Read `execution.topology` before creating any role.
4. Read `references/execution-topologies.md` and use only the selected topology Adapter.
5. Keep critical facts in files; use messages only to notify or wake roles.

## Automation modes

| Mode | Behavior |
|---|---|
| `gated` | Stop after design and ask the user before implementation. |
| `phase_gated` | Ask before every major phase or risky gate. |
| `full_auto` | Continue when no blocking questions, P0/P1 issues, missing tests, or safety concerns exist. |

Even in `full_auto`, stop for unclear signal/window semantics, unclear labels, medical-diagnosis claims, destructive actions, new production dependencies, repeated failed repairs, or missing test evidence.

## Role lifecycle

1. Create or wake design with `bci-design` and `bci-domain`.
2. Wait for `TASK.md`, `DESIGN.md`, `PHASE_PLAN.md`, and `DESIGN_READY`.
3. Apply the design gate and record `DESIGN_APPROVED`.
4. Create or wake implementation with `bci-implement`.
5. Route `PHASE_READY_FOR_REVIEW` to review with `bci-review-repair`.
6. Loop `REPAIR_REQUESTED` and `REPAIR_READY` until review closes the phase.
7. Route `VALIDATION_REQUESTED` to validation with `bci-validation`.
8. Read `VALIDATION_REPORT.md`, record `VALIDATION_COMPLETED`, and report to the user.

## Registry and reuse

- Record each role's `transport.kind` and matching identifiers in `agents.yaml`.
- For `subagents`, record `agent_id` and `canonical_name`.
- For `separate_threads`, record `thread_id` and `host_id`.
- If `reuse_existing_role` is true, wake the existing role. Never create a duplicate role just because it is idle or completed.

## State and communication

- Treat the main conversation as the only state-transition authority.
- Allow adjacent roles to send direct notifications, but require a copy to main and an `EVENT_LOG.md` entry.
- Require the current writer in `RUN_STATE.md` to match the role before code or workflow files are edited.
- Let users chat directly with role threads only in `separate_threads`; role threads must still respect gates and notify main before the workflow advances.

