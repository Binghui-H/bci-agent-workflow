# Execution Topologies

## Shared Interface

Both topologies use the same roles, state machine, skills, workflow files, gates, event types, and single-writer rule. Only role creation, identifiers, user interaction, and message delivery vary.

## `subagents`

Use one main Codex conversation with internal child agents.

| Concern | Rule |
|---|---|
| Creation | Create internal role agents on demand. |
| Identity | Store `agent_id` and `canonical_name`; leave thread fields empty. |
| Resume | Send a follow-up to the existing role instead of spawning a duplicate. |
| User interaction | User talks to main; main routes targeted requests to the role. |
| Events | Child role notifies main; main advances state and wakes the next role. |
| UI | Roles appear in the main conversation's subagent panel. |

Registry example:

```yaml
design:
  role: background-design
  status: idle
  transport:
    kind: subagent
    agent_id: "<agent-id>"
    canonical_name: "snore-background-design"
    thread_id: ""
    host_id: ""
```

## `separate_threads`

Use one orchestrator thread plus one persistent Codex thread for each role.

| Concern | Rule |
|---|---|
| Creation | Create all role threads up front when `role_creation: upfront`; otherwise create on demand. |
| Workspace | Run every role in the same saved local project checkout. Do not use isolated worktrees for this shared-file workflow. |
| Identity | Store `thread_id` and `host_id`; leave subagent fields empty. |
| Resume | Send a follow-up message to the existing thread. |
| User interaction | User may open a role thread and chat directly. |
| Events | Role thread updates shared files, logs the event, and notifies main. |
| Concurrency | Only the role named as current writer in `RUN_STATE.md` may edit. Review and validation remain read-only. |

Choosing this topology explicitly authorizes the orchestrator to create the four role tasks in the shared local project. Initial prompts must assign one role skill, point to `.agent-workflow`, identify the main thread, and forbid work until the role is activated.

Registry example:

```yaml
design:
  role: background-design
  status: idle
  transport:
    kind: thread
    agent_id: ""
    canonical_name: ""
    thread_id: "<thread-id>"
    host_id: "<host-id>"
```

## Event routing

Use this common sequence:

```text
role writes artifact
  -> role appends EVENT_LOG
  -> role notifies main
  -> main validates gate
  -> main updates RUN_STATE
  -> main wakes next role
```

Direct design-to-implementation or review-to-implementation notifications may reduce latency, but they never authorize a state transition by themselves.
