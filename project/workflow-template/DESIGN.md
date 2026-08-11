# DESIGN

## 信息来源与澄清结论

| 项目 | 状态 | 来源 | 是否阻塞 | 说明 |
|---|---|---|---|---|
| 信号类型 | TBD | TBD | TBD | EEG / EMG / EOG / IMU / mixed |
| 采样率 | TBD | TBD | TBD | 会影响滤波、窗口和频域特征 |
| 通道顺序 | TBD | TBD | TBD | 必须明确通道含义和顺序 |
| 窗口长度 / 步长 | TBD | TBD | TBD | 会影响延迟和频域分辨率 |
| 输出标签语义 | TBD | TBD | TBD | 必须明确分类 / 检测目标 |
| 实时性预算 | TBD | TBD | TBD | 不涉及则标记 N/A |

状态枚举：Confirmed / Inferred / Assumed / Needs User / N/A / Out of Scope。

## 输入契约

| 项目 | 契约 |
|---|---|
| 信号类型 | TBD |
| shape | TBD |
| 通道顺序 | TBD |
| 单位 | TBD |
| 采样率 | TBD |
| 缺失 / 异常行为 | TBD |

## 输出契约

| 项目 | 契约 |
|---|---|
| 输出类型 | TBD |
| 维度 | TBD |
| 标签 / 概率含义 | TBD |
| 错误行为 | TBD |

## 算法流程

1. 预处理：TBD
2. 窗口化：TBD
3. 滤波：TBD
4. 特征提取：TBD
5. 分类 / 检测：TBD
6. 后处理：TBD

## 状态管理

| 状态 | 说明 |
|---|---|
| 滤波器状态 | TBD |
| 滑窗缓存 | TBD |
| 冷启动 | TBD |
| 重置条件 | TBD |

## 模块设计

使用 Module / Interface / Implementation / Seam / Adapter 术语。算法应藏在小而明确的 Interface 后面，测试也通过同一个 Interface 进入。

| Module | Interface | Implementation | Seam / Adapter |
|---|---|---|---|
| TBD | TBD | TBD | TBD |

## 性能预算

| 项目 | 预算 |
|---|---|
| 单窗口耗时 | TBD |
| 内存峰值 | TBD |
| 是否允许实时路径动态分配 | TBD |
| 目标平台 | TBD |

## 测试计划

| 类型 | 计划 |
|---|---|
| 单元测试 | TBD |
| golden 测试 | TBD |
| 边界测试 | TBD |
| 回放 / 对拍 | TBD |
| 性能测试 | TBD |

## 待确认项与阻塞项

| ID | 问题 | 严重性 | 是否阻塞 | 需要谁确认 | 状态 |
|---|---|---|---|---|---|
| Q-001 | TBD | TBD | TBD | TBD | open |

