# BCI Contract Reference

## Signal data

| Field | Questions |
|---|---|
| Type | EEG, EMG, EOG, IMU, respiration, ECG, or multimodal? |
| Shape | Which axis is channels, samples, features, or batch? |
| Channels | Names, order, montage, reference channel, bad-channel rules. |
| Units | uV, mV, g, deg/s, normalized value, logits, probabilities. |
| Sampling rate | Fixed or variable? Per modality? Stored where? |

## Timeline and windows

| Field | Questions |
|---|---|
| Sample index | Zero-based or one-based? Inclusive or exclusive ranges? |
| Timestamp | Device time, wall clock, monotonic clock, or derived? |
| Window | Length, step, overlap, boundary padding, minimum valid samples. |
| Latency | Algorithmic latency, buffering latency, output timestamp semantics. |

## Filtering and state

- Mark every filter causal or non-causal.
- State whether filter state persists across windows.
- Define initialization, warm-up, reset, and discontinuity behavior.
- Do not compare offline zero-phase filtering to online causal filtering as equivalent.

## Artifact and missing-data handling

Record behavior for NaN, Inf, flatline, saturation, disconnected channel, blink artifact, EMG contamination, motion artifact, and short windows.

## Evaluation

Use subject/session separation when evaluating generalization. Report whether metrics are window-level, trial-level, session-level, or subject-level.

## Safety boundary

Use engineering terms such as classification, detection, score, confidence, or event estimate. Do not claim diagnosis, treatment, or clinical decision support unless the user explicitly scopes regulated medical work and supplies appropriate requirements.

