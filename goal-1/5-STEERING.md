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
- Each of the four A-side branches has proved probability `1/2`, raw relative
  B weight `1/2` and matrix `(1/2) • targetDensity`, normalized matching
  conditional B state, matching B outcome probability one, and matching Pauli
  sharp value.
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

Stage 5 completed on 2026-07-17.

### Implemented surface

- Added `EPR.Quantum.Steering` with two generic operational structures:
  `PerfectConditionalPrediction` requires both strict source-branch positivity
  and target probability one in the normalized conditional state;
  `SteeringScenario` records a state, separately tagged source/target
  observables, a complete source PVM tied to source spectral outcomes, an
  explicit response map, and a checked prediction for every setting/outcome.
  The final minimal signature of `PerfectConditionalPrediction` needs
  `[Fintype ι] [Fintype κ] [DecidableEq κ]`; it does not retain an accidental
  source `DecidableEq ι` dependency.
- Added `EPR.Examples.BellSteering` with the normalized ordered Bell state
  `|Φ⁺⟩`, Pauli `Z` and `X`, their normalized eigenstates, rank-one spectral
  outcomes, and complete binary PVMs. `bellPhiPlus_basis_convention` fixes the
  four `A × B` amplitudes, both exact basis expansions compile, and
  `bellPhiPlus_not_product` excludes a raw tensor factorization.
- `bellPhiPlus_probability`, `bellPhiPlus_relativeB_weight`,
  `bellPhiPlus_relativeB_matrix`, `bellPhiPlus_conditionalB`,
  `bellPhiPlus_target_probability_one`,
  `bellPhiPlus_opposite_probability_zero`, and
  `bellPhiPlus_conditional_sharpValue` quantify over both settings and both
  outcomes. The conditional theorem accepts an arbitrary strict-positivity
  proof; it is not tied to a particular proof term.
- `bellPhiPlus_perfectPrediction` packages one nonvacuous branch and
  `bellPhiPlusSteeringScenario` packages all four using the identity response
  map. The source PVM projectors are explicitly equated with source-side
  spectral outcomes, while target outcomes are routed through a distinct
  B-side observable tag.
- The public root now follows
  `EPR → EPR.Examples.BellSteering → EPR.Quantum.Steering →
  EPR.Quantum.Conditional`; neither Stage 5 audit leaf is imported publicly.
- `EPR.Audit.BellSteering` makes every case explicit and checks amplitude,
  outcome-value, tensor-order, raw-branch, normalized-state, certainty,
  opposite-outcome, sharp-value, positivity, and response conventions. The
  X-minus raw and normalized off-diagonal entries are checked as `-1/4` and
  `-1/2`. The A-side `Z+` lift accepts `(0,1)` and rejects `(1,0)`, catching a
  subsystem swap that the symmetric Bell state alone could hide.
- `EPR.Audit.BellSteeringAxioms` checks the generic/concrete signatures and
  prints the axiom footprint of the principal declarations and all executable
  sentinels. `docs/PaperMap.md`, `docs/Dependencies.md`, and
  `docs/Corrections.md` now record the completed finite analogue, checked
  dependency surface, and correction C-009 for selected-coefficient
  normalization.

### Exhaustive branch result

| Setting | A label/value | A probability | Raw relative B branch | Conditional B state | Target probability/value |
| --- | --- | --- | --- | --- | --- |
| `Z` | `0 / +1` | `1/2` | `(1/2) • (zState 0).toDensity` | `(zState 0).toDensity` | `1 / +1` |
| `Z` | `1 / -1` | `1/2` | `(1/2) • (zState 1).toDensity` | `(zState 1).toDensity` | `1 / -1` |
| `X` | `0 / +1` | `1/2` | `(1/2) • (xState 0).toDensity` | `(xState 0).toDensity` | `1 / +1` |
| `X` | `1 / -1` | `1/2` | `(1/2) • (xState 1).toDensity` | `(xState 1).toDensity` | `1 / -1` |

The audit additionally proves probability zero for the opposite target label
in each row and the corresponding sharp value `+1` or `-1`.

### Verification evidence

- Baseline before Stage 5 edits: `lake build EPR.Quantum.Conditional`
  succeeded with 2665 jobs and full `lake build` succeeded with 2667 jobs.
- The final combined warning-as-error build of the public root, generic
  steering module, Bell example, executable audit, and axiom audit succeeded
  with 3206 jobs. Its rebuilt targets included 3201 for the generic module,
  3202 for the example, 3203 for the public root, and 3205 for the executable
  audit within that combined target graph.
- Standalone focused builds succeeded with 3202 jobs for the example, 3203
  for the executable audit, 3204 for the axiom audit, and 3204 for the public
  root. The required final full `lake build` succeeded with 3204 jobs.
- Every `#print axioms` result in the Stage 5 axiom audit reports exactly
  `[propext, Classical.choice, Quot.sound]`. Signature output confirms strict
  positivity is a field of `PerfectConditionalPrediction` and confirms the
  source PVM/spectral-outcome association in `SteeringScenario`.
- Public/completed Lean scans found no `sorry`, `admit`, declaration-level
  `axiom`, `opaque`, `unsafe`, or broad coercion. The generic steering module
  has no `Fin 2`, qubit, Bell, Pauli, amplitude, fixed outcome, interpretative,
  or continuum reference. No audit import occurs in the public chain.
- The later-stage leakage scan finds only the example module's negative
  disclaimer that it contains no no-signalling or interpretative conclusion;
  it finds no Stage 6 incompatibility theorem, Stage 7 marginal-invariance
  result, Stage 8 premise/conclusion, or Stage 9 analytic construction.
- The exhaustive audit names all four probabilities, raw weights/matrices,
  normalized conditional states, matching and opposite probabilities, sharp
  values, and positive packaged branches. Relevant trailing-whitespace,
  stale-documentation, working-tree diff, and autosave-commit diff checks pass.
- The final toolchain recheck reports Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; Lake and the manifest still pin
  mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.

Final commands run from `formal/` unless a path explicitly starts with `../`:

```bash
lake build EPR.Quantum.Steering
lake build EPR.Examples.BellSteering
lake build EPR.Audit.BellSteering
lake build EPR.Audit.BellSteeringAxioms
lake build EPR
lake build -KwarningAsError=true EPR EPR.Quantum.Steering EPR.Examples.BellSteering EPR.Audit.BellSteering EPR.Audit.BellSteeringAxioms
lake build
lake env lean --version
rg -n '\b(sorry|admit)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe)[[:space:]]' EPR EPR.lean
rg -n '(instance.*Coe|CoeTC|CoeFun|\bcoe\b)' EPR/Quantum/Steering.lean EPR/Examples/BellSteering.lean
rg -ni 'Fin[[:space:]]+[23]|qubit|bell|pauli|phi|amplitude|ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|plane[ -]wave|Dirac|delta|L²' EPR/Quantum/Steering.lean
rg -n 'EPR\.Audit' EPR.lean EPR/Quantum EPR/Examples
rg -ni 'not_commut|commutator|not_jointly|no.common|no.?signall|marginal.*invari|ElementOfReality|CompleteFor|SimultaneouslyReal|plane[ -]wave|Dirac|delta|L²' EPR/Examples/BellSteering.lean EPR/Audit/BellSteering.lean
rg -n '^(public )?import ' EPR.lean EPR/Quantum/Steering.lean EPR/Examples/BellSteering.lean EPR/Audit/BellSteering.lean EPR/Audit/BellSteeringAxioms.lean
rg -n '[[:blank:]]+$' EPR.lean EPR/Quantum/Steering.lean EPR/Examples/BellSteering.lean EPR/Audit/BellSteering.lean EPR/Audit/BellSteeringAxioms.lean ../goal-1/0-plan.md ../goal-1/5-STEERING.md ../docs/Corrections.md ../docs/Dependencies.md ../docs/PaperMap.md
rg -n --glob '!5-STEERING.md' '5-STEERING.*[Ii]n progress|Stage 5 will|concrete.*remains.*Stage 5|No Bell/Pauli steering package|provisionally.*Φ|planned `PerfectlyPredicts`|bell_z_perfectPrediction|bell_x_perfectPrediction' ../goal-1 ../docs
rg -n 'fabf563a7c95a166b8d7b6efca11c8b4dc9d911f|leanprover/lean4:v4.31.0' lake-manifest.json lakefile.toml lean-toolchain
git diff --check
git log --check --oneline 2f82f04..HEAD
```

The proof-hole, declaration, coercion, generic-reference, public-audit-import,
trailing-whitespace, and stale-text scans returned exit status 1 with no
matches. The later-stage scan returned only line 16 of the public example's
negative disclaimer. The import scan returned the intended public chain plus
the one-way diagnostic-leaf imports. Pin/version and four-branch scans returned
the expected declarations. Both Git checks returned status 0.

### Failures encountered and corrections made

- The first focused command was accidentally run from the repository root,
  where Lake correctly reported that no `lakefile` exists; every subsequent
  Lean command used `formal/` as the project root.
- Early square-root definitions based directly on `sqrt (1/2)` left brittle
  real/complex and normalization goals. Fixing the positive amplitude as
  `Real.sqrt 2 / 2`, then proving its real square, complex square, `star`, and
  `starRingEnd` identities once, made every finite calculation stable.
- The first X-state formula created dependent finite-index simplification
  noise, and X normalization initially exposed `starRingEnd` rather than
  ordinary `star`. A uniform two-case ket formula plus the explicit
  `starRingEnd_invSqrtTwo` lemma removed both problems.
- The initial Bell X-expansion left elementary scalar arithmetic goals, and an
  early setting match used an invalid Unicode implication arrow. Exhaustive
  components followed by `ring`, and ordinary Lean match arrows, fixed those
  syntax/arithmetic failures.
- Normalizing the proved raw `(1/2) • targetDensity` branch initially left the
  goal `2 • (1/2) • M = M`; adding `smul_smul` to the final numeric
  simplification closed it without a new assumption.
- The first tensor-order sentinel passed a pair of matrix indices as one
  nested argument, and the first X-minus audit did not unfold the outer-product
  entry far enough. Supplying the two matrix arguments separately and exposing
  `Matrix.vecMulVec_apply` plus the checked star identity produced the intended
  `1/0`, `-1/4`, and `-1/2` checks.
- Final API review found that `PerfectConditionalPrediction` unnecessarily
  requested `DecidableEq ι`. Removing it and rebuilding confirmed the minimal
  generic boundary; `SteeringScenario` correctly retains source equality only
  because its complete source PVM needs it.

### What was learned and next stage

- Retaining the raw relative branch is the exact finite bridge to the paper's
  selected coefficient functions: its trace weight records probability before
  normalization. In this example every coefficient has squared norm `1/2`.
- A probability-one conditional statement is not by itself a safe steering
  certificate. Strict source-branch positivity must be data, otherwise a
  universally quantified conditional theorem can be vacuous on an impossible
  branch.
- Exact conditional density equality is preferable to literal ket equality:
  it respects global-phase invariance while still deriving support, certainty,
  opposite exclusion, and sharp value.
- Bell-state symmetry does not audit tensor order. A deliberately asymmetric
  lifted-projector coordinate check is needed even when every state-level
  branch calculation is correct.
- The finite example is a normalized role analogue for Eqs. (7)–(8); it is not
  a discretization of Eq. (9) and proves none of the paper's `-p`, `x+x₀`, or
  unbounded-operator claims.

The plan now marks `5-STEERING` complete. `6-INCOMPATIBILITY` is the first
incomplete stage. This turn stops here and does not prove Pauli noncommutation,
no common eigenvector/sharp state, or the required higher-dimensional
counterexample.
