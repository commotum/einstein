# EPR Audit and Correction Log

Each entry distinguishes the paper's wording from the strongest currently
identified correct reconstruction. Status `documented` means the issue has not
yet been formalized.

## C-001: Plane-wave normalization

- **Paper:** Eq. (2) is used as a particle wave function on the real line.
- **Correction:** The constant-modulus plane wave is not square-integrable and
  is not a normalized element of `L²(ℝ)`.
- **Formal consequence:** Treat it only as a generalized eigenfunction or use
  normalized approximants with explicit error statements.
- **Status:** Checked in Stage 9. `planeWave_not_memLp_two` and
  `planeWave_not_integrable` prove the obstruction on `ℝ`.
  `generalizedPlaneWave` instead constructs the positive-phase mode as the
  inverse Fourier transform of a Dirac delta, and
  `eprMomentumMode_eigenvalue` proves the paper's `p` eigenvalue only in
  tempered distributions with explicit `h ≠ 0`.

## C-002: Eq. (6) is not a normalized probability

- **Paper:** Integrating `|ψ|² = 1` from `a` to `b` gives `b-a`, described as a
  relative probability with all positions equally probable.
- **Correction:** There is no translation-invariant probability measure with
  constant density on all of `ℝ`; the displayed expression is not an ordinary
  Born probability for a normalized state.
- **Formal consequence:** Do not encode Eq. (6) as a probability distribution.
- **Status:** Checked in Stage 9. `unnormalizedIntervalWeight_eq` proves the
  displayed `b - a` calculation as an oriented interval integral, while
  `eq6_can_exceed_one` checks the concrete value two on `[0,2]`. The API names
  this an unnormalized weight and supplies no probability-state coercion.

## C-003: Noncommutation is not no-common-eigenstate in general

- **Paper:** Noncommuting operators are described as precluding simultaneous
  precise knowledge.
- **Correction:** Even finite-dimensional Hermitian observables can fail to
  commute while sharing a nonzero eigenvector and a jointly sharp density
  state. The required quantum-state obstruction is no jointly sharp state for
  the selected pair, not bare noncommutation.
- **Formal consequence:** Keep `Noncommutes`, `HasCommonEigenvector`, and
  `HasJointSharpState` separate. For Pauli `X` and `Z`, establish
  noncommutation separately, prove no common nonzero eigenvector, derive
  `NoJointSharpState` through the checked mixed-state bridge, and use that last
  property in the final EPR bridge.
- **Status:** Checked in Stage 6. `pauliXZ_noncommutes`,
  `pauliXZ_noCommonEigenvector`, and `pauliXZ_noJointSharpState` establish the
  concrete Pauli facts. The Hermitian `Fin 3` witness
  `fin3_noncommuting_with_common_sharp_state` checks that noncommutation can
  coexist with both a common eigenvector and a jointly sharp rank-one density.
  Stage 8's `bellPhiPlus_noJointRepresentation_zx` invokes
  `pauliXZ_noJointSharpState`, rather than `pauliXZ_noncommutes`, for the final
  Bell/Pauli contradiction.

## C-004: Absence of interaction versus ontic no-disturbance

- **Paper:** Once the systems cease interacting, the paper identifies this
  with no real change in II caused by operations on I.
- **Correction:** No current interaction, operational no-signalling, and
  invariance of an underlying physical reality are distinct statements.
- **Formal consequence:** For a complete local projective Lüders measurement,
  sum the raw outcome-weighted branches and compare B's unconditioned reduced
  state, not a selected conditional state. Take ontic no-disturbance only as an
  explicit hypothesis.
- **Status:** The operational part is checked in Stage 7.
  `localA_nonselective_noSignalling` proves directional A-to-B reduced-state
  invariance generically, and `bellPhiPlus_operationalNoSignalling` checks both
  Bell/Pauli source settings. Stage 8 represents ontic stability separately as
  `NoOnticDisturbance`; it remains a hypothesis, not a theorem derived from
  either operational result. The audit theorem
  `operational_noSignalling_with_ontic_change` conjoins the checked Bell
  operational theorem with `¬ NoOnticDisturbance` for an explicitly changed
  toy Boolean reality, demonstrating logical coexistence rather than making an
  empirical ontological claim.

## C-005: Same-reality transport and counterfactual aggregation

- **Paper:** On printed p. 779, two conditional wave functions are assigned to
  the “same reality”; on printed p. 780, reality inferred under either remote
  measurement choice is treated as simultaneous reality for both quantities.
- **Correction:** Transporting two alternatives to one post-measurement reality
  and aggregating their context-specific elements and values are different
  moves. The first requires a common prior reality and ontic stability in both
  alternatives. The second requires a context-independence/counterfactual-
  stability premise.
- **Formal consequence:** Keep `SamePriorReality`, `NoOnticDisturbance`, and
  the derived `SamePostReality` separate from `CounterfactualStability`. The
  latter consumes `AlternativeContexts`, same post reality, both
  `ElementOfReality` judgments, and both `PossessesValue` judgments before it
  yields `SimultaneouslyReal`.
- **Status:** Checked conditionally in Stage 8.
  `samePostReality_of_noOnticDisturbance` performs only the same-reality
  transport; `simultaneous_reality_of_alternative_predictions` then uses the
  separately supplied `CounterfactualStability`. The audit theorem
  `counterfactualStability_rejectable` verifies that aggregation is not forced
  by the surrounding vocabulary.

## C-006: Counterparts do not imply joint exact representation

- **Paper:** Printed p. 777 requires every element of physical reality to have
  a counterpart in a complete theory. Printed p. 778 then says simultaneous
  definite values would enter a complete wave-function description and “would
  then be predictable.”
- **Correction:** The bare counterpart condition does not, without another
  premise, imply a readout of definite values, operational predictability, or
  simultaneous quantum sharpness.
- **Formal consequence:** `CompleteFor I theory r` yields only
  `TheoryCounterpart I theory q` from a context-indexed reality element.
  Supply `CompletenessRepresentationBridge I` separately to turn
  `SimultaneouslyReal` plus both counterparts into a value-specific
  `JointlyRepresents` judgment.
- **Status:** Checked conditionally in Stage 8. `theoryCounterpart_of_complete`
  exposes the bare completeness consequence, while
  `joint_representation_of_complete` requires the extra bridge. The audit
  theorems `completenessRepresentationBridge_rejectable` and
  `completeness_without_joint_representation` verify that neither joint
  representation nor its bridge is definitionally hidden in `CompleteFor`.

## C-007: Eq. (9) is distributional

- **Paper:** The integral in Eq. (9) is treated as a two-particle wave function.
- **Correction:** Under the stated Fourier convention it is formally
  exactly `h δ(x₁ - x₂ + x₀)` for the source's physical assumption `h > 0`
  and is not a normalized bipartite `L²(ℝ²)` vector. For arbitrary nonzero
  real `h`, delta scaling would contribute `|h|`. Eqs. (10)–(16) likewise use
  generalized eigenvectors and distributional expansions.
- **Formal consequence:** A rigorous literal treatment requires distributions,
  a rigged Hilbert space, or spectral measures and operator-domain control.
- **Status:** Partly checked and precisely bounded in Stage 9.
  `fourierInv_volume_eq_delta_zero` checks the underlying Fourier convention.
  `affineLineDelta` constructs the exact distribution
  `δ(x₁ - x₂ + x₀)` by integration along `x₂ = x₁ + x₀`, and
  `eprCorrelation` records its source-scaled `hδ` form.
  `eprCorrelation_relativePosition` proves
  `(Q₂-Q₁)Ψ = x₀Ψ`. The raw oscillatory `p`-integral-to-`hδ` equality, the
  companion `(P₁+P₂)Ψ = 0` relation, and continuous conditional-measurement
  semantics remain explicit extension obligations because pinned mathlib has
  no partial Fourier transform/kernel theorem or unbounded spectral PVM layer.

## C-008: Commutator domain

- **Paper:** Eq. (18) computes `[P,Q] = h/(2πi)`.
- **Correction:** The sign agrees with `P = -iℏ d/dx` and multiplication by
  `x`, but an operator identity for unbounded operators requires a specified
  common invariant domain.
- **Formal consequence:** Any continuous-variable theorem must state its domain.
- **Status:** Checked on the named common invariant Schwartz domain in Stage 9.
  `momentumSchwartz` and `positionSchwartz` are continuous endomorphisms of
  `𝓢(ℝ,ℂ)`, and `momentum_position_commutator` proves exactly
  `[P,Q]f = (h/(2πi))f` for every `f` in that domain. No claim of boundedness,
  maximal domain, closure, or self-adjointness on `L²` is made.

## C-009: Selected coefficient functions require normalization

- **Paper:** After an outcome in either expansion (7) or (8), the selected
  coefficient `ψₖ` or `φᵣ` is called the wave function of system II without an
  explicit normalization factor.
- **Correction:** For a normalized joint state expanded against an orthonormal
  basis on system I, the squared norm of a selected coefficient is its outcome
  probability and need not equal one.
- **Formal consequence:** Retain the coefficient as a raw subnormalized
  relative branch, require strictly positive branch probability, and only then
  form the normalized conditional state.
- **Status:** Checked generically in Stage 4 and concretely for all four
  probability-`1/2` Bell/Pauli branches in Stage 5.

## C-010: Conditional certainty is not actuality or value possession

- **Paper:** Printed p. 777 identifies certainty with probability one; printed
  p. 779 conditions the relative state on a source result being found; printed
  p. 780 moves from alternative certainty claims to elements and definite
  values of reality.
- **Correction:** A positive-probability branch with target conditional
  probability one does not assert that the source outcome occurred, that an
  element of reality exists, or that the target possesses the predicted value.
- **Formal consequence:** Keep `OutcomeObtained`, `CertainPrediction`,
  `ElementOfReality`, and `PossessesValue` distinct. `RealityCriterion`
  supplies only the element-of-reality implication from actuality, certainty,
  and `NoOnticDisturbance`; `RealityValueBridge` is a further implication to
  the specific possessed value.
- **Status:** Checked as explicit Stage 8 boundaries. In the Bell adapter,
  `BellPerfectPrediction` is supplied for every branch by the bundled
  `bellPhiPlusSteeringScenario`, while `bellCertainPrediction` still asserts no
  actuality. The audit theorems `certainty_does_not_assert_outcome`,
  `bell_prediction_does_not_assert_actuality`, `realityCriterion_rejectable`,
  and `realityValueBridge_rejectable` witness the separations.

## C-011: Generalized exact correlation is not a Born-probability branch

- **Paper:** The continuous expansions in Eqs. (11) and (15) are used to infer
  exact remote values after a continuous momentum or position result.
- **Correction:** Delta-normalized modes, Dirac position eigen-distributions,
  and the affine-line Eq. (9) object are not normalized Hilbert vectors.
  Distributional eigenrelations alone do not define positive-probability exact
  outcome branches or conditional density states for continuous observables.
- **Formal consequence:** Do not instantiate `PerfectConditionalPrediction`,
  `CertainPrediction`, or the exact reality criterion from the Stage 9
  distributions. A literal treatment needs self-adjoint operators, spectral
  PVMs, measurable conditioning/regular conditional probabilities, and an
  appropriate treatment of measure-zero sharp outcomes. A normalized
  approximation instead needs finite-resolution error bounds and a separately
  stated approximate or limiting reality premise.
- **Status:** Audited obstruction in Stage 9. The continuum module imports no
  finite quantum or logic module and exposes no project state, probability,
  conditioning, or reality declaration. The missing spectral and conditional
  infrastructure is recorded in `docs/Dependencies.md` and
  `goal-1/9-CONTINUUM.md` rather than postulated.
