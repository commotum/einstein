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

- **Result:** Complete on 2026-07-17. Stage 3 was not started.
- The four-page image-only PDF facsimile was inspected directly after
  `pdfinfo` confirmed its page count and `pdftotext` confirmed that it has no
  text layer. Rendered pages 777–780 visually match the local transcription at
  the Stage 2 source loci: the probability-one criterion, Eqs. (1)–(6), the
  noncommutation claim, and the later separation/locality argument. No paper
  correction or Stage 2 scope decision changed.
- `EPR.Quantum.Core` defines `PureState` with finite-basis normalization and
  `DensityState` with positive semidefiniteness and trace one. Checked
  `ne_zero` theorems prevent zero ket or zero matrix data from satisfying the
  physical-state APIs.
- `PureState.toDensity` constructs a positive trace-one rank-one density state.
  The proof uses the pinned `RCLike` positive-semidefinite decomposition rather
  than a project axiom.
- `Observable`, `Projection`, and `ProjectiveOutcome` separate Hermiticity,
  idempotence, nonzero outcome support, and the spectral equation. No rank-one
  condition is imposed.
- `bornWeight` retains the complex trace expression and
  `outcomeProbability` takes its real part. `star_bornWeight` and
  `coe_outcomeProbability` prove the expression is real;
  `outcomeProbability_eq_one_of_support` proves the normalization case used by
  sharpness. General probability bounds are not assumed or hidden in fields.
- Pure eigenstates, projector support, density sharp values, and joint
  sharpness are separate predicates. Proved implications connect pure
  eigenstates and spectral support to sharp values, while
  `sharpValue_unique` excludes two distinct values for one observable.
- `EPR.Audit.QuantumCore` constructs normalized `|0⟩` and `|1⟩` qubit
  states and proves they are distinct. It checks both nonzero invariants,
  identity-observable eigenstate equations, support, probability one,
  sharpness through both generic routes, and sharp-value uniqueness.
- The audit's identity projector supports both distinct basis states. This is
  a checked degenerate-outcome example and confirms that the API does not
  silently impose a one-dimensional eigenspace.
- The first audit build failed because the pinned API exposes `dotProduct`
  unnamespaced rather than as `Matrix.dotProduct`. Replacing the stale name and
  making the audit module's import public for its public declarations fixed
  the diagnostic without changing the mathematical core.
- Focused command
  `cd formal && lake build EPR.Quantum.Core EPR.Audit.QuantumCore EPR.Audit.QuantumCoreAxioms EPR`
  succeeded with 2667 jobs.
- Required full command `cd formal && lake build` succeeded with 2665 jobs.
- `EPR.Audit.QuantumCoreAxioms` printed the axiom dependencies of the principal
  Stage 2 definitions and theorems. Every audited declaration reported exactly
  `propext`, `Classical.choice`, and `Quot.sound`; no project-specific axiom was
  present.
- The proof-escape scan
  `rg -n "\\b(sorry|admit|axiom|unsafe)\\b" formal/EPR formal/EPR.lean`
  found only the word `axiom` in explanatory comments in
  `EPR.Audit.QuantumCoreAxioms`; it found no declaration or proof escape.
- The philosophical/continuum shortcut scan over the Stage 2 core and smoke
  audit found only the core module's explicit disclaimer that it makes no
  claim about physical reality or locality.
- The declaration-only scan for lines beginning with `axiom`, `opaque`, or
  `unsafe` returned exit status 1 with no matches. The separate `sorry|admit`
  scan likewise returned exit status 1 with no matches.
- Public-import inspection showed the intended narrow chain
  `EPR -> EPR.Quantum.Core -> EPR.Foundations`; both audit modules remain
  outside the public root, and the successful build rules out an import cycle.
- `lake env lean --version` reconfirmed Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`. `jq` reconfirmed the exact
  mathlib manifest revision
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- The trailing-whitespace scan over every Stage 2 source and documentation file
  returned exit status 1 with no matches. `git diff --check` succeeded.

## What Was Learned

- Basis-indexed matrices support the required invariant-carrying state and
  sharpness layer without introducing a general quantum-information framework.
- Positivity already supplies Hermiticity for density states, so no duplicate
  field is needed.
- Probability one, projector support, eigenstate status, and sharpness can stay
  distinct while still supporting short generic implications.
- Degenerate outcomes fit the selected representation without special cases.
- The standard finite-matrix proofs carry the expected classical/mathlib axiom
  footprint and no project-owned trusted assumption.

## Plan Update

- `0-plan.md` records the completed core API, checked theorem set, degenerate
  smoke example, and standard axiom footprint.
- `3-BIPARTITE` is now the first incomplete stage. It must re-audit the pinned
  Kronecker and finite-sum APIs before introducing subsystem operations or
  partial trace; no Stage 3 implementation is included here.
