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
- `formal/.gitignore`
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

- **Result:** Complete on 2026-07-17. Stage 2 was not started.
- `lake update` created `formal/lake-manifest.json`, checked out mathlib at
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`, and pinned all transitive
  packages.
- `lake env lean --version` reported Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`.
- `git -C .lake/packages/mathlib rev-parse HEAD` reported the configured
  mathlib commit, and `git describe --tags --exact-match` reported `v4.31.0`.
- The first focused build correctly failed because the narrow matrix imports
  did not expose complex notation. Adding the explicit complex import and a
  public module section fixed the import boundary.
- The second focused build exposed that the generic
  `posSemidef_vecMulVec_self_star` theorem asks for `StarOrderedRing ℂ`, which
  is unavailable. The final probe instead uses the appropriate `RCLike`
  theorem `Matrix.posSemidef_iff_eq_sum_vecMulVec` under `ComplexOrder` and
  proves rank-one complex positivity without adding an axiom.
- `lake exe cache get` restored the official pinned mathlib build cache after a
  deliberately clean project check.
- Final focused command
  `cd formal && lake build EPR.Audit.ApiProbe` succeeded with 2663 jobs. Its
  output confirmed every declaration listed in `docs/Dependencies.md`.
- Final full command `cd formal && lake build` succeeded with 2029 jobs and
  built the public `EPR` root.
- The proof-escape scan
  `rg -n "\\b(sorry|admit|axiom|unsafe)\\b" formal/EPR formal/EPR.lean`
  returned exit status 1 with no matches.
- The project-specific philosophical/continuum shortcut scan returned exit
  status 1 with no matches in Lean sources.
- A declaration search for density-matrix, partial-trace, POVM, Kraus,
  quantum-state, and quantum-measurement definitions in the pinned mathlib
  source returned exit status 1 with no matches. This supports only the stated
  API-availability decision, not a mathematical claim.
- The trailing-whitespace scan over all Stage 1 files returned exit status 1
  with no matches.
- `jq` validation of `formal/lake-manifest.json` returned `true` for the exact
  mathlib revision.
- `git diff --check` succeeded.
- `formal/.lake/` is excluded by `formal/.gitignore`; generated caches and
  dependency checkouts are not project source.

## What Was Learned

- Basis-indexed matrices are supported well enough to proceed with the finite
  core while retaining explicit subsystem order through product indices.
- Complex positivity requires the scoped `ComplexOrder` API and, for rank-one
  decompositions, the `RCLike` inner-product characterization rather than the
  more general scalar lemma.
- A project-owned density-state structure and partial trace remain real proof
  obligations for Stages 2 and 3.
- The plan's separation between mathematical, operational, and interpretative
  layers remains viable and unchanged.

## Plan Update

- `0-plan.md` now records the exact pins, checked API surface, representation
  decision, ignored build artifacts, and Stage 1 completion.
- `2-QUANTUM-CORE` is the first incomplete stage. It should begin by defining
  normalization-bearing pure states and positive trace-one density matrices;
  no Stage 2 implementation was included here.
