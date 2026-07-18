# 10-AUDIT

## Current Facts

- At its start, Stage 10 was the first incomplete and final indexed stage in
  `goal-1/0-plan.md`. Stages 1--9 and their evidence records are preserved.
- The Stage 10 start worktree is clean at autosave commit `6fb4051`; there are
  no uncommitted changes to preserve.
- Lean is pinned to `v4.31.0`, and mathlib is pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f` in both Lake configuration and
  manifest.
- At the baseline, the complete local transcription of printed pages 777--780
  was reinspected. The existing paper map covered the completeness condition,
  sufficient reality criterion, Eqs. (2)--(18), alternative conditional wave
  functions, the no-real-change/same-reality premise, the simultaneous-reality
  aggregation, the final reductio, the objection, and the open possibility of
  another complete theory. Final row-by-row declaration verification is still
  required.
- At the Stage 10 baseline, warning-as-error
  `lake build EPR EPR.Continuum.Idealized` succeeds with 3614 jobs. Default
  `lake build` succeeds with 3210 jobs because `defaultTargets = ["EPR"]` and
  the root does not yet import continuum.
- At that baseline, `EPR.lean` imports only
  `EPR.Examples.BellNoSignalling` and `EPR.Examples.BellEPR`; it has no module
  documentation. Every public leaf inspected has a module docstring, and no
  public module imports `EPR.Audit`.
- At that baseline, the README is a setup-era document: it says the project is
  being developed and the main incompleteness result is eventual, and it does
  not inventory the completed API, limitations, or final audit command.
- At that baseline, eight stage-specific axiom leaves contain 245 `#check`
  commands and 283 `#print axioms` commands in total. Their recorded outputs
  use no project-specific axioms, but there is no aggregate whole-library audit
  target or public-root surface sentinel.
- At that baseline, `EPR.Audit.EPRLogic` provides checked rejection models for
  each major interpretative bridge and an operational-no-signalling/ontic-
  change model. It does not yet give one consolidated positive model witnessing
  that the premise interfaces can also be instantiated coherently.
- Initial scans found no `sorry`, `admit`, `sorryAx`, project `axiom`, `opaque`,
  `unsafe`, `partial def`, `implemented_by`, or public audit import. Git diff
  and whitespace checks are clean.

## Updated Assumptions

- Stage 10 is an API, traceability, and trust audit. It must not strengthen the
  mathematical or philosophical conclusions merely to make the final surface
  look more complete.
- The stable generalized-state continuum leaf should be reachable from the
  public root so the default target covers every completed public branch. This
  umbrella import must not make any finite module depend on continuum or any
  continuum module depend on finite/interpretative code.
- Diagnostics remain opt-in `EPR.Audit.*` modules. A public-root surface probe
  may import only `EPR`, while a separate final axiom target may aggregate all
  stage audit leaves.
- Existing rejectability sentinels are genuine examples of declining premises.
  A small positive proposition-valued model can demonstrate instantiation
  without asserting that the premises describe nature.
- The raw Eq. (9) oscillatory-integral identity, affine-distribution
  nonzeroness/support/non-`L²` classification, self-adjoint spectral
  realizations, and continuous conditioning remain future analytic
  obligations. Final documentation must not relabel them as completed.

## Big Picture Objective

- Finish the reusable public surface, source-to-declaration traceability,
  correction/limitation record, premise-choice examples, and whole-library
  trust audit so every success metric in `goal-1/0-plan.md` has direct current
  evidence.

## Detailed Implementation Plan

- Give `EPR.lean` a concise library overview and re-export the independent
  `EPR.Continuum.Idealized` leaf alongside the finite no-signalling and
  conditional-EPR branches.
- Add an opt-in public-surface audit importing only `EPR` and checking
  representative reusable definitions and main theorems from every completed
  layer, including continuum.
- Add an opt-in final axiom leaf that aggregates every existing stage-specific
  axiom leaf and prints the axioms of the principal mathematical, operational,
  logical, diagnostic-boundary, and continuum results.
- Extend `EPR.Audit.EPRLogic` with a proposition-valued model in which the
  interpretative bridges are all satisfiable; retain and audit the existing
  independent rejection models.
- Replace the setup-era README with the completed library surface, exact pinned
  build/audit commands, a clear conditional-theorem statement, examples for
  accepting or declining premises, and the continuum limitations.
- Audit and update `docs/PaperMap.md`, `docs/Corrections.md`, and
  `docs/Dependencies.md` so every material source claim, modern addition,
  correction, idealization, trust boundary, and unresolved obligation has an
  exact status and declaration path.
- Fold exact final evidence into this record and the master plan only after all
  completion checks pass.

## No-Cheating Checks

- Confirm no `EPR.Audit` import is reachable from `EPR.lean` or any public
  runtime/example/logic/continuum module.
- Confirm the public-surface audit imports only `EPR`; declarations that pass
  only because it imports internal or audit modules do not count.
- Confirm finite modules still contain no continuum imports and the continuum
  leaf still contains no finite quantum, example, logic, or reality API.
- Inspect the abstract and Bell incompleteness theorem signatures and bodies:
  all actuality, ontic, reality/value, counterfactual, completeness, and
  no-joint-representation inputs must remain explicit and consumed.
- Confirm no no-signalling declaration occurs in the abstract/Bell EPR proof
  path, and no bare Pauli noncommutation theorem replaces the no-joint-sharp
  result.
- Confirm the premise-choice examples are proposition-valued models, not
  global physical axioms or unconditional claims about nature.
- Confirm continuum objects never inhabit finite state/probability/reality
  APIs and all remaining analytic obligations stay explicit.
- Check every PaperMap row against a current declaration, explicit premise,
  correction, or named unresolved item; verify all code-formatted declaration
  names exist.
- Run proof-hole, project-axiom, forbidden-declaration, public-import,
  dependency-direction, theorem-body, stale-name/status, Markdown-table,
  whitespace, pin, manifest, and Git diff/history scans.

## Completion Requirements

- The public `EPR` root documents and exports every stable completed branch,
  while all diagnostic scaffolding remains opt-in and outside that import
  chain.
- Every main paper claim is mapped to a checked declaration, explicit premise,
  correction, modern finite analogue, or precisely stated unresolved analytic
  obligation.
- The README and living docs state the exact conditional scope, operational/
  ontic distinction, noncommutation correction, continuum representation, and
  remaining limits.
- Checked examples demonstrate both coherent premise instantiation and
  independent rejection without asserting either interpretation as nature.
- A public-root-only surface audit and aggregate axiom audit compile with
  warnings as errors; every principal result has an explained trusted-axiom
  footprint and no project-specific axiom.
- Focused changed-module builds, the public/default full build, every
  stage-specific audit through the aggregate target, proof-hole and forbidden-
  shortcut scans, dependency/API checks, exact declaration-name checks,
  `git diff --check`, and clean autosave-managed status all pass with exact
  evidence recorded.
- The master plan's final success metrics are audited requirement by
  requirement before Stage 10 or the whole goal is marked complete.

## Stage Results

**Status:** Complete on 2026-07-18. Stage 10 is the final indexed stage. The
whole-goal success metrics were audited individually below and all are
satisfied for the deliberately bounded formalization.

### Public surface and premise examples

- `EPR.lean` now documents and publicly re-exports the finite operational
  branch, the conditional Bell/Pauli EPR branch, and the independent
  `EPR.Continuum.Idealized` branch. It imports no diagnostic module.
- `EPR.Audit.PublicAPI` imports only `EPR` and contains 65 direct `#check`
  sentinels spanning foundations, finite state/measurement infrastructure,
  bipartite reduction, conditioning, steering, incompatibility,
  no-signalling, every central interpretative relation/bridge, the abstract
  and Bell incompleteness results, and continuum declarations.
- `acceptingInterpretation` and `allInterpretiveBridges_satisfiable` give a
  positive proposition-valued usage model. `eprWitnessInterpretation` and
  `toy_epr_incompleteness_via_explicit_premises` exercise the complete abstract
  theorem signature with every premise supplied. The previously checked
  independent rejection models and the operational-no-signalling/ontic-change
  sentinel remain intact. All are diagnostics, not assertions about nature.
- The README now states the conditional scope, including common-prior reality,
  inventories the checked results and remaining limits, gives the stable import
  and exact audit commands, and points to the living source/design records.

### Source audit, corrections, and dependency record

- The supplied four-page PDF was rendered and inspected directly at printed
  pages 777--780, and its complete transcription at lines 20--190 was compared
  with the final map. The transcription's stale nonexistent image links were
  replaced by links to the supplied four-page PDF.
- `docs/PaperMap.md` now has one 21-row, five-column, source-line-anchored
  disposition table. It distinguishes checked source equations, finite modern
  analogues, explicit interpretative premises, corrections, out-of-scope
  dynamics, and justified unresolved analytic work. The later finite,
  continuum, logic, incompatibility, no-signalling, API, and trust explanations
  agree with that table.
- `docs/Corrections.md` now records 14 corrections/idealizations, including the
  sufficient-only reality criterion, instrument-dependent disturbance,
  unmodeled interaction-cessation antecedent, reduced versus selected subsystem
  states, finite PVM/Lüders role analogy, global phase/density semantics, and
  the exact unproved Eq. (9), Eq. (15), and Eq. (16) obligations.
- `docs/Dependencies.md` now records the three-branch umbrella, narrow-import
  independence, opt-in diagnostic boundary, premise examples, complete theorem
  coverage, final audit closure, and current module graph.

### Build evidence

All commands ran from `formal/` with the pinned toolchain:

```text
lake build -KwarningAsError=true EPR.Audit.PublicAPI
Build completed successfully (3614 jobs).

lake build -KwarningAsError=true EPR.Audit.PublicTheoremAxioms
Build completed successfully (3614 jobs).

lake build -KwarningAsError=true EPR.Audit.FinalAxioms
Build completed successfully (3633 jobs).

lake build -KwarningAsError=true EPR EPR.Audit.PublicAPI EPR.Audit.FinalAxioms
Build completed successfully (3634 jobs).

lake build -KwarningAsError=true
Build completed successfully (3614 jobs).
```

The default target is `EPR`; its increase from the Stage 10 baseline's 3210
jobs to 3614 confirms that the default build now covers the public continuum
branch as intended.

### Declaration-complete trust evidence

- Compiler-environment inventory reports exactly 14 modules in the public
  `EPR` closure and no `EPR.Audit` module.
- Source/set comparison reports exactly 203 distinct public theorem
  declarations: Core 17, Bipartite 29, Conditional 40, Incompatibility 10,
  NoSignalling 8, BellSteering 47, PauliIncompatibility 5, BellNoSignalling 9,
  Logic 8, BellEPR 6, Continuum 24, and zero in the root, Foundations, and
  Steering files.
- The eight stage-specific axiom leaves now have 250 `#check` and 288 unique
  `#print axioms` commands. Exactly 132 of those prints are public theorem
  declarations. `EPR.Audit.PublicTheoremAxioms` has 74 unique prints: the 71
  complementary public theorems plus `Setting`,
  `PerfectConditionalPrediction`, and `SteeringScenario`. The public-theorem
  overlap is zero, coverage is 203/203, and missing/duplicate counts are zero.
- Import-closure comparison finds all 20 `EPR.Audit` modules reachable from
  `EPR.Audit.FinalAxioms`, with zero missing or unknown modules.
- The aggregate emits 379 axiom reports: 288 stage-specific, 74 complementary,
  and 17 intentional principal repeats. These cover 362 unique declarations.
  Of the 379 reports, 45 are axiom-free, 8 use only `[propext]`, 5 use only
  `[propext, Quot.sound]`, and 321 use only
  `[propext, Classical.choice, Quot.sound]`. No report contains any other or
  project-specific axiom. In particular, `EPR.Logic.epr_incompleteness` is
  axiom-free.
- The exact snapshot probes were:

```text
python3 /tmp/public_coverage.py
PUBLIC_FILE_COUNT 14
PUBLIC_THEOREM_COUNT 203
PUBLIC_COVERED_COUNT 203
PUBLIC_MISSING_COUNT 0
PUBLIC_OVERLAP_COUNT 0
STAGE_DUPLICATE_PRINT_COUNT 0
COMPLEMENT_DUPLICATE_PRINT_COUNT 0

python3 /tmp/final_audit_coverage.py
AUDIT_FILE_COUNT 20
FINAL_REACHABLE_AUDIT_COUNT 20
FINAL_MISSING_AUDIT_COUNT 0
FINAL_UNKNOWN_AUDIT_COUNT 0

lake env lean -DwarningAsError=true /tmp/PublicModuleInventory.lean
PUBLIC_MODULE_COUNT 14

lake env lean -DwarningAsError=true /tmp/FinalAuditInventory.lean
FINAL_AUDIT_MODULE_COUNT 20
```

The temporary probes are read-only and are not project deliverables; the Lean
audit modules are the durable compile-checked sentinels. Re-running the set
comparison is required if future public declarations or audit modules are
added.

### No-cheating, dependency, and document checks

- Syntax-shaped scans over `formal/EPR.lean` and `formal/EPR/**/*.lean` find no
  `sorry`, `admit`, `sorryAx`, `axiom(s)`, `constant(s)`, `opaque`, `unsafe`
  declaration, `partial def`, `implemented_by`, `extern`, or `native_decide`.
- No public source imports `EPR.Audit`; no finite foundation/quantum/example/
  logic source imports `EPR.Continuum`; and the continuum source imports no
  project module. Every one of the 14 public files has module documentation.
- `EPR.Logic.EPR` and `EPR.Examples.BellEPR` contain no no-signalling name or
  import. Their theorem bodies retain every actuality, common-prior, ontic,
  reality/value, counterfactual, representation, and no-joint input.
  `BellEPR` uses `pauliXZ_noJointSharpState` and contains no use of
  `pauliXZ_noncommutes`.
- The continuum leaf contains no finite `PureState`, `DensityState`,
  prediction, or reality API. Its module documentation and living records
  preserve every normalization, domain, spectral, and conditioning limit.
- PaperMap table-shape inspection reports 23 lines with six boundary bars for
  its five-column source table (header, delimiter, and 21 rows) and six lines
  with seven bars for the later six-column Bell branch table. Duplicate legacy
  rows are absent, and spot checks plus the public/audit builds resolve every
  code-formatted declaration used as evidence.
- `lean-toolchain`, `lakefile.toml`, and `lake-manifest.json` agree on Lean
  `v4.31.0` and mathlib
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`. `git diff --check` passes.

### Failures found and corrected during Stage 10

- The first comprehensive PaperMap insertion temporarily left the legacy table
  below it; exact-row deletion removed the duplicate before verification.
- An initial broad forbidden-declaration regex matched the English word
  “axioms” in a module docstring. Declaration-shaped singular/plural rescans
  returned zero matches.
- Independent review found omitted source-map loci/anchors, an unmodeled
  separation antecedent, overbroad Eq. (5), Eq. (15), and Eq. (16) wording,
  missing affine-distribution nonzeroness, stale “private” terminology, and
  nonexistent transcription image links. Each was corrected and rechecked.
- Independent API review found that the README omitted the common-prior premise
  and that the public sentinel exposed several central logic names only
  indirectly. The README was corrected and direct checks were added. No Lean
  proof or build failure remained.

### Whole-goal success-metric audit

1. **Pinned reproducible build — satisfied.** The exact Lean/mathlib pins agree
   across configuration and manifest; warning-as-error focused, aggregate, and
   default builds pass from the documented `formal/` project root.
2. **Reusable public definitions — satisfied.** Generic public layers provide
   bipartite states, projective measurements, selective/nonselective states,
   conditional states, perfect predictions, steering scenarios, and separate
   incompatibility notions; the root-only 65-check sentinel compiles.
3. **Complete finite example — satisfied.** Stage 5 proves all four Bell/Pauli
   branch probabilities, raw/normalized remote states, perfect and opposite
   statistics, signed values, and the bundled scenario; Stage 6 proves the
   stronger no-common/joint-sharp obstruction and its noncommutation
   counterexample.
4. **Operational/ontic separation — satisfied.** Stage 7 proves generic
   directional projective no-signalling and Bell setting invariance. Stage 8
   keeps `NoOnticDisturbance` explicit, and the diagnostic coexistence theorem
   prevents an implication from being hidden.
5. **Explicit interpretative assumptions — satisfied.** Actuality, certainty,
   reality, value possession, same reality, counterfactual aggregation,
   counterparts, representation, and completeness are separate public
   judgments/bridges with positive and independently rejecting models.
6. **Conditional example-tied conclusion — satisfied.** The abstract theorem
   is fully premise-parameterized; the Bell specialization consumes the checked
   four-branch steering certificate and the Pauli no-joint-sharp theorem and
   concludes only relative incompleteness for the supplied description/reality.
7. **Paper-to-Lean traceability — satisfied.** Every material source claim is a
   checked declaration, finite modern analogue, explicit premise, correction,
   out-of-scope item, or precisely named unresolved obligation in the 21-row
   source table and 14-entry correction log.
8. **Honest continuum treatment — satisfied.** The public analytic leaf proves
   the stable generalized-state/common-domain fragment and explicitly leaves
   the raw Eq. (9) transform, stronger distribution classification, spectral
   realization, and exact continuous conditioning open; no generalized object
   is presented as a normalized `L²` state.
9. **No holes or unexplained project axioms — satisfied.** Source scans are
   empty and declaration-complete public/whole-audit reports contain only the
   standard trusted footprint.
10. **Final verification recorded — satisfied.** Focused, aggregate, and default
    builds, coverage/inventory probes, source/import/theorem-body scans,
    Markdown/pin checks, `git diff --check`, and the autosave-managed final
    status/history check are recorded here.

### Explicit remaining work outside the completed claims

- A literal continuum expansion still needs the raw scaled Eq. (9)
  partial-Fourier/change-of-variables identity, generalized-mode and affine-line
  nonzeroness, topological support/non-`L²` classification, Eq. (15)--(16)
  coefficient extraction, self-adjoint position/momentum realizations and
  spectral PVMs, and measurable continuous-outcome conditioning.
- A normalized approximation would need finite-resolution error bounds and a
  separately stated approximate or limiting reality premise. It cannot reuse
  the exact probability-one criterion silently.
- Time evolution, interaction cessation, spacetime separation, empirical
  correctness, arbitrary instruments/channels, and a universal
  measurement-disturbance theorem remain outside the proved result.

These items bound the completed claims; none is required by a result currently
described as checked.
