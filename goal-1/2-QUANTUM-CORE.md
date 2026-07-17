# 2-QUANTUM-CORE

## Current Facts

- Stage 1 is committed and the worktree was clean at Stage 2 start.
- Lean is pinned to `v4.31.0` and mathlib to commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- `EPR.Foundations` supplies raw finite complex kets and matrices only.
- The checked mathlib surface supplies matrix trace, multiplication,
  Hermitian and positive-semidefinite predicates, outer products, and an
  `RCLike` characterization of complex positive-semidefinite matrices.
- No project-owned physical state, observable, outcome, probability, or
  sharpness definition exists yet.
- Stage 1 found no ready-made density-matrix or projective-measurement API at
  the pinned revision.

## Updated Assumptions

- A normalized pure state can carry the finite-basis equation
  `ψ ⬝ᵥ star ψ = 1`; this matches the trace of `vecMulVec ψ (star ψ)` directly.
- A density state should carry `Matrix.PosSemidef` and trace one. Positivity
  already includes Hermiticity, so duplicating a Hermitian field would create
  unnecessary proof obligations.
- A projective outcome should use a nonzero Hermitian idempotent projector and
  an eigenspace equation. The projector need not have rank one, so degeneracy
  remains supported.
- Born probability should be the real part of `trace (P * ρ)`. Its reality and
  probability bounds are mathematical obligations; Stage 2 must at least prove
  the normalization cases used by sharpness and must not encode bounds by fiat.
- Density-state sharpness can be stated basis-independently within the matrix
  representation as `A * ρ = a • ρ`, meaning the support lies in the
  `a`-eigenspace. Joint sharpness is existence of two such real values.
- The converse from probability one to projector support may require more
  positive-operator infrastructure. If it is not proved here, the distinction
  must remain explicit rather than becoming an assumption.

## Big Picture Objective

Define the reusable finite-dimensional state, observable, outcome, sharpness,
and Born-probability vocabulary needed by later stages, with all physical
invariants carried by types or explicit hypotheses.

## Detailed Implementation Plan

- Add `EPR.Quantum.Core` as a narrow public module over `EPR.Foundations`.
- Define normalization-bearing `PureState` and positive trace-one
  `DensityState` structures.
- Prove neither can contain the zero vector/matrix.
- Define pure-to-density conversion and prove positivity and trace one.
- Define Hermitian `Observable`, orthogonal `Projection`, and nonzero
  possibly-degenerate `ProjectiveOutcome`.
- Define Born weight/probability, projector support, pure eigenstates,
  density-state sharp values, and joint sharpness as distinct notions.
- Prove support gives probability one and a spectral outcome plus support gives
  a density sharp value.
- Prove pure eigenstates yield sharp density states and that a density state
  cannot have two different sharp values for the same observable.
- Add an audit/smoke module covering a qubit basis state, identity outcome,
  nonzero invariants, and degenerate-projector compatibility.
- Add a diagnostic `#print axioms` module for the main Stage 2 theorems.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Core.lean`
- `formal/EPR/Audit/QuantumCore.lean`
- `formal/EPR/Audit/QuantumCoreAxioms.lean`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/2-QUANTUM-CORE.md`

## No-Cheating Checks

- Raw vectors and matrices may not be silently coerced into physical states.
- Pure and density constructors must require actual normalization/positivity
  proofs; zero data must be ruled out by checked theorems.
- Projective outcomes must not assume one-dimensional eigenspaces.
- Probability one, eigenspace support, and possessed/sharp value must remain
  distinct definitions connected only by proved implications.
- No philosophical reality, locality, completeness, or disturbance predicate
  may enter the quantum core.
- No continuous-variable object, plane wave, or delta distribution may enter
  the finite core.
- Scan for `sorry`, `admit`, `axiom`, `unsafe`, and theorem escape routes.

## Completion Requirements

- State definitions enforce normalization and positivity and exclude zero data.
- Observable and projective-outcome definitions do not assume nondegeneracy.
- Born probability, sharp value, and joint sharpness are reusable and separate.
- Generic eigenstate, projector-support, and probability-one lemmas compile.
- The audit module checks identity and qubit examples plus invalid-zero
  boundaries.
- `lake build EPR.Quantum.Core`, both Stage 2 audit modules, and the public
  `EPR` consumer succeed.
- The full build, proof/shortcut scans, whitespace checks, `git diff --check`,
  and `#print axioms` audit succeed with recorded output.

## Stage Results

- In progress.
