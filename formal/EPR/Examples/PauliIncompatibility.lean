module

public import EPR.Quantum.Incompatibility
public import EPR.Examples.BellSteering
import Mathlib.Tactic

/-!
# Exact Pauli-X/Pauli-Z incompatibility

This module proves three separate properties of the Pauli observables used by
the finite Bell-steering example:

* their matrices do not commute;
* no nonzero raw qubit ket is an eigenvector of both; and
* no pure or mixed qubit density state is sharp for both.

The mixed-state exclusion is derived from the no-common-eigenvector theorem
through the generic density-column bridge. It is not inferred from bare
noncommutation. These are mathematical state-space facts only; no
interpretative conclusion is drawn.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Examples.PauliIncompatibility

open EPR EPR.Quantum EPR.Examples.BellSteering

/-! ## Matrix noncommutation -/

/-- Pauli `X` and `Z` do not commute as matrices. -/
theorem pauliXZ_noncommutes : pauliX.Noncommutes pauliZ := by
  change pauliX.matrix * pauliZ.matrix ≠ pauliZ.matrix * pauliX.matrix
  intro h
  have h01 := congrFun (congrFun h (0 : QubitIndex)) (1 : QubitIndex)
  norm_num [pauliX, pauliXMatrix, pauliZ, pauliZMatrix,
    Matrix.mul_apply, Matrix.diagonal, Fin.sum_univ_two] at h01

/-! ## Common-eigenvector exclusion -/

/-- Any raw ket satisfying both Pauli eigenvalue equations, for arbitrary real
eigenvalues, is the zero ket. -/
theorem pauliXZ_commonEigenvector_eq_zero
    (v : QubitKet) (xValue zValue : ℝ)
    (hx : pauliX.IsEigenvector v xValue)
    (hz : pauliZ.IsEigenvector v zValue) :
    v = 0 := by
  unfold Observable.IsEigenvector at hx hz
  have hz0 := congrFun hz (0 : QubitIndex)
  have hz1 := congrFun hz (1 : QubitIndex)
  have hx0 := congrFun hx (0 : QubitIndex)
  have hx1 := congrFun hx (1 : QubitIndex)
  norm_num [pauliZ, pauliZMatrix, pauliX, pauliXMatrix,
    Matrix.mulVec, dotProduct, Matrix.diagonal, Fin.sum_univ_two]
    at hz0 hz1 hx0 hx1
  by_cases hv0 : v 0 = 0
  · have hv1 : v 1 = 0 := by simpa [hv0] using hx0
    funext i
    fin_cases i
    · exact hv0
    · exact hv1
  · have hzv : (zValue : ℂ) = 1 := by
      apply mul_right_cancel₀ hv0
      simpa using hz0.symm
    have hv1 : v 1 = 0 := by
      rw [hzv] at hz1
      apply mul_left_cancel₀ (by norm_num : (2 : ℂ) ≠ 0)
      linear_combination -hz1
    have hxv : (xValue : ℂ) = 0 := by
      apply mul_right_cancel₀ hv0
      simpa [hv1] using hx0.symm
    rw [hxv, zero_mul] at hx1
    exact (hv0 hx1).elim

/-- There is no common nonzero raw eigenvector of Pauli `X` and `Z`. -/
theorem pauliXZ_noCommonEigenvector :
    pauliX.NoCommonEigenvector pauliZ := by
  rintro ⟨v, hv, xValue, zValue, hx, hz⟩
  exact hv (pauliXZ_commonEigenvector_eq_zero v xValue zValue hx hz)

/-! ## Pure-and-mixed joint-sharpness exclusion -/

/-- No qubit density state, pure or mixed, is sharp for both Pauli `X` and
Pauli `Z`. This uses the common-eigenvector bridge, not noncommutation. -/
theorem pauliXZ_noJointSharpState :
    pauliX.NoJointSharpState pauliZ :=
  Observable.noJointSharpState_of_noCommonEigenvector
    pauliXZ_noCommonEigenvector

/-- State-quantified form of the Pauli joint-sharpness exclusion. -/
theorem pauliXZ_not_jointlySharp (ρ : DensityState QubitIndex) :
    ¬ ρ.JointlySharp pauliX pauliZ := by
  intro h
  exact pauliXZ_noJointSharpState ⟨ρ, h⟩

end EPR.Examples.PauliIncompatibility
