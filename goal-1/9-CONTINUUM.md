# 9-CONTINUUM

## Current Facts

- At Stage 9 start, it was the first incomplete stage in `goal-1/0-plan.md`;
  Stages 1--8 and their evidence records were preserved, and Stage 10 had not
  begun.
- The Stage 9 start worktree is clean at autosave commit `087f622`.
- From `formal/`, baseline `lake build EPR` and default `lake build` both succeed
  with 3210 jobs. Initial proof-hole and declaration-level project-axiom scans
  return no matches.
- Lean remains pinned to `v4.31.0`; mathlib remains pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Direct comparison of the four-page facsimile with the transcription found no
  sign, variable, or Fourier-factor error in Eqs. (2), (6), and (9)--(18).
  With `h > 0`, the paper's convention gives exactly
  `h δ(x₁ - x₂ + x₀)` in Eq. (9); an unrestricted nonzero real scale would
  introduce `|h|` instead.
- Eq. (2)'s plane wave has modulus one and infinite `L²` mass. Eq. (6)'s
  `b - a` is unnormalized Lebesgue interval mass, not a Born probability.
  Eqs. (9)--(16) use distributions/generalized eigenvectors, not ordinary
  convergent integrals or normalized Hilbert-space vectors.
- Eq. (18) has the paper's correct sign,
  `[P,Q] = h/(2πi) = -iℏ`, only on a named common invariant domain such as
  Schwartz space.
- Pinned mathlib supplies Schwartz functions, derivatives and polynomial
  multipliers, tempered distributions and deltas, Fourier transforms,
  `fourier_delta_zero`, affine Schwartz precomposition, and Schwartz
  integration. Final warning-as-error builds compile the implemented inverse-
  Fourier identity, plane-wave obstructions, common-domain commutator, affine-
  line distribution, and both algebraic correlation relations.
- The pinned tree does not supply a ready concrete self-adjoint position/
  momentum pair, spectral PVM calculus, or continuous projective-conditioning
  semantics. The existing finite `PureState`, `DensityState`, and
  `PerfectConditionalPrediction` APIs therefore cannot honestly receive the
  paper's ideal objects.

## Updated Assumptions

- A rigorous generalized-state treatment is feasible and proportionate for a
  stable fragment; Stage 9 need not settle the entire rigged-Hilbert-space or
  spectral-measure program to record meaningful checked results.
- The analytic leaf remains independent of the finite quantum and EPR logic
  modules. It builds directly without being imported by the thin public `EPR`
  root during this stage.
- Plane waves are ordinary complex-valued functions only for pointwise and
  integrability statements. They are never wrapped as normalized project
  states.
- Delta and affine-line correlations live in tempered distributions.
  Their displayed integrals are distributional pairings, not pointwise or
  Bochner `L²` integrals.
- Position and momentum act on `𝓢(ℝ, ℂ)`, making the common invariant domain
  explicit. No everywhere-defined bounded-operator claim on `L²` is made.
- Both affine-line correlation relations are within scope and now have checked
  direct proofs. The paper-specific raw scaled Fourier-integral identity,
  self-adjoint closures/spectra, topological-support/non-`L²` classification of
  the affine-line distribution, and conditional measurement semantics remain
  precise future obligations.
- Normalized Gaussian or box regularizations would change exact correlations
  into finite-resolution/high-probability claims. Stage 9 documents that
  boundary rather than silently using the exact EPR reality criterion on an
  approximation.

## Big Picture Objective

- Give the original position-momentum construction the strongest rigorous
  status supported by the pinned library: formalize its stable generalized-
  state and common-domain fragment, prove its false-normalization obstructions,
  and state exactly what remains before it could support continuous
  conditional-probability or EPR-reality reasoning.

## Detailed Implementation Plan

- Add an independent continuum module containing:
  - constant-modulus plane waves and proofs that they are neither `L²` nor
    integrable over the real line;
  - Eq. (6)'s exact interval mass as an explicitly unnormalized quantity;
  - the inverse-Fourier volume/delta identity available in pinned mathlib;
  - position and momentum maps on Schwartz space and the exact Eq. (18)
    commutator there;
  - the delta generalized position-eigenrelation;
  - the affine-line tempered distribution representing Eq. (9), its pairing
    formula, its relative-position relation, and its total-momentum-zero
    relation.
- Add a private continuum audit module with executable/symbolic sentinels that
  Eq. (6) can exceed one, both momentum-sign plane waves are non-`L²`, and the
  checked generalized identities have the intended signatures.
- Add a private axiom/signature leaf covering every substantive continuum
  declaration.
- Keep continuum imports out of every finite core, example, no-signalling, and
  logic module. Decide whether to re-export the analytic leaf only in Stage 10,
  after the whole public API audit.
- Update `docs/PaperMap.md`, `docs/Corrections.md`, and
  `docs/Dependencies.md` with exact equation meanings, normalization/domain
  limits, checked declarations, pinned APIs, and remaining obligations.
- Fold tested outcomes and exact verification evidence back into this file and
  `goal-1/0-plan.md` without beginning Stage 10.

## No-Cheating Checks

- Scan completed Lean modules for `sorry`, `admit`, `sorryAx`, project
  `axiom`, `opaque`, `unsafe`, `partial def`, and `implemented_by`.
- Confirm the continuum implementation imports no `EPR.Quantum`,
  `EPR.Examples`, or `EPR.Logic` module and no finite module imports continuum.
- Confirm no continuum declaration has result type `PureState`, `DensityState`,
  `BipartiteState`, `PerfectConditionalPrediction`, `CertainPrediction`, or
  `ElementOfReality`.
- Inspect theorem signatures for explicit Schwartz domains and distribution
  codomains; reject any claim that the Eq. (9) object is in `L²(ℝ × ℝ)`.
- Keep every audit/axiom module outside the public `EPR` import chain.
- Check the Eq. (6) diagnostic produces a value greater than one, so its name
  and use cannot masquerade as a normalized probability.
- Record any unproved raw scaled-Fourier-integral, support/non-`L²`, spectral,
  or conditional-semantics claim as an obligation rather than an axiom.
- Run warning-as-error focused builds, the default public-root build, an
  explicit combined Stage 9 target build, source/import/signature scans,
  whitespace checks, and an autosave-history diff review.

## Completion Requirements

- Every implemented paper equation has the appropriate function,
  distribution, or Schwartz-domain type and all required scale/domain
  hypotheses.
- Plane waves are proved non-`L²`; Eq. (6) is named and checked only as
  unnormalized interval mass; no delta is a normalized project state.
- The affine-line distribution and its relative-position and total-momentum-
  zero relations compile, and Eq. (18) compiles on Schwartz space with the
  paper's sign.
- The documentation maps Eqs. (2), (6), and (9)--(18) individually enough to
  distinguish checked results from source interpretation and open obligations.
- The finite Bell/Pauli EPR result remains unchanged and independent; no exact
  continuous `PerfectConditionalPrediction` or reality-criterion instance is
  claimed.
- Focused implementation/audit/axiom builds, public-root and explicit combined
  Stage 9 builds, warning-as-error builds, proof-hole/project-axiom/forbidden-
  shortcut/import scans, `git diff --check`, and axiom audits pass with exact
  evidence recorded.

## Stage Results

**Status:** Complete on 2026-07-17.

### Source and representation audit

- Direct comparison of the facsimile and transcription found no sign,
  variable, or Fourier-factor error in Eqs. (2), (6), and (9)--(18). The
  positive Fourier kernel is an inverse-Fourier kernel. For the paper's
  physical `h > 0`, the audited Eq. (9) target is
  `h δ(x₁-x₂+x₀)`; an arbitrary nonzero real scale would contribute `|h|`.
- The chosen representation is a separate generalized-state leaf:
  ordinary functions only for pointwise norm/integrability calculations,
  tempered distributions for plane-wave/delta/correlation equations, and
  Schwartz endomorphisms for the common-domain commutator.
- Pinned mathlib has the exact Schwartz, tempered-distribution, Fourier,
  multiplier, derivative, affine-composition, and integration primitives used
  below. It has generic partially defined linear maps but no ready concrete
  self-adjoint position/momentum pair, spectral PVM layer, unbounded spectral
  theorem, partial Fourier transform/kernel theorem, or continuous projective-
  conditioning API.

### Implemented generalized-state and domain layer

- `EPR.Continuum.Idealized` imports only
  `Mathlib.Analysis.Distribution.TemperedDistribution` and adds no dependency
  on any finite quantum, example, no-signalling, or logic module.
- `planeWave_norm`, `planeWave_not_memLp_two`, and
  `planeWave_not_integrable` check the constant-modulus function and exclude
  normalized `L²(ℝ)` or ordinary integrable-state readings of Eq. (2).
  `unnormalizedIntervalWeight_eq` proves Eq. (6)'s `b-a` calculation without
  naming it a probability.
- `fourierInv_volume_eq_delta_zero` checks the pinned Fourier convention.
  `generalizedPlaneWave = 𝓕⁻δ` and `generalizedPlaneWave_apply` identify its
  positive-phase pairing. `deriv_generalizedPlaneWave`,
  `eprMomentumMode_eigenrelation`, and
  `eprShiftedOppositeMomentumMode_eigenrelation` prove the derivative, `+p`,
  and shifted `-p` operator equations; source-facing ratio claims require
  `h ≠ 0`.
- `positionSchwartz` and `momentumSchwartz` are endomorphisms of the explicitly
  named common invariant domain `𝓢(ℝ,ℂ)`.
  `momentum_position_commutator` proves Eq. (18) with the paper's exact sign,
  `[P,Q]f = (h/(2πi))f`, only on that domain.
- `affineLineDelta` pairs a two-variable Schwartz test as
  `∫t, f(t,t+x₀)`, and `eprCorrelation` applies the source factor `h`.
  `eprCorrelation_relativePosition` proves the algebraic relation
  `(Q₂-Q₁)Ψ=x₀Ψ`. A direct chain-rule/Fourier-at-zero argument proves affine-
  line tangent invariance and then
  `eprCorrelation_jointMomentumSum : (P₁+P₂)Ψ=0`.
- These correlation theorems are algebraic distribution equations. The module
  explicitly notes that `eprCorrelation 0 x₀ = 0`; no theorem here proves
  nonzeroness, topological support, or lack of an `L²` regular representative
  for the affine-line distribution.

### Diagnostics and trust boundary

- `EPR.Audit.Continuum` checks the concrete Eq. (6) value two on `[0,2]` and
  its strict excess over one, both non-`L²` paper frequencies with `h ≠ 0`,
  concrete `+3` and `-3` mode equations, a delta position relation, the affine-
  line pairing, both correlation equations at nonzero scale two, and Eq. (18)
  at the same scale.
- `EPR.Audit.ContinuumAxioms` contains 50 `#check` commands and 35
  `#print axioms` commands. Every printed theorem reports exactly
  `[propext, Classical.choice, Quot.sound]`; no project-specific axiom occurs.
- The public `EPR` root remains byte-for-byte unchanged from the Stage 9
  baseline. Neither audit leaf is public, no finite module imports continuum,
  and the continuum implementation imports no finite or interpretative layer.
  Stage 10 owns the final decision whether the analytic leaf should be
  re-exported.
- `docs/PaperMap.md` now maps Eqs. (2), (6), and (9)--(18) at equation-group
  granularity. `docs/Corrections.md` marks C-001, C-002, C-007, and C-008 with
  checked Stage 9 status and adds C-011 for the generalized-state versus Born-
  branch boundary. `docs/Dependencies.md` records the exact pinned surface,
  module direction, and missing infrastructure.

### Verification evidence

All commands below were run from `formal/` unless stated otherwise:

```text
lake build -KwarningAsError=true EPR.Continuum.Idealized
  -> success, 3072 jobs
lake build -KwarningAsError=true EPR.Audit.Continuum
  -> success, 3600 jobs
lake build -KwarningAsError=true EPR.Audit.ContinuumAxioms
  -> success, 3601 jobs; all 35 axiom prints have the standard footprint
lake build -KwarningAsError=true EPR
  -> success, 3210 jobs
lake build -KwarningAsError=true EPR EPR.Continuum.Idealized \
  EPR.Audit.Continuum EPR.Audit.ContinuumAxioms
  -> success, 3616 jobs
lake build
  -> success, 3210 jobs
```

The default target is only `EPR`, which intentionally does not import the
continuum branch. The explicit 3616-job command is therefore the Stage 9-wide
build; the plain default build is retained as the public regression check.

The following negative scans all returned no output with exit status 1:

```text
rg -n '\b(sorry|admit|sorryAx)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe|partial[[:space:]]+def)[[:space:]]|implemented_by' EPR EPR.lean
rg -n '\b(PureState|DensityState|BipartiteState|SubnormalizedState|PerfectConditionalPrediction|CertainPrediction|ElementOfReality|RealityCriterion|OutcomeObtained|NoOnticDisturbance|CounterfactualStability|CompleteFor)\b' EPR/Continuum EPR/Audit/Continuum.lean EPR/Audit/ContinuumAxioms.lean
rg -n '^(public )?import EPR\.(Continuum|Audit\.Continuum)' EPR.lean EPR/Foundations.lean EPR/Quantum EPR/Examples EPR/Logic -g '*.lean'
rg -n '^(public )?import EPR\.(Quantum|Examples|Logic|Foundations)' EPR/Continuum EPR/Audit/Continuum.lean EPR/Audit/ContinuumAxioms.lean -g '*.lean'
rg -n 'EPR\.Audit' EPR.lean
```

From the repository root:

```text
git diff --exit-code 087f622 -- formal/EPR.lean formal/EPR/Foundations.lean \
  formal/EPR/Quantum formal/EPR/Examples formal/EPR/Logic
  -> success; the finite/public tree is unchanged
git diff --check 087f622
  -> success
git diff --name-only 087f622
  -> exactly the three Stage 9 Lean files, three living docs, master plan,
     and this stage record
git status --short --branch
  -> clean autosave-managed `master...origin/master`
```

### Failures and corrections during implementation

- Direct `fun_prop` automation did not establish temperate growth of the
  complex exponential. Defining `generalizedPlaneWave` as `𝓕⁻δ` instead gave
  a shorter checked construction and fixed the Fourier sign by definition.
- The first commutator product-rule proof encountered duplicate real/complex
  scalar-instance terms. Expressing position as real scalar multiplication on
  the Schwartz function produced a stable derivative proof.
- Automation did not recognize raw product projections as temperate-growth
  functions. Packaging the relative coordinate as a continuous real-linear
  map and the affine embedding as a diagonal continuous linear map plus a
  constant resolved the instance boundary.
- The initial scope left total momentum zero as a documented obligation.
  A later direct proof used restriction-chain differentiation and the fact that
  a Schwartz derivative integrates to zero, so both correlation equations are
  now checked.
- Independent reviews caught totalized division at `h = 0` in the first paper-
  named diagnostics and wording that could conflate an operator equation with
  a proved nonzero eigen-distribution. The diagnostics now require `h ≠ 0`,
  use nonzero concrete correlation scales, and the code/docs explicitly record
  the remaining nonzeroness/support/non-`L²` gap.
- The default Lake build was discovered to cover only the finite public root.
  Completion therefore uses the explicit combined target command above.

### Remaining analytic obligations

- Prove in Lean that the paper's raw oscillatory momentum integral, understood
  distributionally and with `h > 0`, equals `h • affineLineDelta x₀`. This
  needs an explicit scaled partial-Fourier/change-of-variables construction;
  no ordinary convergent integral claim is acceptable.
- If stronger classification is needed, prove `affineLineDelta` nonzero, prove
  its topological support, and exclude an `L²` regular representative.
- Construct concrete self-adjoint position/momentum realizations, maximal
  domains, and spectral PVMs before assigning continuous Born measures.
- Develop measurable continuous-outcome conditioning before claiming a
  positive-probability exact branch. A normalized Gaussian/box approximation
  would instead need finite-resolution error bounds and a separately stated
  approximate or limiting reality premise.

Stage 10 is the first incomplete stage. No Stage 10 implementation or public-
API decision was begun in this turn.
