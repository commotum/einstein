# 3-BIPARTITE

## Current Facts

- Stages 1 and 2 are complete and the worktree was clean at Stage 3 start.
- Lean is pinned to `v4.31.0` and mathlib to commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Baseline `lake build EPR.Quantum.Core` and full `lake build` succeed with
  2663 and 2665 jobs respectively.
- The four-page image-only PDF facsimile and its local transcription agree at
  the Stage 3 source locus: Eqs. (7)–(8) use an ordered combined system and
  alternative subsystem-I bases, while selective reduction belongs to the
  next stage. The paragraph identifying absence of interaction with no real
  change is interpretative and does not belong in this mathematical module.
- `EPR.Quantum.Core` supplies normalized pure states, positive trace-one
  density states, Hermitian observables, projections, Born probability, and
  sharpness, all over generic finite basis-index types.
- `BipartiteIndex ι κ` is the ordered product `ι × κ`, but no bipartite
  state API, local operator placement, tensor-state constructor, partial trace,
  or reduced state currently exists.
- A fresh pinned-source search found no partial-trace, reduced-state, or
  density-matrix abstraction in mathlib.
- The pinned API does supply `Matrix.kronecker`, `Matrix.mul_kronecker_mul`,
  `Matrix.conjTranspose_kronecker`, `Matrix.trace_kronecker`,
  `Matrix.PosSemidef.kronecker`, principal-submatrix positivity, finite sum
  laws, and `Matrix.posSemidef_sum`. The Kronecker positivity theorem lives in
  `Mathlib.Analysis.Matrix.Order`, outside the narrower matrix directory first
  searched.
- Baseline scans find no `sorry`, `admit`, project `axiom`, `opaque`, or
  `unsafe` declaration in completed Lean sources.

## Updated Assumptions

- Bipartite pure and density states can reuse the Stage 2 invariant-carrying
  structures at the ordered product index; a second copy of normalization and
  positivity fields would add no safety.
- Raw tensor kets and Kronecker products should be hidden behind proved
  state-level constructors.
- Partial trace should be named by the subsystem removed (`traceOutA` and
  `traceOutB`) to avoid the common ambiguity in `partialTraceA/B` conventions.
- Writing partial trace as a sum of principal submatrices permits a direct
  positivity proof using `PosSemidef.submatrix` and `posSemidef_sum`; it must
  not be postulated or inferred from trace preservation alone.
- Distinct `LocalOperatorA`, `LocalOperatorB`, `LocalObservableA`, and
  `LocalObservableB` wrapper types are warranted. Separate function names
  alone would not prevent accidental interchange when `ι = κ`, as in the target
  two-qubit example.
- Local operators in this stage are algebraic operators, not general quantum
  channels and not evidence of operational or ontic locality. Trace-preserving
  operations and no-signalling remain later obligations.
- The Stage 3 entangled sanity check should prove non-productness rather than
  merely attach the word "entangled" to a normalized vector. It belongs in an
  audit leaf, not in generic definitions or the later Bell example module.

## Big Picture Objective

Build a reusable finite-dimensional bipartite layer whose ordered subsystem
typing, tensor-state constructors, local operator placement, partial traces,
and reduced density states are mathematically checked and contain no
interpretative or measurement-conditioning premise.

## Detailed Implementation Plan

- Add `EPR.Quantum.Bipartite` over `EPR.Quantum.Core`.
- Define aliases for bipartite pure and density states at `ι × κ` and a raw
  `tensorKet` with explicit A-then-B order.
- Construct normalized pure product states and positive trace-one density
  product states; prove their matrix relationship.
- Use the pinned `Matrix.PosSemidef.kronecker` theorem for positive
  Kronecker products rather than duplicating that proof.
- Define `traceOutA` and `traceOutB` as explicit finite diagonal-index sums.
- Prove their entry, sum, positivity, trace-preservation, Kronecker-product,
  and reduced-product-state identities.
- Define `reducedA` and `reducedB` as invariant-carrying density states.
- Define separately tagged A-side and B-side local operators and observables,
  with no coercion between them, and prove lift multiplication, cross-action,
  commutation, and product-ket action laws.
- Add an audit module with a product-state example and a normalized two-qubit
  state proved not to be a tensor product by a checked cross-amplitude
  invariant.
- Add a separate `#print axioms` audit for the main tensor, positivity, partial
  trace, reduced-state, and local-action results.
- Keep selective branches, conditional normalization, Bell steering,
  incompatibility, no-signalling, and interpretation out of this stage.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Bipartite.lean`
- `formal/EPR/Audit/Bipartite.lean`
- `formal/EPR/Audit/BipartiteAxioms.lean`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/3-BIPARTITE.md`

## No-Cheating Checks

- Inspect signatures to confirm A-side and B-side wrappers are distinct types
  and no broad coercion erases the tag.
- Confirm generic definitions mention no qubit, Bell, reference-state, reality,
  locality, disturbance, completeness, or no-signalling constant.
- Confirm `traceOutA`/`traceOutB` positivity is proved, not included as a field
  or supplied by an axiom.
- Confirm trace preservation and positivity are both used to construct reduced
  density states; neither is substituted for the other.
- Confirm the entangled audit proves failure of every raw pure tensor
  factorization, not merely inequality with one selected product state.
- Confirm local-operator commutation is documented only as an algebraic
  tensor-factor fact and is not named or used as ontic no-disturbance.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`, and
  forbidden philosophical/continuum shortcuts.

## Completion Requirements

- Ordered bipartite pure/density states and normalized tensor constructors
  compile over generic finite basis types.
- A-side and B-side local operators/observables cannot be interchanged by an
  implicit coercion; lifted matrices act on the intended tensor factor.
- Both partial traces preserve positivity and trace, so `reducedA` and
  `reducedB` are checked density states.
- Kronecker reduction identities imply that both marginals of a product
  density state equal the corresponding input density state.
- Generic same-side multiplication, cross-side action, and cross-side
  commutation identities are proved.
- The audit checks a product state and a normalized state proved non-product.
- `lake build EPR.Quantum.Bipartite`, both Stage 3 audit modules, and the public
  `EPR` consumer succeed, followed by required full `lake build`.
- Proof-hole/project-axiom scans, subsystem/shortcut scans, public dependency
  inspection, axiom audits, whitespace checks, and `git diff --check` pass and
  are recorded below.

## Stage Results

- In progress.
