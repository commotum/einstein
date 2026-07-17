# 4-CONDITIONALS

## Current Facts

- Stages 1–3 are complete, and the worktree was clean at Stage 4 start.
- Lean is pinned to `v4.31.0` at commit
  `68218e876d2a38b1985b8590fff244a83c321783`; mathlib is pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Baseline `lake build EPR.Quantum.Bipartite` and full `lake build` succeed
  with 2664 and 2666 jobs respectively. Baseline proof-hole and
  declaration-level project-axiom scans have no matches.
- The four-page image-only PDF facsimile was inspected directly at page 779,
  and it agrees with the local transcription. Eqs. (7)–(8) say that selecting
  an outcome on system I reduces the joint expansion to one term and assigns
  the corresponding coefficient wave function to system II. The subsequent
  claims about “no real change” and “the same reality” are interpretative and
  are not part of this stage.
- `EPR.Quantum.Core` supplies positive trace-one density states, orthogonal
  projections that may be degenerate, nonzero spectral outcomes, and the real
  Born-probability expression. It currently proves the probability-one support
  case but not general probability bounds.
- `EPR.Quantum.Bipartite` supplies explicitly tagged local projections,
  checked lifts, partial traces, and normalized unconditioned reduced states.
  It deliberately contains no selective measurement semantics.
- A fresh pinned-source search found no ready quantum measurement, instrument,
  Lüders-update, selective-state, or conditional-state abstraction. The pinned
  API does provide positivity of `B * ρ * Bᴴ`, positive trace, trace cyclicity,
  finite positive sums, and the algebra needed for a narrow project-owned
  construction.

## Updated Assumptions

- The finite projective selective branch should use the Lüders matrix `PρP`.
  Its positivity, trace/probability identity, and upper bound must be theorems,
  not caller-supplied fields.
- A project-owned `SubnormalizedState` should enforce positivity and trace at
  most one while permitting the zero matrix. Normalization should require a
  proof that its real trace weight is strictly positive.
- A conditional state should be constructed only from a positive-probability
  branch. A zero-probability outcome may remain a valid nonzero measurement
  projector but cannot produce a normalized conditional state.
- Selective conditioning, a full measurement's nonselective state, and the
  pre-measurement reduced state need distinct definitions and signatures.
- A full finite projective measurement should carry nonzero projections,
  pairwise orthogonality, and resolution of the identity. Outcome labels are
  mathematical branch labels; selecting one does not assert that an actual
  physical event occurred.
- Degenerate projectors must remain supported. The Lüders branch preserves
  coherence within the selected subspace and must not silently choose a
  rank-one vector.
- Vector-level projected-ket formulas may be used to connect pure inputs to
  density branches, but normalized conditional density states should be
  invariant under global phase.
- No separation, disturbance, reality, completeness, counterfactual, Bell,
  steering, or no-signalling claim belongs in the generic conditional module.

## Big Picture Objective

Build a reusable finite-dimensional projective-conditioning layer with checked
subnormalized branches, explicit positive-probability normalization, full
nonselective measurement states, and bipartite conditional marginals, while
keeping every API distinct from unconditioned reduction and interpretation.

## Detailed Implementation Plan

- Add `EPR.Quantum.Conditional` over `EPR.Quantum.Bipartite`.
- Define positive trace-at-most-one subnormalized states and prove their real
  trace weight, zero-weight, and positive-weight normalization laws.
- Define `selectiveBranchMatrix ρ P = PρP`, package it as a subnormalized
  state, and prove positivity, trace/Born-probability equality, general
  probability bounds, and the zero-branch equivalence.
- Define normalized `conditionalState` with an explicit strict-positivity proof
  and expose its matrix and trace formulas.
- Define full finite projective measurements, outcome probabilities, their
  normalization, and a normalized `nonselectiveState` obtained by summing all
  Lüders branches.
- Define projected pure kets, prove the pure-density selective-branch formula,
  and prove global-phase invariance of pure density inputs and their
  conditional density states.
- Add `conditionalBState` for an A-side selected projection and the symmetric
  `conditionalAState`, constructed by reducing the normalized selected joint
  state rather than confusing conditioning with the original marginal.
- Add an executable audit with a proper degenerate projector, positive and
  zero-probability branches, a two-outcome projective measurement,
  nonselective dephasing, and a phase-invariance check. Use no Stage 5 Bell or
  Pauli definitions.
- Add a separate axiom/signature audit for the principal bounds,
  normalization, nonselective, pure-density, phase, and bipartite conditional
  declarations.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Conditional.lean`
- `formal/EPR/Audit/Conditional.lean`
- `formal/EPR/Audit/ConditionalAxioms.lean`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/4-CONDITIONALS.md`

## No-Cheating Checks

- Inspect `conditionalState` to confirm that normalization consumes explicit
  strict positive-probability evidence and cannot be called on the checked
  zero-probability branch.
- Confirm subnormalized branch positivity and the probability upper bound are
  derived rather than inserted as assumptions on `selectiveBranch`.
- Confirm the nonselective state sums every branch and uses the measurement's
  identity resolution; it must not select one branch or reuse a conditional
  state.
- Inspect signatures and definitions to confirm `conditionalBState`,
  `nonselectiveState`, and `reducedB` are separate operations.
- Confirm the degenerate audit preserves two-dimensional range coherence and
  does not rely on a hidden rank-one hypothesis.
- Confirm phase invariance is proved at the density/conditional-state level,
  not asserted as literal equality of phase-different kets.
- Confirm generic definitions mention no qubit, Bell, Pauli, reference state,
  reality, locality, disturbance, completeness, no-signalling, plane wave,
  delta, or `L²` construction.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`,
  broad coercions, and audit imports in the public root.

## Completion Requirements

- Generic selective branches are checked subnormalized states whose weights
  equal Born probabilities in `[0, 1]`.
- Zero probability is equivalent to a zero selective branch, and normalized
  conditioning requires strict positive-probability evidence.
- `conditionalState` is positive and trace one by construction, with a proved
  normalized-matrix formula.
- A full projective measurement has normalized outcome probabilities and a
  checked positive trace-one nonselective state.
- Pure projected-ket and density-branch descriptions agree, and conditional
  density states are invariant under global phase.
- Degenerate-projector and zero-probability edge cases compile and prove the
  intended behavior without basis-specific code in the generic module.
- A-side and B-side bipartite conditional marginals compile with signatures
  distinct from unconditioned reduced states.
- `lake build EPR.Quantum.Conditional`, both Stage 4 audit modules, and the
  public `EPR` consumer succeed, followed by required full `lake build`.
- Proof-hole/project-axiom, zero-conditioning, generic-reference/shortcut,
  dependency, axiom, whitespace, and diff checks pass and are recorded below.

## Stage Results

- In progress.
