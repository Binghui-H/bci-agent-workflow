# BCI Agent Workflow

这是一个面向脑机接口（BCI）算法研发的 Codex 多 agent 工作流项目。它把“agent 互相通信”降级为事件通知，把“共享任务文档 + 阶段门禁 + skills 触发规则”作为主架构。

## 目录结构

| 路径 | 作用 |
|---|---|
| `architecture/` | 这一套流程的架构说明、通信协议、状态机和架构图 |
| `project/` | 可复制到实际代码仓库里的流程项目，包括 skills、模板、脚本和 AGENTS.md |
| `project/skills/` | 6 个可复用 skills：编排、设计、执行、审阅返修、验证、BCI 领域规范 |
| `project/agent-prompts/` | 创建各角色对话时可直接使用的启动提示模板 |
| `project/workflow-template/` | 每次 BCI 算法任务生成的共享任务文档模板 |
| `project/scripts/` | 初始化 workflow、安装 skills 的辅助脚本 |

## 快速使用

以下命令均在克隆后的仓库根目录执行，不依赖仓库在本机的绝对位置。

1. 安装 skills 到 Codex 用户 skills 目录：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1
```

更新已经安装的同名 skills 时，显式使用 `-Force`：

```powershell
powershell -ExecutionPolicy Bypass -File .\install.ps1 -Force
```

2. 在目标算法仓库初始化工作流：

```powershell
powershell -ExecutionPolicy Bypass -File .\project\scripts\init-bci-workflow.ps1 `
  -TargetRepo ..\your-repository `
  -Mode gated `
  -Topology subagents
```

`-TargetRepo` 相对于当前 PowerShell 工作目录解析；示例假设工作流仓库与目标仓库位于同一父目录。

3. 在目标仓库的主对话里启动：

```text
使用 $bci-orchestrator，按 .agent-workflow 配置开始一个脑机算法开发流程。
```

可选模式：

| 模式 | 含义 |
|---|---|
| `gated` | 默认模式。设计完成后必须用户确认，才进入执行 |
| `phase_gated` | 每个阶段开始或关键门禁都建议用户确认 |
| `full_auto` | 无阻塞项时自动推进；遇到领域判断、安全边界、破坏性操作仍停下 |

可选执行拓扑：

| 拓扑 | 含义 |
|---|---|
| `subagents` | 一个主会话创建内部角色子 agent；用户主要和主会话沟通 |
| `separate_threads` | 主、设计、执行、审阅返修、验证分别使用独立 Codex 会话；用户可直接进入角色会话沟通 |

独立会话模式初始化：

```powershell
powershell -ExecutionPolicy Bypass -File .\project\scripts\init-bci-workflow.ps1 `
  -TargetRepo ..\your-repository `
  -Mode gated `
  -Topology separate_threads
```

## 当前领域范围

当前版本是面向 BCI 与生理信号算法的垂直实现，默认使用 `bci-domain`。角色编排、共享文档和阶段门禁具有通用化基础，但尚未提供可配置的领域包加载机制。

后续领域扩展计划见 [TODO.md](./TODO.md)，目标是允许用户追加自己的领域 skill，而不需要复制或修改角色工作流。

## 架构文档

主文档见 [architecture/ARCHITECTURE.md](./architecture/ARCHITECTURE.md)，完整操作步骤见 [architecture/USAGE.md](./architecture/USAGE.md)。
