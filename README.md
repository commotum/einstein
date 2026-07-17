# EPR Formalization

This repository is being developed into a pinned Lean 4/mathlib library that
reconstructs and audits Einstein, Podolsky, and Rosen's 1935 completeness
argument. The mathematical finite-dimensional example and the paper's
interpretative premises will remain explicitly separated.

The authoritative execution plan is [`goal-1/0-plan.md`](goal-1/0-plan.md).
The local source transcription is
[`einstein-1935/einstein-1935.md`](einstein-1935/einstein-1935.md), and the
living source audit is under [`docs/`](docs/).

## Lean setup

The Lean project is rooted at `formal/` and pins Lean and mathlib exactly.

```text
cd formal
lake update
lake build EPR.Audit.ApiProbe
lake build
```

No philosophical criterion in the paper is intended to become an
unconditional theorem about physical reality. The eventual EPR incompleteness
result must state its reality, locality, counterfactual, and completeness
premises explicitly.
