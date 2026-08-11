# 主会话启动提示

## 内部子 Agent 模式

```text
使用 $bci-orchestrator，按 .agent-workflow 配置启动当前 BCI 算法任务。
execution.topology 使用 subagents；复用 agents.yaml 中已有 agent_id，不重复创建同角色。

任务和初步设计：
【填写】
```

## 独立角色会话模式

```text
使用 $bci-orchestrator，按 .agent-workflow 配置启动当前 BCI 算法任务。
execution.topology 使用 separate_threads；在同一个本地项目 checkout 中创建并登记设计、执行、审阅返修、验证四个独立会话。
用户可以直接进入角色会话沟通，但只有主会话可以推进 RUN_STATE；所有角色必须写 EVENT_LOG 并通知主会话。

任务和初步设计：
【填写】
```

