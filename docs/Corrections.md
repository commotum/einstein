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
- **Status:** Documented; Stage 9 obligation.

## C-002: Eq. (6) is not a normalized probability

- **Paper:** Integrating `|ψ|² = 1` from `a` to `b` gives `b-a`, described as a
  relative probability with all positions equally probable.
- **Correction:** There is no translation-invariant probability measure with
  constant density on all of `ℝ`; the displayed expression is not an ordinary
  Born probability for a normalized state.
- **Formal consequence:** Do not encode Eq. (6) as a probability distribution.
- **Status:** Documented; Stage 9 obligation.

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
  proportional to `h δ(x₁ - x₂ + x₀)` and is not a normalized bipartite
  `L²(ℝ²)` vector. Eqs. (10)–(16) likewise use generalized eigenvectors.
- **Formal consequence:** A rigorous literal treatment requires distributions,
  a rigged Hilbert space, or spectral measures and operator-domain control.
- **Status:** Documented; Stage 9 obligation.

## C-008: Commutator domain

- **Paper:** Eq. (18) computes `[P,Q] = h/(2πi)`.
- **Correction:** The sign agrees with `P = -iℏ d/dx` and multiplication by
  `x`, but an operator identity for unbounded operators requires a specified
  common invariant domain.
- **Formal consequence:** Any continuous-variable theorem must state its domain.
- **Status:** Documented; Stage 9 obligation.

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
