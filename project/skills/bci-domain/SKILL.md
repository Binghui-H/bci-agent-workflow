---
name: bci-domain
description: Apply brain-computer interface domain rules for EEG, EMG, EOG, IMU, multimodal biosignal algorithms, online decoding, filtering, windowing, artifact handling, feature extraction, evaluation metrics, latency, and safety boundaries. Use with any BCI algorithm design, implementation, review, or validation task.
---

# BCI Domain

Use this skill whenever the task involves BCI or biosignal algorithms. It is role-neutral: design, implementation, review, and validation agents should apply it when relevant.

## Core contracts

Always consider:

| Topic | Required checks |
|---|---|
| Signal data | Signal type, channel order, unit, sampling rate, shape, missing values. |
| Timeline | Sample index, timestamp, window length, step, latency, boundary padding. |
| Filtering | Causal/non-causal behavior, state across windows, initialization, reset. |
| Realtime | Per-window time, memory peak, dynamic allocation, latency budget. |
| Artifacts | Blink, EMG, motion, bad channels, missing values, saturation. |
| Features | Bandpower, CSP, PSD, time-domain stats, frequency resolution, normalization. |
| Classification/detection | Thresholds, probability meaning, confidence, cold start, online updates. |
| Metrics | Accuracy, F1, AUC, ITR, latency, false positive rate, subject/session split. |
| Test data | Synthetic, recorded, edge cases, golden outputs, subject/session separation. |
| Safety | Do not present engineering outputs as medical diagnosis. |

For detailed checklists, read `references/bci-contracts.md` when the task needs design, review, or final validation detail.

