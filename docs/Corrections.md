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
  Bell/Pauli source settings. The paper's page-779 claim that no interaction
  entails no real change remains a documented Stage 8 ontic obligation; it is
  not derived from either theorem.

## C-005: Counterfactual aggregation

- **Paper:** Reality inferred after either one of two alternative measurements
  is treated as simultaneous reality for both quantities.
- **Correction:** Combining conclusions from incompatible contexts requires a
  context-independence/counterfactual-stability premise.
- **Formal consequence:** Name this bridge and expose it in the main theorem's
  hypotheses.
- **Status:** Documented; Stage 8 obligation.

## C-006: Completeness-to-predictability bridge

- **Paper:** If the wave function were complete, real definite values would
  occur in the description and “would then be predictable.”
- **Correction:** The bare condition that every element of reality has a
  counterpart does not, without a definition, imply operational
  predictability or simultaneous quantum sharpness.
- **Formal consequence:** Define the representation/readout bridge separately
  rather than hiding it inside the proof.
- **Status:** Documented; Stage 8 obligation.

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
