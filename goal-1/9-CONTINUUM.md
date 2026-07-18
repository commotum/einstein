# 9-CONTINUUM

## Current Facts

- Stage 9 is the first incomplete stage in `goal-1/0-plan.md`; Stages 1--8 and
  their evidence records are preserved, and Stage 10 has not begun.
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
  integration. Temporary warning-as-error probes compile for all planned core
  declarations, including an affine-line distribution and its exact
  relative-position relation.
- The pinned tree does not supply a ready concrete self-adjoint position/
  momentum pair, spectral PVM calculus, or continuous projective-conditioning
  semantics. The existing finite `PureState`, `DensityState`, and
  `PerfectConditionalPrediction` APIs therefore cannot honestly receive the
  paper's ideal objects.

## Updated Assumptions

- A rigorous generalized-state treatment is feasible and proportionate for a
  stable fragment; Stage 9 need not settle the entire rigged-Hilbert-space or
  spectral-measure program to record meaningful checked results.
- The analytic leaf must remain independent of the finite quantum and EPR
  logic modules. It may be buildable directly without being imported by the
  thin public `EPR` root during this stage.
- Plane waves will be ordinary complex-valued functions only for pointwise and
  integrability statements. They will never be wrapped as normalized project
  states.
- Delta and affine-line correlations will live in tempered distributions.
  Their displayed integrals are distributional pairings, not pointwise or
  Bochner `L²` integrals.
- Position and momentum will act on `𝓢(ℝ, ℂ)`, making the common invariant
  domain explicit. No everywhere-defined bounded-operator claim on `L²` will
  be made.
- Both affine-line correlation relations are within scope and now have checked
  direct proofs. The paper-specific raw scaled Fourier-integral identity,
  self-adjoint closures/spectra, topological-support/non-`L²` classification of
  the affine-line distribution, and conditional measurement semantics remain
  precise future obligations.
- Normalized Gaussian or box regularizations would change exact correlations
  into finite-resolution/high-probability claims. Stage 9 will document that
  boundary rather than silently use the exact EPR reality criterion on an
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

**Status:** In progress on 2026-07-17.

- Source comparison, pinned API inspection, baseline builds, initial scans, and
  temporary warning-as-error proof probes are complete.
- No Stage 9 project declaration has yet been added. The next action is to move
  the stable probe fragment into the independent continuum implementation and
  add its diagnostic leaves.
