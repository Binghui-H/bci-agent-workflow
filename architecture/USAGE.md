# 使用说明

## 1. 安装 BCI skills

先进入克隆后的 `bci-agent-workflow` 仓库根目录。以下命令只使用仓库相对路径。

首次安装：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

更新已经安装的同名 skills：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Force
```

默认安装到 `%CODEX_HOME%\skills`；未设置 `CODEX_HOME` 时安装到用户目录的 `.codex\skills`。

## 2. 初始化目标代码仓库

默认模式为 `gated`，设计完成后等待用户确认：

```powershell
powershell -ExecutionPolicy Bypass -File .\project\scripts\init-bci-workflow.ps1 `
  -TargetRepo ..\target-repository `
  -Mode gated `
  -Topology subagents
```

全自动模式：

```powershell
powershell -ExecutionPolicy Bypass -File .\project\scripts\init-bci-workflow.ps1 `
  -TargetRepo ..\target-repository `
  -Mode full_auto `
  -Topology subagents
```

目标仓库会生成 `.agent-workflow/`，其中包含设计、阶段计划、交接、审阅和验证模板。

需要每个角色成为独立 Codex 会话时：

```powershell
powershell -ExecutionPolicy Bypass -File .\project\scripts\init-bci-workflow.ps1 `
  -TargetRepo ..\target-repository `
  -Mode gated `
  -Topology separate_threads
```

`-TargetRepo` 相对于当前 PowerShell 工作目录解析。上述示例假设两个仓库位于同一父目录；也可以传入其他有效的相对路径。

`separate_threads` 会配置 `role_creation: upfront`。主会话应在同一个本地项目 checkout 中创建四个角色会话，不能为角色使用互相隔离的 worktree。

## 3. 项目规则

将 [`project/AGENTS.md`](../project/AGENTS.md) 的规则合并到目标仓库现有 `AGENTS.md`。如果目标仓库没有 `AGENTS.md`，可以直接使用这份文件作为起点。

不要直接覆盖已有 `AGENTS.md`，因为其中可能包含项目自己的构建、测试和代码规范。

## 4. 启动主对话

在目标代码仓库打开 Codex 主对话，发送：

子 agent 模式：

```text
使用 $bci-orchestrator，按 .agent-workflow 配置启动这个仓库的 BCI 算法开发流程。
```

独立会话模式：

```text
使用 $bci-orchestrator，按 .agent-workflow 配置启动这个仓库的 BCI 算法开发流程。
为四个角色创建独立会话并登记 thread_id；用户可以直接进入角色会话沟通，但只能由主会话推进 RUN_STATE。
```

如果选择 `full_auto`：

```text
使用 $bci-orchestrator 以 full_auto 模式启动这个仓库的 BCI 算法开发流程。
无阻塞澄清项、无 P0/P1、测试证据完整时自动推进。
遇到领域语义不清、安全边界、破坏性操作或多轮返修失败时停止并通知我。
```

## 5. 运行过程

| 阶段 | 主要产物 | 默认动作 |
|---|---|---|
| 背景和设计 | `TASK.md`、`DESIGN.md`、`PHASE_PLAN.md` | `gated` 模式等待用户确认 |
| 阶段实现 | 代码、测试、`HANDOFF.md` | 通知审阅角色 |
| 审阅返修 | `REVIEW_LOG.md` | 有阻塞问题则通知执行角色返修 |
| 最终验证 | `VALIDATION_REPORT.md` | 通知主对话最终验收 |

## 6. 查看当前状态

优先查看：

1. `.agent-workflow/RUN_STATE.md`
2. `.agent-workflow/agents.yaml`
3. `.agent-workflow/REVIEW_LOG.md`
4. `.agent-workflow/VALIDATION_REPORT.md`
5. `.agent-workflow/EVENT_LOG.md`

聊天消息只负责通知，以上文件才是流程事实来源。

## 7. 直接与角色沟通

| 拓扑 | 操作方式 |
|---|---|
| `subagents` | 在主会话指定角色，由主会话向已有 `agent_id` 发送 follow-up |
| `separate_threads` | 打开角色会话直接沟通；角色完成后必须更新共享产物、追加事件并通知主会话 |

直接与角色会话沟通不会自动批准下一阶段。回到主会话确认后，才能由 orchestrator 更新状态并继续流程。
