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

**Status:** Complete on 2026-07-17.

### Implemented generic layer

- `EPR.Quantum.Incompatibility` imports only `EPR.Quantum.Core` and defines
  the distinct predicates `Observable.Commutes`, `Noncommutes`,
  `IsEigenvector`, `HasCommonEigenvector`, `NoCommonEigenvector`,
  `HasJointSharpState`, and `NoJointSharpState`. The generic declarations
  require only `[Fintype ι]`; no `DecidableEq` or `Nonempty` requirement leaks
  into their signatures.
- `DensityState.exists_col_ne_zero` proves that a trace-one density matrix has
  a nonzero column, and `DensityState.col_isEigenvector_of_sharpValue` turns
  every column of a sharp density matrix into an eigenvector for the stated
  real value.
- `Observable.hasCommonEigenvector_of_jointlySharp` extracts a nonzero common
  eigenvector from one particular jointly sharp density state.
  `Observable.hasCommonEigenvector_of_hasJointSharpState` is its existential
  wrapper. The contraposed pointwise and existential exclusions are
  `Observable.not_jointlySharp_of_noCommonEigenvector` and
  `Observable.noJointSharpState_of_noCommonEigenvector`.
- The generic module contains no qubit, Pauli, Bell, fixed finite index,
  measurement, interpretative, no-signalling, or continuum construction. It
  intentionally proves no implication from `Noncommutes` to either spectral
  exclusion predicate.

### Implemented Pauli obstruction

- `EPR.Examples.PauliIncompatibility` reuses the exact Stage 5 Pauli
  observables. `pauliXZ_noncommutes` proves the unequal matrix products,
  independently of the spectral result.
- `pauliXZ_commonEigenvector_eq_zero` quantifies over an arbitrary raw qubit
  ket and arbitrary real `X` and `Z` candidate eigenvalues. Componentwise
  equations force the ket to be zero, so
  `pauliXZ_noCommonEigenvector` excludes every nonzero common eigenvector.
- `pauliXZ_noJointSharpState` applies the generic column bridge to exclude
  every pure or mixed qubit density state. The pointwise consumer theorem is
  `pauliXZ_not_jointlySharp`. Inspection and an independent compiled probe
  confirm that both use `pauliXZ_noCommonEigenvector`, never
  `pauliXZ_noncommutes`.
- `formal/EPR.lean` now exposes the public example through
  `EPR.Examples.PauliIncompatibility`. The generic module and Bell example are
  re-exported below it; neither audit leaf occurs in the public import chain.

### Checked counterexample and documentation

- `EPR.Audit.Incompatibility` checks that the Pauli products have values `-1`
  and `1` at entry `(0,1)` and that the all-density-state theorem accepts an
  arbitrary `DensityState (Fin 2)`.
- Its `Fin 3` observables are the Hermitian matrices
  `fin3A = diag(0,1,2)` and `fin3B = E₁₂ + E₂₁`. Their products have values
  `1` and `2` at entry `(1,2)`, so they do not commute. Nevertheless the
  normalized basis state `e₀` is a zero-eigenstate of both, and its rank-one
  density is jointly sharp for both. The theorem
  `fin3_noncommuting_with_common_sharp_state` packages noncommutation, a common
  nonzero eigenvector, and a jointly sharp density state in one checked
  conjunction.
- `EPR.Audit.IncompatibilityAxioms` checks and axiom-prints the complete public
  Stage 6 declaration inventory. The `Three := Fin 3` abbreviation uses no
  axioms. Every substantive generic, Pauli, and counterexample declaration
  reports exactly `[propext, Classical.choice, Quot.sound]`.
- `docs/PaperMap.md`, `docs/Corrections.md`, and `docs/Dependencies.md` now
  record the three-way mathematical distinction, correction C-003, exact
  theorem names, mixed-state bridge, public/diagnostic import boundary, and
  the checked higher-dimensional counterexample. They explicitly leave
  measurement disturbance, operational no-signalling, physical reality,
  counterfactual aggregation, completeness, and the continuum construction
  to their proper later stages.

### Verification evidence

- Before Stage 6 edits, `lake build EPR.Examples.BellSteering` succeeded with
  3202 jobs and full `lake build` succeeded with 3204 jobs. Initial proof-hole
  and project-declaration scans had no matches.
- Focused warning-as-error builds succeeded with 2664 jobs for
  `EPR.Quantum.Incompatibility`, 3204 for
  `EPR.Examples.PauliIncompatibility`, 3205 for
  `EPR.Audit.Incompatibility`, 3206 for
  `EPR.Audit.IncompatibilityAxioms`, and 3206 for the public `EPR` root.
- The final combined warning-as-error build of the public root, both public
  Stage 6 modules, and both diagnostic leaves succeeded with 3208 jobs. The
  required final full `lake build` succeeded with 3206 jobs.
- Signature output confirms arbitrary real eigenvalues, arbitrary density
  states, the direct and existential mixed-state bridges, and only
  `[Fintype ι]` on the generic API. The axiom output has the footprint stated
  above and contains no `sorryAx` or project declaration.
- Proof-hole, declaration, coercion, generic-boundary, and public-audit-import
  scans returned status 1 with no matches. The later-stage leakage scan found
  only the generic module's negative disclaimer that it proves no physical or
  counterfactual claim. Import and theorem-body inspection returned the
  intended one-way dependency chain. Counterexample-name and pin scans found
  every expected sentinel and exact pinned revision.
- The final toolchain recheck reports Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; Lake and the manifest still pin
  mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Trailing-whitespace, stale-status/name, working-tree diff, and autosave-commit
  diff checks pass. Stage 7 remains the first incomplete stage; no Stage 7
  declaration was introduced.

Final commands run from `formal/` unless a path explicitly starts with `../`:

```bash
lake build -KwarningAsError=true EPR.Quantum.Incompatibility
lake build -KwarningAsError=true EPR.Examples.PauliIncompatibility
lake build -KwarningAsError=true EPR.Audit.Incompatibility
lake build -KwarningAsError=true EPR.Audit.IncompatibilityAxioms
lake build -KwarningAsError=true EPR
lake build -KwarningAsError=true EPR EPR.Quantum.Incompatibility EPR.Examples.PauliIncompatibility EPR.Audit.Incompatibility EPR.Audit.IncompatibilityAxioms
lake build
lake env lean --version
rg -n '\b(sorry|admit|sorryAx)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe|partial[[:space:]]+def)[[:space:]]|implemented_by' EPR EPR.lean
rg -n '(instance.*Coe|CoeTC|CoeFun|\bcoe\b)' EPR/Quantum/Incompatibility.lean EPR/Examples/PauliIncompatibility.lean
rg -ni 'Fin[[:space:]]+[23]|qubit|bell|pauli|phi|amplitude|ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|no.?signall|marginal|plane[ -]wave|Dirac|delta|L²' EPR/Quantum/Incompatibility.lean
rg -n 'EPR\.Audit' EPR.lean EPR/Quantum EPR/Examples
rg -ni 'no.?signall|marginal.*invari|ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|counterfactual|incomplet|plane[ -]wave|Dirac|delta|L²|position|momentum' EPR/Quantum/Incompatibility.lean EPR/Examples/PauliIncompatibility.lean EPR/Audit/Incompatibility.lean
rg -n '^(public )?import ' EPR.lean EPR/Quantum/Incompatibility.lean EPR/Examples/PauliIncompatibility.lean EPR/Audit/Incompatibility.lean EPR/Audit/IncompatibilityAxioms.lean
sed -n '76,100p' EPR/Examples/PauliIncompatibility.lean
rg -n 'fin3_product_entry|fin3_noncommutes|fin3SharedState_eigen_[AB]|fin3_hasCommonEigenvector|fin3_pureDensity_jointlySharp|fin3_hasJointSharpState|fin3_noncommuting_with_common_sharp_state' EPR/Audit/Incompatibility.lean EPR/Audit/IncompatibilityAxioms.lean
rg -n '[[:blank:]]+$' EPR.lean EPR/Quantum/Incompatibility.lean EPR/Examples/PauliIncompatibility.lean EPR/Audit/Incompatibility.lean EPR/Audit/IncompatibilityAxioms.lean ../goal-1/0-plan.md ../goal-1/6-INCOMPATIBILITY.md ../docs/Corrections.md ../docs/Dependencies.md ../docs/PaperMap.md
rg -n --glob '!6-INCOMPATIBILITY.md' '6-INCOMPATIBILITY.*[Ii]n progress|Stage 6 will|Stage 6 must still|No checked project theorem yet connects|no Pauli incompatibility result exists|pauliXZ_not_commute|root, which ends at EPR.Examples.BellSteering' ../goal-1 ../docs
rg -n 'fabf563a7c95a166b8d7b6efca11c8b4dc9d911f|leanprover/lean4:v4.31.0' lake-manifest.json lakefile.toml lean-toolchain
git diff --check
git log --check --oneline c2c18d7..HEAD
```

The no-match scans returned exit status 1 as expected. The later-stage scan
returned only line 22 of the generic module's negative disclaimer. The import
scan returned the public chain and one-way diagnostic imports; the theorem
slice shows both Pauli joint-sharp exclusions applying the generic
no-common-eigenvector bridges. The counterexample and pin scans returned all
expected declarations and revisions. Both Git checks returned status 0.

### Failures encountered and corrections made

- The first generic focused build did not parse the matrix-vector notation
  `*ᵥ` because the new module had not opened the `Matrix` scoped notation. This
  also caused cascading type and unused-variable warnings. Adding
  `open scoped Matrix` fixed the parser root cause; the unchanged proof design
  then compiled warning-free.
- The first `fin3_product_entry` proof reduced the numerical matrix products
  but left elementary unequal-`Fin` index side goals. Closing those finite
  decidability goals with `all_goals decide` preserved the explicit entry
  calculation and made the diagnostic warning-free.
- An intermediate axiom leaf covered the existential mixed-state bridge but
  omitted the newer direct and pointwise bridge helpers. Those declarations
  were added to both the signature and axiom sections. A final independent
  inventory review then found that only the trivial public abbreviation
  `Three` lacked an entry; it too is now checked and axiom-printed, giving
  complete declaration coverage.
- The master plan retained the provisional name `pauliXZ_not_commute`, an
  in-progress Stage 6 status, and a stale public-root description inherited
  from Stage 5. They were reconciled with the compiled name
  `pauliXZ_noncommutes`, the completed stage, and the current
  `EPR.Examples.PauliIncompatibility` root without changing any later-stage
  status.
