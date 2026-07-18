# 7-NO-SIGNALLING

## Current Facts

- Stages 1–6 are complete. The public finite example supplies the normalized
  Bell state, complete Pauli `Z` and `X` projective measurements on A, all four
  selected conditional B states, and the separate Pauli incompatibility
  obstruction.
- Stage 7 starts from a clean worktree after the completed Stage 6 evidence was
  autosaved. `lake build EPR.Examples.PauliIncompatibility` succeeds with 3204
  jobs and full `lake build` succeeds with 3206 jobs. Proof-hole and
  declaration-level project-axiom scans have no matches.
- Lean remains pinned to version `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; mathlib remains pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- The paper facsimile was inspected directly at printed pages 779–780 and
  checked against transcription lines 86–106, 184, and 188. Page 779 treats
  absence of interaction as implying that “no real change” can occur in
  system II because of anything done to I, then assigns two selected wave
  functions to the same reality. Page 780 again says the remote prediction is
  made without disturbing II “in any way.” Neither page computes an averaged
  post-measurement density, a reduced state, or invariant outcome statistics.
- `EPR.Quantum.Conditional` already defines complete finite projective
  measurements and a positive trace-one `ProjectiveMeasurement.nonselectiveState`
  as the sum of raw Lüders branches. `EPR.Quantum.Bipartite` already defines
  tagged local projections, finite partial traces, and normalized `reducedA`
  and `reducedB` states.
- The current nonselective-state API acts on the same state space as its
  projectors. No checked construction yet applies a complete measurement on A
  to the joint `A × B` space, and no theorem yet proves that tracing out A
  after that outcome-forgotten update returns the original B marginal.
- A fresh pinned-source search found only general C*-algebra completely
  positive maps, not a project-ready quantum channel, Kraus family,
  trace-preserving channel, partial trace, or no-signalling theorem. The
  existing projective Lüders infrastructure is the checked scope for this
  stage.

## Updated Assumptions

- The primary operational statement should be equality of normalized reduced
  B density states before and after a complete local A-side nonselective
  projective Lüders update. Equality of all B-side projective Born statistics
  should be derived from that stronger finite state equality.
- The local update must sum raw branches
  `(P_w ⊗ I) ρ (P_w ⊗ I)`. It must not sum normalized selected conditionals,
  which would discard their Born weights and generally give the wrong state.
- The generic theorem is directional A→B. It should use distinct basis types
  for A and B and must not silently claim the unproved reverse direction.
- The two Bell settings should both reduce to the original B marginal, hence
  to each other, while selected positive-probability conditional states may
  still differ. This is the operational distinction the stage must make
  executable.
- The checked scope is a complete local projective Lüders measurement with
  its outcome forgotten. No theorem about arbitrary CPTP maps, general
  instruments, spacetime separation, causal locality, or communication
  protocols is claimed without adding and auditing the corresponding API.
- Operational marginal invariance does not imply that system II's underlying
  physical reality is unchanged. `NoOnticDisturbance`, same-reality, and
  locality premises remain absent from the mathematical modules and become
  explicit hypotheses only in Stage 8.

## Big Picture Objective

Prove the exact finite operational no-signalling fact needed to separate the
checked quantum model from the paper's stronger locality premise: discarding
the outcome of any complete projective Lüders measurement on subsystem A
leaves subsystem B's unconditioned reduced density and all its projective Born
statistics unchanged, even though selected Bell conditional states depend on
the A setting and outcome.

## Detailed Implementation Plan

- Add `EPR.Quantum.NoSignalling` over the generic conditional/bipartite layer.
  Define an explicitly directional operational no-signalling predicate and a
  local A-side nonselective state from a complete projective measurement.
- Prove the local partial-trace cyclicity or equivalent matrix identity needed
  to move an A-local operator around the traced factor. Use projector
  idempotence and identity resolution to prove that the sum of local raw
  branches has the same B partial trace as the input.
- State the main result as reduced-B density equality for an arbitrary finite
  bipartite density state and arbitrary complete A-side projective
  measurement. Derive invariance for an arbitrary B-side projection and a
  corollary comparing any two A measurement choices.
- Add `EPR.Examples.BellNoSignalling` using the established Bell state and
  Pauli setting measurements. Prove every setting preserves the original B
  marginal and that the `Z` and `X` outcome-forgotten marginals agree. Expose
  selected-state differences separately, reusing Stage 5 calculations rather
  than duplicating or weakening them.
- Add `EPR.Audit.NoSignalling` with matrix-level sentinels for raw-branch
  summation, B-marginal equality, arbitrary B statistics, both Bell settings,
  and differing selected states. Include a direction/tensor-order check that
  cannot pass by confusing the A and B factors.
- Add `EPR.Audit.NoSignallingAxioms` to check exact signatures and print the
  trusted axioms of every main generic, concrete, and diagnostic result.
- Expose the generic and Bell operational results through `formal/EPR.lean`,
  while keeping both audit leaves outside the public import chain and
  preserving the Stage 6 public results.
- Update `docs/PaperMap.md`, `docs/Corrections.md`, and
  `docs/Dependencies.md` to mark only the operational finite statement
  checked. Keep the paper's no-real-change, same-reality, reality,
  counterfactual, and completeness claims explicitly pending for Stage 8.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/NoSignalling.lean`
- `formal/EPR/Examples/BellNoSignalling.lean`
- `formal/EPR/Audit/NoSignalling.lean`
- `formal/EPR/Audit/NoSignallingAxioms.lean`
- `docs/Corrections.md`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/7-NO-SIGNALLING.md`

## No-Cheating Checks

- Inspect the local nonselective matrix definition: it must be the sum of raw
  Lüders branches with their Born weights implicit in their traces, never an
  unweighted sum of normalized conditional density states.
- Inspect the main theorem signature and body: it must compare `reducedB` of
  the outcome-forgotten joint state with `reducedB` of the input, not compare a
  selected branch, use a zero-probability loophole, or merely restate an
  assumed equality.
- Quantify over arbitrary finite A and B basis types, an arbitrary bipartite
  density state, and an arbitrary complete projective measurement on A. Do not
  prove only the symmetric Bell instance.
- Derive the B-statistics theorem for an arbitrary B-side projection from the
  marginal theorem or its checked matrix content. Do not test only one Pauli
  outcome.
- Compare two arbitrary A measurement choices generically, then check both
  concrete Pauli settings. Ensure the Bell specialization does not silently
  postselect an A outcome.
- Exhibit two selected positive-probability Bell conditional B states that
  differ while the unconditioned marginal is invariant. This demonstrates why
  steering and no-signalling are consistent rather than identifying them.
- Use distinct subsystem types or a rectangular executable sentinel so that an
  accidental `reducedA`/`traceOutB` proof cannot masquerade as the A→B result.
- Confirm the generic module imports no example, Pauli, Bell, interpretative,
  or continuum layer; confirm neither audit is reachable from `formal/EPR.lean`.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`,
  broad coercions, hidden classical postulates beyond the standard
  Lean/mathlib footprint, ontic terminology in theorem names/types, and claims
  about arbitrary channels or bidirectional signalling.
- Confirm no Stage 8 locality, no-real-change, same-reality, reality,
  counterfactual, completeness, or incompleteness theorem and no Stage 9
  analytic construction is introduced or used.

## Completion Requirements

- A distinct directional `OperationalNoSignallingAtoB` API and a checked
  complete local A-side nonselective Lüders state compile in the generic
  quantum layer.
- For every arbitrary finite bipartite density and complete A-side projective
  measurement, the post-measurement unconditioned B reduced density equals the
  original B reduced density.
- Every arbitrary B-side projective Born statistic is invariant, and any two
  complete A measurement choices give the same B marginal.
- The Bell `Z` and `X` nonselective settings instantiate the generic theorem,
  while checked selected Bell conditional states differ.
- Executable audits cover raw versus selected states, tensor direction,
  arbitrary-statistic consumption, and both settings. A separate signature
  and axiom audit covers every main declaration.
- The public root exports the generic and concrete operational results plus all
  prior public stages, but neither diagnostic audit.
- Documentation clearly distinguishes the checked modern operational theorem
  from EPR's unproved ontic premise and leaves Stages 8–9 outstanding.
- Focused generic/example builds, both Stage 7 audit builds, public-root and
  required full builds succeed with warning-as-error coverage. Proof-hole,
  project-axiom, generic-boundary, selected-vs-nonselective, tensor-direction,
  import, axiom, stale-text, whitespace, and diff checks pass with exact
  evidence recorded below.

## Stage Results

- In progress.
