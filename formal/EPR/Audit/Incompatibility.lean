module

public import EPR.Examples.PauliIncompatibility
public import Mathlib.Tactic

/-!
# Incompatibility diagnostics

This executable leaf checks the Pauli product order and all-state exclusion,
then constructs two Hermitian observables on `Fin 3` that do not commute but
share both a nonzero eigenvector and a jointly sharp pure density state. The
counterexample prevents bare noncommutation from being used as a generic
substitute for the stronger spectral obstruction.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Audit.Incompatibility

open EPR EPR.Quantum EPR.Examples.BellSteering
open EPR.Examples.PauliIncompatibility

noncomputable section

/-! ## Pauli product and state-space sentinels -/

/-- At entry `(0,1)`, `XZ` is `-1` while `ZX` is `1`. -/
theorem pauliXZ_product_entry :
    (pauliX.matrix * pauliZ.matrix) 0 1 = -1 ∧
      (pauliZ.matrix * pauliX.matrix) 0 1 = 1 := by
  constructor <;>
    norm_num [pauliX, pauliXMatrix, pauliZ, pauliZMatrix,
      Matrix.mul_apply, Matrix.diagonal, Fin.sum_univ_two]

/-- The public raw-ket theorem really excludes arbitrary values and vectors. -/
theorem pauliXZ_arbitrary_commonEigenvector_zero
    (v : QubitKet) (xValue zValue : ℝ)
    (hx : pauliX.IsEigenvector v xValue)
    (hz : pauliZ.IsEigenvector v zValue) :
    v = 0 :=
  pauliXZ_commonEigenvector_eq_zero v xValue zValue hx hz

/-- The public exclusion applies to every qubit density state, including mixed
states. -/
theorem pauliXZ_all_density_states (ρ : DensityState QubitIndex) :
    ¬ ρ.JointlySharp pauliX pauliZ :=
  pauliXZ_not_jointlySharp ρ

/-! ## A `Fin 3` counterexample to the bare-noncommutation inference -/

abbrev Three := Fin 3

/-- The Hermitian diagonal matrix `diag(0,1,2)`. -/
def fin3AMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ (i.val : ℂ)

/-- A Hermitian Pauli-X block on `span {e₁,e₂}`, with `e₀` fixed at zero. -/
def fin3BMatrix : Operator Three :=
  Matrix.single 1 2 1 + Matrix.single 2 1 1

def fin3A : Observable Three where
  matrix := fin3AMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [fin3AMatrix, Matrix.diagonal, Matrix.conjTranspose,
        starRingEnd_apply]

def fin3B : Observable Three where
  matrix := fin3BMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      norm_num [fin3BMatrix, Matrix.single_apply, Matrix.conjTranspose]

/-- The unequal `(1,2)` product entries make the counterexample's
noncommutation executable. -/
theorem fin3_product_entry :
    (fin3A.matrix * fin3B.matrix) 1 2 = 1 ∧
      (fin3B.matrix * fin3A.matrix) 1 2 = 2 := by
  constructor <;>
    norm_num [fin3A, fin3AMatrix, fin3B, fin3BMatrix, Matrix.diagonal,
      Matrix.single_apply, Matrix.mul_apply, Fin.sum_univ_three]
  all_goals decide

theorem fin3_noncommutes : fin3A.Noncommutes fin3B := by
  change fin3A.matrix * fin3B.matrix ≠ fin3B.matrix * fin3A.matrix
  intro h
  have h12 := congrFun (congrFun h (1 : Three)) (2 : Three)
  rw [fin3_product_entry.1, fin3_product_entry.2] at h12
  norm_num at h12

/-- The shared normalized state `e₀`. -/
def fin3SharedState : PureState Three where
  ket := Pi.single 0 1
  normalized := by
    rw [single_one_dotProduct]
    simp

theorem fin3SharedState_eigen_A :
    fin3SharedState.IsEigenstate fin3A 0 := by
  funext i
  fin_cases i <;>
    norm_num [PureState.IsEigenstate, fin3SharedState, fin3A,
      fin3AMatrix, Matrix.diagonal, Matrix.mulVec, dotProduct,
      Fin.sum_univ_three, Pi.single_apply]

theorem fin3SharedState_eigen_B :
    fin3SharedState.IsEigenstate fin3B 0 := by
  funext i
  fin_cases i <;>
    norm_num [PureState.IsEigenstate, fin3SharedState, fin3B,
      fin3BMatrix, Matrix.single_apply, Matrix.mulVec, dotProduct,
      Fin.sum_univ_three, Pi.single_apply]
  all_goals decide

theorem fin3_hasCommonEigenvector :
    fin3A.HasCommonEigenvector fin3B :=
  ⟨fin3SharedState.ket, fin3SharedState.ne_zero, 0, 0,
    fin3SharedState_eigen_A, fin3SharedState_eigen_B⟩

theorem fin3_pureDensity_jointlySharp :
    fin3SharedState.toDensity.JointlySharp fin3A fin3B :=
  ⟨0, 0,
    PureState.toDensity_sharpValue fin3SharedState_eigen_A,
    PureState.toDensity_sharpValue fin3SharedState_eigen_B⟩

theorem fin3_hasJointSharpState :
    fin3A.HasJointSharpState fin3B :=
  ⟨fin3SharedState.toDensity, fin3_pureDensity_jointlySharp⟩

/-- A checked counterexample: noncommutation coexists with a common nonzero
eigenvector and a jointly sharp density state in dimension three. -/
theorem fin3_noncommuting_with_common_sharp_state :
    fin3A.Noncommutes fin3B ∧
      fin3A.HasCommonEigenvector fin3B ∧
      fin3A.HasJointSharpState fin3B :=
  ⟨fin3_noncommutes, fin3_hasCommonEigenvector, fin3_hasJointSharpState⟩

end


end EPR.Audit.Incompatibility
