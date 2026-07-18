# 6-INCOMPATIBILITY

## Current Facts

- Stages 1–5 are complete. The checked target observables are the Pauli
  `X` and `Z` values defined by `EPR.Examples.BellSteering` on `Fin 2`.
- Stage 6 starts with successful focused and full baselines:
  `lake build EPR.Examples.BellSteering` completes with 3202 jobs and
  `lake build` completes with 3204 jobs. Proof-hole and declaration-level
  project-axiom scans have no matches.
- The only preexisting working-tree change is the completed
  `goal-1/5-STEERING.md` evidence record. It is authoritative prior-stage work
  and must not be overwritten or discarded.
- The paper facsimile was inspected directly at page 778 and compared with
  lines 78–80 of the local transcription. The source says generally that
  noncommuting operators preclude simultaneous precise knowledge. That claim
  is false without additional hypotheses in dimensions above two because
  noncommuting Hermitian operators can share an eigenvector.
- `EPR.Quantum.Core` already defines normalized pure states, raw Hermitian
  observables, `PureState.IsEigenstate`, `DensityState.SharpValue`, and
  `DensityState.JointlySharp`. A density state is jointly sharp when it has a
  real sharp value for each observable in the same state.
- Pinned Lean/mathlib already defines `Commute a b` as `a * b = b * a`; this
  should be reused for observable matrices. A pinned-source search found no
  project-ready quantum predicate or theorem for common eigenvectors versus
  jointly sharp density states.

## Updated Assumptions

- Matrix noncommutation and absence of a common sharp state must be separate
  predicates and separately checked theorems. The final exclusion may use the
  latter, never bare noncommutation.
- A reusable generic bridge should cover mixed density states: if one density
  state is sharp for both observables, a nonzero column of its trace-one matrix
  is a common raw eigenvector. Contraposition then turns a checked
  no-common-eigenvector proof into no jointly sharp density state.
- The Pauli proof must quantify over an arbitrary raw nonzero ket and arbitrary
  real eigenvalues. Proving only that the four named Stage 5 eigenstates fail
  to overlap would omit possible eigenvectors and is insufficient.
- A checked `Fin 3` counterexample must exhibit two Hermitian observables that
  do not commute but share a normalized eigenstate and hence a jointly sharp
  pure density. This documents why the generic implication from
  noncommutation to no-common-sharp-state is invalid.
- This stage remains mathematical. It introduces no measurement occurrence,
  no-signalling, locality/no-disturbance, element of reality, simultaneous
  ontic reality, completeness, counterfactual, incompleteness, or continuum
  claim.

## Big Picture Objective

Build the exact reusable incompatibility obstruction needed by the finite EPR
example: prove separately that Pauli `X` and `Z` do not commute, have no common
nonzero eigenvector, and admit no jointly sharp pure or mixed density state,
while providing a checked higher-dimensional counterexample to the invalid
general inference from noncommutation alone.

## Detailed Implementation Plan

- Add a generic `EPR.Quantum.Incompatibility` module over the checked quantum
  core. Reuse mathlib's `Commute` for observable matrices and define distinct
  predicates for noncommutation, common raw eigenvectors, and existence or
  absence of a jointly sharp density state.
- Prove that every jointly sharp density state supplies a common nonzero raw
  eigenvector by selecting a nonzero column of its nonzero trace-one matrix and
  transporting both sharp matrix equations to that column.
- Derive the generic implication from no common eigenvector to no jointly
  sharp density state. Do not add the false implication from noncommutation.
- Add `EPR.Examples.PauliIncompatibility` over the generic module and the
  Stage 5 Pauli definitions. Prove exact X/Z matrix noncommutation and exclude
  every raw common nonzero eigenvector for arbitrary real eigenvalues.
- Derive a state-quantified Pauli no-joint-sharp theorem, including mixed
  states, through the generic bridge rather than through noncommutation.
- Add an executable diagnostic leaf with explicit `Fin 2` Pauli matrix-entry
  sentinels and a `Fin 3` noncommuting/common-eigenstate/joint-sharp
  counterexample.
- Add a diagnostic axiom/signature leaf covering the generic bridge, Pauli
  results, and counterexample.
- Expose the Pauli results through the public root while keeping both audit
  leaves outside the public import chain.
- Update the paper/dependency/correction maps to mark the finite obstruction
  complete without changing the outstanding status of Stages 7–9.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Incompatibility.lean`
- `formal/EPR/Examples/PauliIncompatibility.lean`
- `formal/EPR/Audit/Incompatibility.lean`
- `formal/EPR/Audit/IncompatibilityAxioms.lean`
- `docs/Corrections.md`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/6-INCOMPATIBILITY.md`

## No-Cheating Checks

- Inspect the Pauli no-common-eigenvector signature: it must quantify over an
  arbitrary nonzero ket and arbitrary real eigenvalues, not enumerate only the
  four named eigenstates.
- Inspect the no-joint-sharp proof dependency: it must use the generic
  common-eigenvector bridge or a direct mixed-state proof, not
  `pauliXZ_noncommutes`.
- Instantiate the final exclusion on arbitrary `DensityState (Fin 2)` data;
  do not silently restrict the result to pure states.
- Check both matrix products at a concrete entry so the noncommutation theorem
  cannot be satisfied by a definition with reversed or malformed products.
- Check the `Fin 3` counterexample's Hermiticity, explicit unequal product
  entry, normalized shared eigenstate, common-eigenvector witness, and jointly
  sharp pure density.
- Confirm the generic module contains no Pauli, qubit, `Fin 2`/`Fin 3`, fixed
  matrix, Bell state, interpretative, or continuum data.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`,
  broad coercions, hidden classical postulates beyond the standard Lean/mathlib
  footprint, and audit imports in the public root.
- Confirm no Stage 7 marginal-invariance theorem, Stage 8 interpretative
  premise/conclusion, or Stage 9 analytic construction appears or is used.

## Completion Requirements

- Generic commutation, raw common-eigenvector, and joint-sharp-state predicates
  compile as distinct APIs.
- A checked generic theorem derives a common nonzero raw eigenvector from any
  jointly sharp density state and derives no joint sharp state from no common
  eigenvector.
- Pauli `X` and `Z` are proved noncommuting and separately proved to have no
  common nonzero eigenvector.
- No pure or mixed qubit density state is jointly sharp for Pauli `X` and `Z`.
- A checked `Fin 3` example proves that two noncommuting Hermitian observables
  can nevertheless share an eigenvector and a jointly sharp density state.
- Focused generic/example builds, both Stage 6 audit builds, the public `EPR`
  consumer, and the required full build succeed with warning-as-error coverage.
- Proof-hole/project-axiom, generic-boundary, theorem-dependency,
  counterexample, import-direction, axiom, stale-text, whitespace, and diff
  checks pass and are recorded below with exact commands and interpretations.

## Stage Results

- In progress.
