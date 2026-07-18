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
- The final Bell theorem must take the Z-context and X-context prior realities
  separately and require their equality through `SamePriorReality`; a shared
  constructor argument is useful as a convenience theorem but must not hide
  the same-reality premise in the main signature.
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
- Confirm the Bell prediction adapter projects
  `bellPhiPlusSteeringScenario.predicts` through
  `bellPhiPlus_perfectPrediction_fromScenario`, and its incompatibility
  adapter names the checked Pauli no-joint-sharp theorem rather than bare
  noncommutation.
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

**Status:** Complete on 2026-07-17.

### Implemented theory-neutral logic

- `EPR.Logic.EPR` is universe-polymorphic and imports only
  `Mathlib.Logic.Basic`. `PhysicalSituation` explicitly records a context and
  prior/post realities. `AlternativeContexts`, `SamePriorReality`,
  `SamePostReality`, and `NoOnticDisturbance` keep context difference,
  same-reality transport, and ontic stability separate.
- `EPRInterpretation` is vocabulary, not a bundle of asserted philosophical
  premises. Its seven independent relations are exposed as
  `OutcomeObtained`, `CertainPrediction`, `ElementOfReality`,
  `PossessesValue`, `SimultaneouslyReal`, `TheoryCounterpart`, and
  `JointlyRepresents`. Certainty therefore neither asserts an actual source
  outcome nor definitionally supplies a reality element or possessed value.
- `RealityCriterion` is a sufficient-only implication from actuality,
  certainty, and ontic no-disturbance to a context-indexed reality element.
  `RealityValueBridge` separately connects that element to possession of the
  exact predicted value. `CounterfactualStability` separately aggregates two
  alternative-context assignments only after same-post-reality transport.
- `CompleteFor` is relative to an interpretation, supplied theory
  description, and modeled reality. It supplies only a quantity counterpart.
  `CompletenessRepresentationBridge` is the separate premise turning two
  counterparts plus simultaneous reality into exact joint representation.
- `samePostReality_of_noOnticDisturbance`,
  `reality_of_perfect_prediction`,
  `possessed_value_of_perfect_prediction`,
  `simultaneous_reality_of_alternative_predictions`,
  `theoryCounterpart_of_complete`, and
  `joint_representation_of_complete` expose the individual inference steps.
  `not_complete_of_no_joint_representation` isolates the final reductio.
- The top-level `epr_incompleteness` theorem consumes alternative contexts,
  same prior reality, two actual outcomes, two certainty facts, two ontic
  no-disturbance facts, the reality criterion, value bridge, counterfactual
  stability, completeness representation bridge, and a separate exact
  no-joint-representation premise. It concludes only
  `¬ CompleteFor I theory s.postReality` for the supplied interpretation,
  description, and reality.

### Implemented Bell/Pauli instantiation

- `EPR.Examples.BellEPR` imports only `EPR.Logic.EPR` and
  `EPR.Examples.PauliIncompatibility`; it has no no-signalling import.
  `BellContext` records a possible source setting and outcome without
  asserting actuality.
- `BellPerfectPrediction` is exactly the checked
  `PerfectConditionalPrediction` projected from
  `bellPhiPlusSteeringScenario.predicts` by
  `bellPhiPlus_perfectPrediction_fromScenario`.
  `bellCertainPrediction` exposes the corresponding target setting and
  signed value as a certainty fact while leaving `OutcomeObtained` separate.
- `BellInterpretiveSemantics` supplies only the ontic relations needed by the
  adapter. `bellJointlyRepresents` means exact simultaneous Pauli-Z and
  Pauli-X `SharpValue` facts for one supplied density description.
  `bellEPRInterpretation` combines these without asserting any relation as a
  fact of nature.
- `bellPhiPlusPhysicalSituation` takes distinct prior and post realities.
  `bell_z_x_alternative` checks the context difference, while
  `bell_z_x_samePrior` is only a convenience result for situations explicitly
  built from the same supplied prior.
- `bellPhiPlus_noJointRepresentation_zx` unfolds exact Z/X sharpness and uses
  `pauliXZ_noJointSharpState`; it does not replace the required state-level
  obstruction with bare `pauliXZ_noncommutes`.
- The outcome-generic `bellPhiPlus_epr_incompleteness` takes arbitrary selected
  Z and X outcomes, separate prior/post realities, explicit
  `SamePriorReality`, both actuality hypotheses, both ontic no-disturbance
  hypotheses, and all four interpretative bridges. Its mathematical certainty
  comes from the bundled all-four-branch scenario and its contradiction from
  the checked Pauli no-joint-sharp-state result. Its conclusion is only
  relative incompleteness of the supplied density description for the common
  prior reality.
- The public `EPR` root imports `EPR.Examples.BellNoSignalling` and
  `EPR.Examples.BellEPR` as independent operational and interpretative
  branches. Neither branch is a premise of the other, and no diagnostic audit
  is publicly imported.

### Diagnostics and premise separation

- `EPR.Audit.EPRLogic` supplies proposition-valued models demonstrating that
  certainty does not assert actuality and that `RealityCriterion`,
  `RealityValueBridge`, `CounterfactualStability`, and
  `CompletenessRepresentationBridge` can each be denied independently.
  `completeness_without_joint_representation` additionally checks that the
  necessary counterpart condition alone does not force joint representation.
- `bell_all_branch_predictions` and
  `bell_all_outcomes_no_joint_representation` quantify over every outcome of
  both Bell settings. `bell_prediction_does_not_assert_actuality` checks the
  checked prediction against semantics in which no outcome is actual.
- `operational_noSignalling_with_ontic_change` proves the checked Bell
  operational no-signalling fact together with denial of
  `NoOnticDisturbance` for an explicit toy physical situation. This is a
  compile-checked sentinel that marginal invariance cannot fill the ontic
  hypothesis by definition, implication, or coercion.
- `EPR.Audit.EPRLogicAxioms` checks and axiom-prints all 58 explicit Stage 8
  declarations: 26 abstract, 13 Bell, and 19 diagnostic. Every abstract
  declaration reports no axioms. The Bell and diagnostic declarations report
  at most the standard mathlib footprint `[propext, Classical.choice,
  Quot.sound]`; no project-specific axiom occurs.

### Source and documentation result

- Direct inspection of printed pages 777–780 and the transcription anchors
  fixes the formal boundary: certainty without disturbance is sufficient-only;
  completeness initially requires counterparts only; same-reality transport,
  simultaneous aggregation, and representation by the theory are further
  steps. The printed objection makes the aggregation premise visibly
  disputable, and the final paragraph leaves a different complete theory open.
- `docs/PaperMap.md` maps each source step to the exact checked declaration and
  records the finite Bell construction as a role analogue, not the original
  continuum example. `docs/Corrections.md` now records the actuality/certainty/
  reality/value separation as C-010 and updates the locality, aggregation, and
  completeness corrections. `docs/Dependencies.md` records the exact Stage 8
  API, import graph, proof inputs, public/audit boundary, and operational-versus-
  ontic diagnostic.
- No Stage 9 continuum declaration was introduced. `9-CONTINUUM` is the first
  incomplete stage and remains responsible for the paper's position-momentum,
  plane-wave, delta, Fourier, and distributional issues.

### Verification evidence

- Baseline before Stage 8 edits: from `formal/`,
  `lake build EPR.Examples.PauliIncompatibility` succeeded with 3204 jobs and
  full `lake build` succeeded with 3208 jobs. Initial proof-hole and
  declaration-level project-axiom scans had no matches.
- Final focused warning-as-error builds succeeded with 72 jobs for
  `EPR.Logic.EPR`, 3206 for `EPR.Examples.BellEPR`, 3209 for
  `EPR.Audit.EPRLogic`, 3210 for `EPR.Audit.EPRLogicAxioms`, and 3210 for the
  public `EPR` root. The combined warning-as-error build of all five targets
  succeeded with 3212 jobs. The required final full `lake build` succeeded
  with 3210 jobs.
- Exact signature and theorem-body inspection confirms that every premise is
  consumed, both actual-outcome and ontic hypotheses remain explicit, the
  main Bell theorem takes distinct prior realities plus their equality, and
  the conclusion is only conditional relative incompleteness.
- Proof-hole, forbidden-declaration, coercion, no-signalling-proof-path,
  bare-noncommutation, public-audit-import, and premature-continuum scans have
  no matches. Import, checked-input, exact-name, declaration-inventory,
  trailing-whitespace, Markdown-table, stale-status/name, pin, diff, and Git
  history checks pass.
- The final toolchain recheck reports Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; Lake and the manifest still pin
  mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Two implementation probes produced useful negative evidence. A completely
  import-free first draft of the abstract module did not have the project's
  `Type*` parser support, so the final module uses the narrow logic-only
  `Mathlib.Logic.Basic` import and no quantum dependency. The first diagnostic
  build found four `unnecessarySimpa` linter warnings; replacing those proof
  endings with direct simplification made every warning-as-error build clean.
- Independent proof and API reviews found no blocker. Their transparency
  recommendations are reflected in the final theorem: it takes distinct
  prior realities plus explicit `SamePriorReality`, and its fixed-preparation
  constructor is named `bellPhiPlusPhysicalSituation`.

Final commands run from `formal/` unless a path explicitly starts with `../`:

```bash
lake build -KwarningAsError=true EPR.Logic.EPR
lake build -KwarningAsError=true EPR.Examples.BellEPR
lake build -KwarningAsError=true EPR.Audit.EPRLogic
lake build -KwarningAsError=true EPR.Audit.EPRLogicAxioms
lake build -KwarningAsError=true EPR
lake build -KwarningAsError=true EPR EPR.Logic.EPR EPR.Examples.BellEPR EPR.Audit.EPRLogic EPR.Audit.EPRLogicAxioms
lake build
lake env lean --version
rg -n '\b(sorry|admit|sorryAx)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe|partial[[:space:]]+def)[[:space:]]|implemented_by' EPR EPR.lean
rg -n '(instance.*Coe|CoeTC|CoeFun|\bcoe\b)' EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean
rg -n 'OperationalNoSignallingAtoB|localA_nonselective_noSignalling|bellPhiPlus_operationalNoSignalling' EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean
rg -n 'pauliXZ_noncommutes' EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean
rg -n 'bellPhiPlusSteeringScenario\.predicts|pauliXZ_noJointSharpState' EPR/Examples/BellEPR.lean
rg -n 'EPR\.Audit' EPR.lean EPR/Logic EPR/Quantum EPR/Examples
rg -ni 'plane[ -]wave|\bDirac\b|\bdelta\b|L²|\bposition\b|\bmomentum\b|\bSchwartz\b|\bdistribution(al)?\b|\bFourier\b|\bunbounded\b' EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean EPR/Audit/EPRLogic.lean
rg -n '^[[:space:]]*(public[[:space:]]+|private[[:space:]]+)?import[[:space:]]' EPR.lean EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean EPR/Audit/EPRLogic.lean EPR/Audit/EPRLogicAxioms.lean
rg -n '[[:blank:]]+$' EPR.lean EPR/Logic/EPR.lean EPR/Examples/BellEPR.lean EPR/Audit/EPRLogic.lean EPR/Audit/EPRLogicAxioms.lean ../goal-1/0-plan.md ../goal-1/8-EPR-LOGIC.md ../docs/Corrections.md ../docs/Dependencies.md ../docs/PaperMap.md
git diff --check
git log --check --oneline 442b844..HEAD
```
