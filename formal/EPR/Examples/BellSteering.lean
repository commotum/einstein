module

public import EPR.Quantum.Conditional
import Mathlib.Tactic

/-!
# A finite Bell-state steering example

This module fixes the ordered two-qubit state
`|Φ⁺⟩ = (|00⟩ + |11⟩) / √2` and the Pauli `Z` and `X` projective
measurements. It verifies selected A-side branch probabilities and conditional
B-side predictions for every setting and outcome.

Outcome indices label possible branches; no theorem asserts that an outcome
actually occurred. The results are operational conditional-state facts only.
They contain no no-signalling, ontic no-disturbance, reality, completeness,
counterfactual, incompatibility, or incompleteness claim.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Examples.BellSteering

open EPR EPR.Quantum

noncomputable section

/-- The two outcome labels. Index `0` means value `+1`; index `1` means
value `-1`. -/
abbrev Outcome := Fin 2

/-- The two alternative source measurement settings. -/
inductive Setting where
  | z
  | x
  deriving DecidableEq, Fintype

/-- The real positive amplitude `√2/2`. -/
def invSqrtTwoReal : ℝ :=
  Real.sqrt 2 / 2

/-- The amplitude `√2/2`, embedded in `ℂ`. -/
def invSqrtTwo : ℂ :=
  (invSqrtTwoReal : ℂ)

@[simp]
theorem invSqrtTwoReal_sq :
    invSqrtTwoReal * invSqrtTwoReal = (1 / 2 : ℝ) := by
  unfold invSqrtTwoReal
  nlinarith [Real.sq_sqrt (by norm_num : (0 : ℝ) ≤ 2)]

@[simp]
theorem star_invSqrtTwo : star invSqrtTwo = invSqrtTwo := by
  simp [invSqrtTwo]

@[simp]
theorem invSqrtTwo_sq : invSqrtTwo * invSqrtTwo = (1 / 2 : ℂ) := by
  rw [invSqrtTwo, ← Complex.ofReal_mul, invSqrtTwoReal_sq]
  norm_num

theorem invSqrtTwo_ne_zero : invSqrtTwo ≠ 0 := by
  intro h
  have hsq := invSqrtTwo_sq
  rw [h, zero_mul] at hsq
  norm_num at hsq

/-- The eigenvalue convention associated with an outcome label. -/
def outcomeValue (w : Outcome) : ℝ :=
  if w = 0 then 1 else -1

/-- Computational-basis ket `|0⟩` or `|1⟩`. -/
def zKet (w : Outcome) : QubitKet :=
  Pi.single w 1

/-- Normalized computational-basis state. -/
def zState (w : Outcome) : PureState QubitIndex where
  ket := zKet w
  normalized := by
    change Pi.single w 1 ⬝ᵥ star (Pi.single w 1) = 1
    rw [single_one_dotProduct]
    simp

/-- Pauli-X eigenket. Outcome `0` is `|+⟩`; outcome `1` is `|-⟩`. -/
def xKet (w : Outcome) : QubitKet :=
  fun i ↦ if i = 0 then invSqrtTwo
    else if w = 0 then invSqrtTwo else -invSqrtTwo

/-- Normalized Pauli-X eigenstate. -/
def xState (w : Outcome) : PureState QubitIndex where
  ket := xKet w
  normalized := by
    fin_cases w <;>
      simp [dotProduct, Fin.sum_univ_two, xKet, star_invSqrtTwo,
        invSqrtTwo_sq]

/-- The rank-one orthogonal projection associated with a qubit pure state. -/
def stateProjection (psi : PureState QubitIndex) : Projection QubitIndex where
  matrix := psi.toDensity.matrix
  isHermitian := psi.toDensity.isHermitian
  idempotent := by
    rw [PureState.toDensity_matrix, Matrix.vecMulVec_mul_vecMulVec,
      psi.star_dot_normalized, one_smul]

/-- Computational-basis projection for an outcome label. -/
def zProjection (w : Outcome) : Projection QubitIndex :=
  stateProjection (zState w)

/-- Pauli-X-basis projection for an outcome label. -/
def xProjection (w : Outcome) : Projection QubitIndex :=
  stateProjection (xState w)

/-- Pauli `Z = diag(1,-1)`. -/
def pauliZMatrix : QubitOperator :=
  Matrix.diagonal fun i ↦ if i = 0 then 1 else -1

/-- Pauli `Z` as a checked Hermitian observable. -/
def pauliZ : Observable QubitIndex where
  matrix := pauliZMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [pauliZMatrix, Matrix.diagonal, Matrix.conjTranspose]

/-- Pauli `X`, with zero diagonal and unit off-diagonal entries. -/
def pauliXMatrix : QubitOperator :=
  fun i j ↦ if i = j then 0 else 1

/-- Pauli `X` as a checked Hermitian observable. -/
def pauliX : Observable QubitIndex where
  matrix := pauliXMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [pauliXMatrix, Matrix.conjTranspose]

theorem zState_isEigenstate (w : Outcome) :
    (zState w).IsEigenstate pauliZ (outcomeValue w) := by
  fin_cases w <;>
    funext i <;> fin_cases i <;>
    norm_num [PureState.IsEigenstate, pauliZ, pauliZMatrix, zState, zKet,
      outcomeValue, Matrix.mulVec, dotProduct, Matrix.diagonal,
      Fin.sum_univ_two]

theorem xState_isEigenstate (w : Outcome) :
    (xState w).IsEigenstate pauliX (outcomeValue w) := by
  fin_cases w <;>
    funext i <;> fin_cases i <;>
    norm_num [PureState.IsEigenstate, pauliX, pauliXMatrix, xState, xKet,
      outcomeValue, Matrix.mulVec, dotProduct, Fin.sum_univ_two]

/-- Package a normalized eigenstate as its nonzero rank-one spectral
outcome. -/
def spectralOutcomeOfEigenstate (psi : PureState QubitIndex)
    (A : Observable QubitIndex) (a : ℝ) (h : psi.IsEigenstate A a) :
    ProjectiveOutcome A where
  value := a
  projector := stateProjection psi
  nonzero := psi.toDensity.ne_zero
  spectral := PureState.toDensity_sharpValue h

/-- Pauli-Z spectral outcome with the fixed value convention. -/
def pauliZOutcome (w : Outcome) : ProjectiveOutcome pauliZ :=
  spectralOutcomeOfEigenstate (zState w) pauliZ (outcomeValue w)
    (zState_isEigenstate w)

/-- Pauli-X spectral outcome with the fixed value convention. -/
def pauliXOutcome (w : Outcome) : ProjectiveOutcome pauliX :=
  spectralOutcomeOfEigenstate (xState w) pauliX (outcomeValue w)
    (xState_isEigenstate w)

@[simp]
theorem pauliZOutcome_projector (w : Outcome) :
    (pauliZOutcome w).projector = zProjection w :=
  rfl

@[simp]
theorem pauliXOutcome_projector (w : Outcome) :
    (pauliXOutcome w).projector = xProjection w :=
  rfl

/-- The complete computational-basis projective measurement. -/
def pauliZMeasurement : ProjectiveMeasurement Outcome QubitIndex where
  projector := zProjection
  nonzero := fun w ↦ (pauliZOutcome w).nonzero
  orthogonal := by
    intro w v hwv
    fin_cases w <;> fin_cases v
    · exact (hwv rfl).elim
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [zProjection, stateProjection, zState, zKet,
          PureState.toDensity_matrix_apply, Matrix.mul_apply,
          Matrix.vecMulVec_apply, Fin.sum_univ_two]
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [zProjection, stateProjection, zState, zKet,
          PureState.toDensity_matrix_apply, Matrix.mul_apply,
          Matrix.vecMulVec_apply, Fin.sum_univ_two]
    · exact (hwv rfl).elim
  complete := by
    rw [Fin.sum_univ_two]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [zProjection, stateProjection, zState, zKet,
        PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply]

/-- The complete Pauli-X-basis projective measurement. -/
def pauliXMeasurement : ProjectiveMeasurement Outcome QubitIndex where
  projector := xProjection
  nonzero := fun w ↦ (pauliXOutcome w).nonzero
  orthogonal := by
    intro w v hwv
    fin_cases w <;> fin_cases v
    · exact (hwv rfl).elim
    · ext i j
      fin_cases i <;> fin_cases j <;>
        norm_num [xProjection, stateProjection, xState, xKet,
          PureState.toDensity_matrix_apply, Matrix.mul_apply,
          Matrix.vecMulVec_apply, Fin.sum_univ_two, invSqrtTwo_sq]
    · ext i j
      fin_cases i <;> fin_cases j <;>
        norm_num [xProjection, stateProjection, xState, xKet,
          PureState.toDensity_matrix_apply, Matrix.mul_apply,
          Matrix.vecMulVec_apply, Fin.sum_univ_two, invSqrtTwo_sq]
    · exact (hwv rfl).elim
  complete := by
    rw [Fin.sum_univ_two]
    ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [xProjection, stateProjection, xState, xKet,
        PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply,
        invSqrtTwo_sq]

end

end EPR.Examples.BellSteering
