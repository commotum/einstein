# 8-EPR-LOGIC

## Current Facts

- Stage 8 is the first incomplete stage in `goal-1/0-plan.md`; Stages 1--7 are
  complete and their evidence records are preserved.
- The Stage 8 start worktree is clean at autosave commit `442b844`.
- From `formal/`, the adjacent baseline
  `lake build EPR.Examples.PauliIncompatibility` succeeds with 3204 jobs and
  the required baseline `lake build` succeeds with 3208 jobs.
- Proof-hole and declaration-level project-axiom scans over `EPR/` and
  `EPR.lean` return no matches.
- Lean remains pinned to `v4.31.0`; Lake and the manifest pin mathlib to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Direct inspection of the four-page facsimile confirms the following source
  boundary:
  - printed page 777 states theory completeness as a counterpart for every
    element of physical reality and certainty without disturbance as only a
    sufficient criterion for such an element;
  - printed page 778 separately reasons from simultaneous definite values and
    completeness to values contained in, and predictable from, the wave
    function;
  - printed page 779 claims that absence of interaction means no real change
    in II and therefore alternative conditional wave functions concern the
    same reality;
  - printed page 780 applies the reality criterion in each alternative remote
    context, aggregates those assignments as simultaneous reality, and derives
    incompleteness. Its following objection explicitly identifies denial of
    that aggregation as an alternate reading.
- The transcription anchors are lines 16, 20--26, 78--82, 86, 106, and
  184--190 of `einstein-1935/einstein-1935.md`.
- The current Lean tree has checked mathematical predicates for positive
  selected-branch prediction, density-state sharpness, joint sharpness, and
  absence of any Pauli-X/Pauli-Z jointly sharp density state. It has no
  physical-reality or completeness predicate.
- A pinned project/mathlib search finds no existing declarations named for the
  Stage 8 vocabulary. The interpretative interface will therefore be
  project-owned and lightweight.

## Updated Assumptions

- A physical situation must distinguish a remote measurement context, a
  pre-choice B reality, and a post-choice B reality. Equality of the latter
  two represents ontic no-disturbance but is never asserted unconditionally.
- Certainty, an actual source outcome, a target value, an element of reality,
  and a quantum sharp value remain distinct data or predicates.
- A quantity's `ElementOfReality` status and its possession of a particular
  value must also remain separate. The source moves between those ideas in
  prose; Stage 8 will expose a named value bridge rather than identify them by
  definition.
- Alternative contexts may share a prior reality, but their inferred elements
  are combined only through a named counterfactual-stability/aggregation
  premise.
- `CompleteFor` is relative to a theory description and one physical reality;
  it requires a theory counterpart for every modeled element of that reality.
- A separate completeness-to-representation bridge is needed before theory
  counterparts and simultaneous reality yield one jointly representing theory
  state. The word “counterpart” alone does not supply this theorem.
- The Bell adapter may quantify over an otherwise uninterpreted ontic reality
  type and user-supplied element/counterpart predicates. Its mathematical
  certainty and incompatibility facts must come from the already checked Bell
  and Pauli modules.
- Stage 7 operational no-signalling is true for the model but does not prove
  Stage 8 ontic no-disturbance. The logic proof path must make that separation
  visible in imports, hypotheses, and source scans.

## Big Picture Objective

- Reconstruct the EPR inference as a reusable conditional theorem whose
  signature displays every interpretative dependency, then connect that
  theorem to the checked finite Bell steering and Pauli incompatibility facts.
  No premise about nature becomes a Lean axiom or unconditional theorem.

## Detailed Implementation Plan

- Add `formal/EPR/Logic/EPR.lean` with:
  - context-indexed `PhysicalSituation` data and explicit pre/post realities;
  - named outcome-occurrence, certainty, element-of-reality, possessed-value,
    simultaneous-reality, theory-counterpart, joint-representation, and
    relative-completeness predicates;
  - `NoOnticDisturbance`, same-prior-reality, `RealityCriterion`,
    a reality-to-value bridge, `CounterfactualStability`, and a
    completeness-to-representation bridge;
  - small inference lemmas and a top-level conditional `epr_incompleteness`
    theorem.
- Add `formal/EPR/Examples/BellEPR.lean` with a Bell context and adapter whose
  certainty facts are built from `bellPhiPlus_perfectPrediction` and whose
  joint-representation obstruction is built from
  `pauliXZ_not_jointlySharp`/`pauliXZ_noJointSharpState`.
- Keep `BellEPR` independent of `EPR.Quantum.NoSignalling` and
  `EPR.Examples.BellNoSignalling`; preserve operational no-signalling as a
  separate public-root branch.
- Add `formal/EPR/Audit/EPRLogic.lean` with positive and negative diagnostics:
  instantiate the theorem, show each philosophical premise can be declined,
  and ensure operational no-signalling cannot fill an ontic hypothesis by
  definitional or coercion shortcuts.
- Add `formal/EPR/Audit/EPRLogicAxioms.lean` to check public signatures and
  print axioms for every Stage 8 result.
- Update `formal/EPR.lean`, `docs/PaperMap.md`, `docs/Corrections.md`, and
  `docs/Dependencies.md` only after the checked API is stable.

## No-Cheating Checks

- Scan completed Lean modules for `sorry`, `admit`, `sorryAx`, project
  `axiom`, `opaque`, `unsafe`, `partial def`, and `implemented_by`.
- Inspect the full `epr_incompleteness` and Bell theorem signatures: certainty,
  two actual-outcome facts, two ontic no-disturbance facts, the sufficient
  reality criterion, the possessed-value bridge, same-reality/context bridge,
  counterfactual aggregation, completeness representation bridge, and the
  mathematical joint-representation exclusion must be explicit or visibly
  constructed from checked inputs.
- Confirm the abstract logic module imports no quantum/example module and the
  Bell logic module imports no no-signalling module.
- Scan the Bell theorem proof path for
  `OperationalNoSignallingAtoB`, `localA_nonselective_noSignalling`, and
  `bellPhiPlus_operationalNoSignalling`; all must be absent.
- Confirm the Bell prediction adapter names
  `bellPhiPlus_perfectPrediction`, and its incompatibility adapter names the
  checked Pauli no-joint-sharp theorem rather than bare noncommutation.
- Add rejection witnesses showing that reality criterion, ontic
  no-disturbance, counterfactual stability, and completeness representation
  are individually consistent to deny; no structure definition may force any
  of them.
- Keep all diagnostics outside the public `EPR` import chain.
- Run trailing-whitespace, stale-name/status, public-audit-import,
  `git diff --check`, and autosave-history diff checks.

## Completion Requirements

- All named Stage 8 vocabulary exists with documented semantics and suitable
  context/reality indexing.
- The abstract theorem proves only a conditional negation of `CompleteFor` and
  exposes every interpretative premise.
- The Bell theorem consumes all four-branch checked steering infrastructure
  through the generic prediction witness and consumes the Pauli
  no-joint-sharp-state result; it does not duplicate matrix calculations.
- The same-reality and simultaneous-reality steps are separate and the latter
  requires the named counterfactual premise.
- Operational no-signalling remains separately true and separately imported,
  but cannot discharge `NoOnticDisturbance`.
- Focused abstract/example/audit/axiom builds, the public-root build, a combined
  warning-as-error build, and required full `lake build` all succeed.
- Signature, theorem-body, import, no-cheating, proof-hole, project-axiom,
  whitespace, documentation-name, pin, and Git checks pass.
- `#print axioms` reports no project-specific axioms for substantive Stage 8
  declarations; exact output is recorded below.

## Stage Results

- In progress. No Stage 8 Lean declaration has yet been added.
