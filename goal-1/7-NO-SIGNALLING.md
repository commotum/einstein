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

**Status:** Complete on 2026-07-17.

### Implemented generic operational layer

- `EPR.Quantum.NoSignalling` imports only `EPR.Quantum.Conditional` and keeps
  the direction A→B explicit. `ProjectiveMeasurement.localAProjection` tags
  one source projector on A, and
  `ProjectiveMeasurement.sum_localAProjection_lift` proves the lifted family
  still resolves the identity on `A × B`.
- `localANonselectiveState ρ M` is a positive trace-one bipartite state whose
  matrix is exactly
  `∑ w, (P_w ⊗ I) ρ (P_w ⊗ I)`. The construction sums raw subnormalized
  branches, so their trace/Born weights are retained. No normalized selected
  conditional state appears in the definition or main proof.
- `traceOutA_localA_mul_cycle` proves cyclicity for one operator acting only on
  A. `traceOutA_ludersBranchMatrix_localA` combines that identity with
  projector idempotence to turn each traced `PρP` branch into `ρP`.
  Linearity of the partial trace and source-PVM completeness then give the main
  theorem `localA_nonselective_noSignalling`.
- `OperationalNoSignallingAtoB ρ M` is definitionally the exact equality
  `reducedB (localANonselectiveState ρ M) = reducedB ρ`.
  `localA_nonselective_outcomeProbability` derives invariance for an arbitrary
  `Q : Projection κ`, while `localA_nonselective_reducedB_independent` and
  `localA_nonselective_outcomeProbability_independent` compare any two
  complete A-side measurements, even with different outcome-label types.
- Exact signatures require only `[Fintype ω]`, `[Fintype ι]`, `[Fintype κ]`,
  `[DecidableEq ι]`, and `[DecidableEq κ]` where used. There is no
  `[Nonempty κ]` or `[DecidableEq ω]` leak; the two algebraic partial-trace
  helpers omit `[DecidableEq ι]` because their proofs do not require it.

### Implemented Bell specialization and diagnostics

- `EPR.Examples.BellNoSignalling` imports the generic module and the existing
  Bell steering example. `bellPhiPlusAfterLocalMeasurement` is the
  outcome-forgotten joint state for either Pauli source setting.
- `bellPhiPlus_operationalNoSignalling` and
  `bellPhiPlus_reducedB_invariant` cover every setting.
  `bellPhiPlus_sourceSetting_independent` compares any two settings directly;
  `bellPhiPlus_targetStatistic_invariant` and
  `bellPhiPlus_targetStatistic_sourceSetting_independent` cover every Pauli B
  target setting and outcome.
- `bellPhiPlus_selected_z_outcomes_differ` and
  `bellPhiPlus_selected_settings_differ` separately prove that selected
  positive-probability B states vary by outcome and by source setting.
  `bellPhiPlus_selected_changes_with_noSignalling` packages one such selected
  difference with operational no-signalling for both Z and X source
  measurements.
- `EPR.Audit.NoSignalling` computes the original Bell B marginal as `½I`. It
  also checks that the joint `|00⟩⟨11|` entry changes from `1/2` to `0` after
  the outcome-forgotten Z measurement, proving that the joint state really
  changes even though the B marginal does not.
- The audit proves that both post-Z and post-X B marginals equal `½I`, that a
  selected Z-positive B state differs from the unconditioned marginal by its
  `(0,0)` entry (`1` versus `1/2`), and packages joint change, selected change,
  and marginal invariance in
  `bellPhiPlus_joint_changes_selected_changes_marginal_does_not`.
- `rectangular_AtoB_noSignalling` instantiates the theorem on
  `Fin 2 × Fin 3`, so replacing `reducedB` with `reducedA` cannot typecheck.
  `rectangular_AtoB_all_statistics` quantifies over an arbitrary
  `Projection (Fin 3)`, independently checking the target-side and
  arbitrary-statistic scope.
- The public root now imports both `EPR.Examples.PauliIncompatibility` and
  `EPR.Examples.BellNoSignalling`, preserving all prior public stages without
  routing either Stage 7 audit into the consumer chain.

### Source and documentation result

- Direct inspection of printed pages 779–780 confirms that the paper asserts
  an ontic “no real change”/“does not disturb ... in any way” premise. It does
  not calculate the outcome-forgotten local Lüders state or invariant remote
  marginal. Stage 7 therefore records its checked theorem as a separate modern
  finite operational result rather than evidence for the paper's stronger
  premise.
- `docs/PaperMap.md` now has a separate modern operational row and a finite
  no-signalling section. The page-779 no-real-change row remains planned for
  Stage 8.
- Correction C-004 in `docs/Corrections.md` now marks the operational half
  checked in Stage 7 while retaining ontic no-disturbance as a Stage 8
  obligation. `docs/Dependencies.md` records the exact generic/concrete
  surface, raw-versus-selected distinction, projective-Lüders scope, public
  root branches, audit leaves, and corrected generic-to-example layering.
- Nothing in Stage 7 proves absence of interaction, spacetime or causal
  separation, communication impossibility for arbitrary protocols, arbitrary
  CPTP-channel invariance, ontic sameness, locality, physical reality,
  counterfactual aggregation, completeness, or incompleteness. Stage 8 remains
  responsible for every interpretative premise; Stage 9 remains responsible
  for the continuum example.

### Verification evidence

- Baseline before Stage 7 edits: `lake build
  EPR.Examples.PauliIncompatibility` succeeded with 3204 jobs and full
  `lake build` succeeded with 3206 jobs. Initial proof-hole and project-
  declaration scans had no matches.
- Focused warning-as-error builds succeeded with 2666 jobs for
  `EPR.Quantum.NoSignalling`, 3204 for
  `EPR.Examples.BellNoSignalling`, 3205 for `EPR.Audit.NoSignalling`, 3206 for
  `EPR.Audit.NoSignallingAxioms`, and 3208 for the public `EPR` root.
- The final combined warning-as-error build of the public root, both Stage 7
  public modules, and both diagnostic leaves succeeded with 3210 jobs. The
  required final full `lake build` succeeded with 3208 jobs.
- The Stage 7 axiom leaf checks and axiom-prints all 36 public declarations:
  11 generic, 10 Bell, and 15 diagnostic declarations. The two rectangular
  type abbreviations use no axioms. Every substantive declaration reports
  exactly `[propext, Classical.choice, Quot.sound]`.
- Signature output confirms the exact finite typeclass surface, raw
  nonselective-state matrix, post-marginal-equals-original orientation,
  arbitrary B projection, different source outcome-label types, both Bell
  settings, selected-state inequalities, and rectangular A→B direction.
- Proof-hole, declaration, coercion, generic-boundary, selected-API-use, and
  public-audit-import scans return status 1 with no matches. The later-stage
  scan finds only negative module disclaimers; no interpretative or continuum
  declaration exists. Import and theorem-body inspection return the intended
  one-way generic/example/diagnostic dependencies and raw-branch proof path.
- The final toolchain recheck reports Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; Lake and the manifest still pin
  mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Trailing-whitespace, Markdown-table, exact-name, stale-status/name,
  working-tree diff, and autosave-commit diff checks pass. Stage 8 is the first
  incomplete stage; no Stage 8 declaration was introduced.

Final commands run from `formal/` unless a path explicitly starts with `../`:

```bash
lake build -KwarningAsError=true EPR.Quantum.NoSignalling
lake build -KwarningAsError=true EPR.Examples.BellNoSignalling
lake build -KwarningAsError=true EPR.Audit.NoSignalling
lake build -KwarningAsError=true EPR.Audit.NoSignallingAxioms
lake build -KwarningAsError=true EPR
lake build -KwarningAsError=true EPR EPR.Quantum.NoSignalling EPR.Examples.BellNoSignalling EPR.Audit.NoSignalling EPR.Audit.NoSignallingAxioms
lake build
lake env lean --version
rg -n '\b(sorry|admit|sorryAx)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe|partial[[:space:]]+def)[[:space:]]|implemented_by' EPR EPR.lean
rg -n '(instance.*Coe|CoeTC|CoeFun|\bcoe\b)' EPR/Quantum/NoSignalling.lean EPR/Examples/BellNoSignalling.lean
rg -ni 'Fin[[:space:]]+[23]|qubit|bell|pauli|phi|amplitude|steer|ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|plane[ -]wave|Dirac|delta|L²|position|momentum' EPR/Quantum/NoSignalling.lean
rg -n 'localAConditionalBState|conditionalState|SubnormalizedState\.normalize' EPR/Quantum/NoSignalling.lean
rg -n 'EPR\.Audit' EPR.lean EPR/Quantum EPR/Examples
rg -ni 'ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|CounterfactualStability|epr_incompleteness|plane[ -]wave|Dirac|delta|L²|position|momentum|QuantumChannel|CPTP|Kraus' EPR/Quantum/NoSignalling.lean EPR/Examples/BellNoSignalling.lean EPR/Audit/NoSignalling.lean
rg -n '^(public )?import ' EPR.lean EPR/Quantum/NoSignalling.lean EPR/Examples/BellNoSignalling.lean EPR/Audit/NoSignalling.lean EPR/Audit/NoSignallingAxioms.lean
sed -n '55,185p' EPR/Quantum/NoSignalling.lean
rg -n 'bellPhiPlus_joint_offDiagonal|bellPhiPlus_z_nonselective_joint_offDiagonal|bellPhiPlus_z_nonselective_joint_ne_input|bellPhiPlus_z_nonselective_reducedB_matrix|bellPhiPlus_x_nonselective_reducedB_matrix|bellPhiPlus_selected_z0_ne_unconditionedB|rectangular_AtoB_noSignalling|rectangular_AtoB_all_statistics|bellPhiPlus_joint_changes_selected_changes_marginal_does_not' EPR/Audit/NoSignalling.lean EPR/Audit/NoSignallingAxioms.lean
rg -n '[[:blank:]]+$' EPR.lean EPR/Quantum/NoSignalling.lean EPR/Examples/BellNoSignalling.lean EPR/Audit/NoSignalling.lean EPR/Audit/NoSignallingAxioms.lean ../goal-1/0-plan.md ../goal-1/7-NO-SIGNALLING.md ../docs/Corrections.md ../docs/Dependencies.md ../docs/PaperMap.md
rg -n --glob '!7-NO-SIGNALLING.md' '7-NO-SIGNALLING.*[Ii]n progress|Stage 7 is checking|Stage 7 is in progress|Operational no-signalling remains Stage 7|No checked theorem yet constructs|local_measurement_noSignalling|root.*ends at.*PauliIncompatibility' ../goal-1 ../docs
rg -n 'fabf563a7c95a166b8d7b6efca11c8b4dc9d911f|leanprover/lean4:v4.31.0' lake-manifest.json lakefile.toml lean-toolchain
git diff --check
git log --check --oneline a4784e3..HEAD
```

The no-match scans return status 1 as expected. The import scan returns the
two public-root branches, generic `Conditional -> NoSignalling`, concrete
`NoSignalling + BellSteering -> BellNoSignalling`, and one-way audit imports.
The implementation slice shows the raw branch sum and the proof dependency on
partial-trace cyclicity, idempotence, linearity, and completeness. The audit
inventory, pin, and version scans return every expected declaration and exact
revision. Both Git checks return status 0.

### Failures encountered and corrections made

- A first design lifted the A measurement into a full joint
  `ProjectiveMeasurement`. Preserving its `nonzero` field requires
  `[Nonempty κ]`, because the identity matrix on an empty B index is zero.
  Defining the checked local nonselective state directly from the complete raw
  branch sum avoids that artificial public requirement while preserving the
  exact operation and proof.
- The first generic module build succeeded but emitted a flexible-tactic
  linter warning in the partial-trace cyclicity proof. Replacing the broad
  `simp`/`conv` step with an explicit double-sum calculation and
  `Finset.sum_comm` made the focused build warning-free.
- The first combined Bell theorem attempted to use the proof constant
  `bellPhiPlus_selected_settings_differ` where a proposition was required.
  Restating its exact selected-state inequality in the conjunction and using
  that theorem as the proof term fixed the type mismatch without weakening
  the result.
- The master plan's earlier phrase “trace-preserving local operation” could be
  read as an unproved arbitrary-channel theorem. The final plan and docs name
  the checked complete projective Lüders scope, while recording general
  channels as outside Stage 7 rather than silently narrowing or overclaiming.
