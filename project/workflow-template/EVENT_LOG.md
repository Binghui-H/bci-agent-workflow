# EVENT_LOG

这是跨角色通信的追加式事件记录。消息负责唤醒角色，本文件负责保存事件事实。

## 事件类型

| 事件 | 含义 |
|---|---|
| WORKFLOW_INITIALIZED | 主会话已初始化工作流和角色注册表 |
| DESIGN_READY | 设计文档已完成，等待门禁处理 |
| DESIGN_APPROVED | 用户或自动化门禁已批准设计 |
| PHASE_READY_FOR_REVIEW | 当前实现阶段已完成并等待审阅 |
| REPAIR_REQUESTED | 审阅发现需要返修的问题 |
| REPAIR_READY | 执行角色已完成返修并等待复审 |
| PHASE_APPROVED | 当前阶段审阅通过 |
| VALIDATION_REQUESTED | 全部阶段完成，等待最终验证 |
| VALIDATION_COMPLETED | 最终验证完成 |
| WORKFLOW_BLOCKED | 流程因阻塞项停止 |

## 事件记录

| 事件 ID | 时间 | 来源角色 | 目标角色 | 事件类型 | 阶段 | 关联产物 | 投递状态 | 处理结果 |
|---|---|---|---|---|---|---|---|---|
| EVT-0001 | <fill-time> | main | design | WORKFLOW_INITIALIZED | N/A | RUN_STATE.md | recorded | pending |
