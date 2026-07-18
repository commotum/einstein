# 5-STEERING

## Current Facts

- Stages 1–4 are complete, and the worktree was clean at Stage 5 start.
- Lean is pinned to `v4.31.0` at commit
  `68218e876d2a38b1985b8590fff244a83c321783`; mathlib is pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Baseline `lake build EPR.Quantum.Conditional` and full `lake build` succeed
  with 2665 and 2667 jobs. Baseline proof-hole and declaration-level
  project-axiom scans have no matches.
- The four-page image-only paper facsimile was inspected directly at pages
  779–780 and compared with the local transcription. Page 779 gives alternative
  expansions (7) and (8) and selected coefficient wave functions; page 780
  states that the corresponding remote quantities can be predicted with
  certainty. The claims that no real change occurs and both wave functions
  concern the same reality are separate interpretative steps, not mathematical
  steering facts.
- `EPR.Quantum.Conditional` already supplies positive-probability local
  branches, normalized remote conditional states, raw relative branches, and
  probability-one support lemmas. It deliberately does not define any Bell
  state, Pauli setting, actual outcome, no-signalling theorem, or ontic claim.
- `QubitIndex = Fin 2` and ordered bipartite indices use `A × B`. A fresh
  pinned-source search found no project-ready Pauli, Bell-state, or steering
  abstraction, so the concrete data belongs in an example module.

## Updated Assumptions

- Use the standard Bell state
  `|Φ⁺⟩ = (|00⟩ + |11⟩)/√2`. Its normalization must be proved from
  an explicit real square-root identity; it may not be inserted as a field
  without calculation.
- Outcome index `0` will mean eigenvalue `+1`, and outcome index `1` will mean
  eigenvalue `-1`. For `Z`, these are `|0⟩` and `|1⟩`; for `X`, they are
  `|+⟩ = (|0⟩ + |1⟩)/√2` and `|-⟩ = (|0⟩ - |1⟩)/√2`.
- With `|Φ⁺⟩`, both settings have same-label correlations: every A-side
  outcome has probability `1/2`, has the associated conditional B eigenstate
  density, and gives probability one for the matching B projector.
- “Perfect prediction” in this stage is an operational conditional-state fact:
  a positive-probability A branch makes the matching B outcome have Born
  probability one, equivalently the conditional B density has the matching
  sharp Pauli value. It does not assert that an outcome occurred or that a
  value existed before measurement.
- Alternative settings and all four outcomes must be quantified or named so no
  favorable branch is silently omitted. Basis order, tensor order, outcome
  values, and correlation signs need executable checks.
- Defining Pauli observables here does not authorize Stage 6's noncommutation or
  no-common-sharp-state result. Selected-state changes do not authorize Stage
  7 no-signalling, and no reality/locality/completeness vocabulary belongs in
  this module.

## Big Picture Objective

Build a reusable, fully checked two-qubit `|Φ⁺⟩` steering certificate for
the alternative Pauli `Z` and `X` measurements, covering every outcome and
making the probability, conditional-state, eigenvalue, basis-order, and sign
conventions explicit.

## Detailed Implementation Plan

- Add the generic `EPR.Quantum.Steering` package over
  `EPR.Quantum.Conditional`, instantiate it in `EPR.Examples.BellSteering`,
  and expose the example through the public root.
- Define normalized computational and `X`-basis pure states, Pauli `Z` and
  Pauli `X` observables, their rank-one spectral projections/outcomes, and
  complete binary projective measurements.
- Define `bellPhiPlus` with explicit `A × B` ket entries and prove
  normalization. Prove computational- and `X`-basis expansion identities or
  equally strong componentwise convention checks.
- Tag each selected A projection and provide matching B spectral data without
  coercing or swapping subsystem roles.
- Prove for both settings and both outcomes that the A-side probability is
  `1/2` and hence strictly positive.
- Prove that each raw relative-B branch has trace weight `1/2` and matrix
  `(1/2) • targetDensity`, retaining the selected coefficient's norm before
  normalization.
- Prove for all four branches that B's normalized conditional density is the
  matching eigenstate density. Derive matching B-projector probability one and
  matching Pauli sharp value.
- Package the quantified results into a reusable steering certificate and add
  named/exhaustive checks demonstrating all four setting/outcome pairs.
- Add a diagnostic axiom/signature leaf covering the state, measurements,
  branch probabilities, conditional states, predictions, sharp values, and
  packaged certificate.
- Update dependency and paper maps to distinguish the verified finite analogue
  from EPR's distributional Eqs. (9)–(18) and later interpretative steps.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Steering.lean`
- `formal/EPR/Examples/BellSteering.lean`
- `formal/EPR/Audit/BellSteering.lean`
- `formal/EPR/Audit/BellSteeringAxioms.lean`
- `docs/Corrections.md`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/5-STEERING.md`

## No-Cheating Checks

- Inspect `bellPhiPlus.normalized`; verify the `1/√2` identity is proved and
  no normalization assumption is introduced.
- Exhaust the Cartesian product of two settings and two outcomes. Check that
  branch coverage does not merely prove a single favorable case.
- Inspect all conditional-state calls for explicit proofs of the already
  computed probability `1/2`; no branch may divide by an unproved or zero
  probability.
- Confirm `Z` outcome `0/1` maps to value `+1/-1` and matching B basis state,
  and `X` outcome `0/1` maps to `|+⟩/|-⟩` and value `+1/-1`.
- Confirm tensor entries use `A × B` and the `|Φ⁺⟩` state has support only
  on `(0,0)` and `(1,1)` with the same phase.
- Derive probability-one prediction from the verified conditional state or
  projector support. Do not make it a constructor field supplied by the
  caller.
- Inspect `PerfectConditionalPrediction.source_positive` and every packaged
  branch, confirming certainty cannot be satisfied vacuously at probability
  zero.
- Because `|Φ⁺⟩` is swap-symmetric, include a lifted-projector coordinate
  check that distinguishes an A-side action on `(0,1)` from `(1,0)`.
- Keep noncommutation, joint-sharpness exclusion, nonselective marginal
  invariance, locality, disturbance, reality, completeness, and
  counterfactual aggregation out of the example's theorem dependencies.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`,
  broad coercions, unverified alternate branches, and audit imports in the
  public root.

## Completion Requirements

- The normalized `|Φ⁺⟩` state, both Pauli observables, their four spectral
  outcomes, and both complete projective measurements compile with explicit
  conventions.
- Both alternative basis expansions or equivalent exact component identities
  are proved.
- Each of the four A-side branches has proved probability `1/2`, normalized
  matching conditional B state, matching B outcome probability one, and
  matching Pauli sharp value.
- A reusable certificate quantifies over both settings and both outcomes; an
  executable audit makes the four-case coverage and signs visible.
- No Stage 6 incompatibility theorem, Stage 7 no-signalling theorem, or Stage 8
  interpretative premise/conclusion appears in the Stage 5 public module, and
  no Stage 9 distributional claim is attributed to the finite example.
- `lake build EPR.Examples.BellSteering`, both Stage 5 audit modules, the public
  `EPR` consumer, and required full `lake build` succeed.
- Proof-hole/project-axiom, branch-coverage, convention/sign, dependency,
  axiom, generic-boundary, whitespace, and diff checks pass and are recorded
  below with exact commands and interpreted results.

## Stage Results

- In progress.
