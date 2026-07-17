# 1-FOUNDATIONS

## Current Facts

- The repository contains a local Markdown transcription and PDF facsimile of
  the 1935 EPR paper.
- Before this stage, the repository had no Lean project or Lean source.
- Lean `v4.31.0` and Lake for that toolchain are installed locally.
- A local checkout of mathlib tag `v4.31.0` identifies commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- The pinned mathlib surface contains complex matrices, Hermitian and positive
  semidefinite predicates, trace, Kronecker products, and algebraic tensor
  products.
- Source searches did not find a project-ready density-matrix,
  quantum-measurement, Kraus/POVM, or partial-trace abstraction at that
  revision.

## Updated Assumptions

- Basis-indexed matrices should be sufficient for the finite-dimensional core;
  this is tested by the API probe but remains provisional until the Bell-state
  calculations compile.
- Pure-state vectors and density matrices will both be useful. Stage 2 should
  add invariant-carrying structures rather than treating raw vectors/matrices
  as physical states.
- The finite partial trace will likely need a small explicit indexed-sum
  definition in Stage 3.
- Projective measurements are sufficient for the initial steering example;
  no current requirement justifies a general measurement-instrument framework.
- Abstract Hilbert tensor products are available, but using them as the core
  representation would add complexity without yet solving partial trace.
- Interpretative premises can remain in a low-dependency logical layer and do
  not require quantum analytic imports.

## Big Picture Objective

Establish a minimal, pinned, validated Lean project and select representations
based on the actual mathlib surface rather than assumptions.

## Detailed Implementation Plan

- Pin Lean `v4.31.0` and mathlib commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Create a minimal Lake project under `formal/` with `EPR` as its public root.
- Add only raw basis-indexed ket/operator aliases in `EPR.Foundations`; do not
  define physical states or postulate substantive theorems.
- Add `EPR.Audit.ApiProbe` as a diagnostic leaf that compile-checks matrix,
  positivity, trace, Kronecker, outer-product, and tensor-product APIs.
- Create living paper-map, correction-log, and dependency-decision documents.
- Validate the focused probe, full project, source scans, and whitespace.

Expected files:

- `formal/lean-toolchain`
- `formal/lakefile.toml`
- `formal/lake-manifest.json`
- `formal/EPR.lean`
- `formal/EPR/Foundations.lean`
- `formal/EPR/Audit/ApiProbe.lean`
- `docs/PaperMap.md`
- `docs/Corrections.md`
- `docs/Dependencies.md`
- `README.md`
- `goal-1/0-plan.md`
- `goal-1/1-FOUNDATIONS.md`

## No-Cheating Checks

- Scan completed Lean sources for `sorry`, `admit`, `axiom`, `unsafe`, and
  proof-escape declarations.
- Confirm the public root imports foundations but not the diagnostic probe.
- Confirm raw aliases do not claim normalization, positivity, Hermiticity,
  measurement semantics, locality, or physical reality.
- Confirm no continuous-variable generalized function is represented as a
  normalized Hilbert-space vector.
- Confirm the dependency is an exact commit rather than a floating branch.

## Completion Requirements

- `cd formal && lake build EPR.Audit.ApiProbe` succeeds.
- `cd formal && lake build` succeeds.
- Exact Lean/mathlib versions and setup commands are documented.
- Representation decisions are backed by the compile-checked probe or a
  documented source search/obstruction.
- No substantive theorem is postulated.
- Lean-source scans find no proof holes, project axioms, `unsafe` escape, or
  philosophical claims.
- `git diff --check` succeeds.
- Exact commands and results appear below and are folded into `0-plan.md`.

## Stage Results

- In progress.
