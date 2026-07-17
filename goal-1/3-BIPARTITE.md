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
- At Stage 3 start, `BipartiteIndex ι κ` was the ordered product `ι × κ`, but
  no bipartite state API, local operator placement, tensor-state constructor,
  partial trace, or reduced state existed.
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

- **Result:** Complete on 2026-07-17. Stage 4 was not started.
- The four-page image-only PDF facsimile was inspected directly alongside the
  local transcription. Eqs. (7)–(8) support the ordered bipartite and
  alternative-basis infrastructure developed here; selective reduction and
  the paper's later ontic locality premise remain outside this stage.
- `EPR.Quantum.Bipartite` now provides generic ordered bipartite pure and
  density states, normalized pure-state tensor products, positive trace-one
  density-state tensor products, and compatibility between tensoring and
  pure-to-density conversion.
- `traceOutA` and `traceOutB` are explicit finite sums of principal submatrices
  and are named for the factor removed. Their complex-linear-map wrappers,
  positivity, trace preservation, Kronecker-product formulas, and normalized
  `reducedA`/`reducedB` constructions are proved independently. Product-state
  marginals reduce to the supplied factors.
- Separately tagged `LocalOperatorA/B`, `LocalProjectionA/B`, and
  `LocalObservableA/B` types have explicit lifts and no coercion between
  subsystem tags. Same-side multiplication, the cross product, cross-side
  commutation, and action on product kets are checked algebraic facts only;
  the public module explicitly disclaims operational no-signalling and ontic
  locality/no-disturbance conclusions.
- `EPR.Audit.Bipartite` uses the heterogeneous index `Fin 2 × Fin 3`. It
  checks a product state's two marginals, an off-diagonal matrix unit, the
  dimension factor in the partial trace of identity, distinct local actions,
  and cross-side commutation. These tests catch subsystem swaps, transposition,
  and illicit normalization of partial trace.
- The audit also constructs a normalized rational-amplitude two-qubit pure
  state, proves that no pair of raw kets tensors to it, and computes both
  reduced density matrices. This is a genuine non-product sanity check in an
  audit leaf, not a hidden Bell/reference state in the generic API.
- Early focused builds exposed four useful pinned-API corrections: finite
  matrix sums require `Matrix.sum_apply`; indexed sum reordering uses
  `Finset.sum_comm`, not a nonexistent `Fintype.sum_comm`; tagged local-action
  proofs benefit from explicit type changes and a generic factorwise action
  theorem; and the audit's basis-state proof uses `single_one_dotProduct`.
  Subsequent audit corrections made rational complex data noncomputable and
  handled numeral star simplification and `vecMulVec` unfolding explicitly.
  No mathematical claim was weakened to resolve these diagnostics.
- Focused command
  `cd formal && lake build EPR.Audit.Bipartite EPR.Audit.BipartiteAxioms EPR`
  succeeded with 3203 jobs. The public bipartite target also succeeded
  separately with 2664 jobs.
- Required full command `cd formal && lake build` succeeded with 2666 jobs.
- `EPR.Audit.BipartiteAxioms` checks the A/B wrapper and partial-trace linear
  map signatures and prints the trusted footprint of tensor construction,
  partial-trace positivity/trace, reduced states, local multiplication/action,
  projection and observable lifts, and the non-product proof. Every printed
  declaration reports exactly `propext`, `Classical.choice`, and `Quot.sound`;
  no project-owned axiom is present.
- Separate scans for `sorry`/`admit` and declaration-level `axiom`, `opaque`,
  or `unsafe` returned exit status 1 with no matches. The generic-module scan
  found no qubit, `Fin 2`, Bell, audit-state, or reference-state dependency and
  no coercion declaration. The philosophical/continuum shortcut scan found no
  declaration or shortcut; a broader text scan found only the public module's
  explicit negative disclaimer about no-signalling and ontic locality.
- Public-import inspection confirms the narrow chain
  `EPR -> EPR.Quantum.Bipartite -> EPR.Quantum.Core`; the executable and axiom
  audits remain outside the public root. Successful builds rule out a cycle.
- `lake env lean --version` reconfirmed Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`. The manifest reconfirmed mathlib
  revision `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- The relevant-file trailing-whitespace scan returned exit status 1 with no
  matches, and `git diff --check` succeeded.

## What Was Learned

- A principal-block sum gives a small, reusable finite partial trace whose
  positivity follows directly from official submatrix and finite-sum theorems.
- Heterogeneous subsystem dimensions and off-diagonal matrix units are more
  diagnostic for tensor-order errors than symmetric two-qubit examples alone.
- Type tags are necessary even when function names indicate the side: when
  `ι = κ`, untagged matrices would otherwise be interchangeable.
- Algebraic tensor-factor commutation, operational no-signalling, and ontic
  no-disturbance are three distinct claims and belong in different stages.
- A pure-state entanglement sanity check must exclude every tensor
  factorization; inequality with one product state would not suffice.

## Plan Update

- `0-plan.md` records the completed bipartite API, audits, and expected
  foundational axiom footprint.
- `4-CONDITIONALS` is now the first incomplete stage. It must introduce
  selective branch probabilities and normalization evidence without
  conflating conditional states with the unconditioned marginals proved here;
  no Stage 4 implementation is included in this stage.
