module

public import EPR.Quantum.Conditional
public import Mathlib.Tactic

/-!
# Conditional-state diagnostics

These executable checks cover a proper rank-two projection on `Fin 3`, a
nonzero but zero-probability branch, a complete two-outcome measurement,
nonselective dephasing, global phase, and one nonmaximally correlated
bipartite example. They contain no Bell/Pauli setting, perfect-prediction
package, no-signalling theorem, or interpretative premise.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Audit.Conditional

open EPR EPR.Quantum

/-- A normalized computational-basis state for a finite basis. -/
def basisState {n : Type*} [Fintype n] [DecidableEq n] (i : n) : PureState n where
  ket := Pi.single i 1
  normalized := by
    rw [single_one_dotProduct]
    simp

/-! ## A proper degenerate measurement on `Fin 3` -/

abbrev Three := Fin 3
abbrev TwoOutcomes := Fin 2

def rankTwoMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i = 2 then 0 else 1

def lastMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i = 2 then 1 else 0

def rankTwoProjection : Projection Three where
  matrix := rankTwoMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [rankTwoMatrix, Matrix.diagonal, Matrix.conjTranspose]
  idempotent := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [rankTwoMatrix, Matrix.mul_apply, Matrix.diagonal]

def lastProjection : Projection Three where
  matrix := lastMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [lastMatrix, Matrix.diagonal, Matrix.conjTranspose]
  idempotent := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [lastMatrix, Matrix.mul_apply, Matrix.diagonal]

theorem rankTwoProjection_nonzero : rankTwoProjection.matrix ≠ 0 := by
  intro h
  have h00 := congrFun (congrFun h (0 : Three)) (0 : Three)
  norm_num [rankTwoProjection, rankTwoMatrix, Matrix.diagonal] at h00

theorem lastProjection_nonzero : lastProjection.matrix ≠ 0 := by
  intro h
  have h22 := congrFun (congrFun h (2 : Three)) (2 : Three)
  norm_num [lastProjection, lastMatrix, Matrix.diagonal] at h22

theorem rankTwoProjection_ne_identity :
    rankTwoProjection.matrix ≠ (1 : Operator Three) := by
  intro h
  have h22 := congrFun (congrFun h (2 : Three)) (2 : Three)
  norm_num [rankTwoProjection, rankTwoMatrix, Matrix.diagonal,
    Matrix.one_apply] at h22

theorem rankTwo_supports_two_basis_vectors :
    rankTwoProjection.matrix *ᵥ (Pi.single (0 : Three) 1) = Pi.single 0 1 ∧
      rankTwoProjection.matrix *ᵥ (Pi.single (1 : Three) 1) = Pi.single 1 1 := by
  constructor <;> funext i <;> fin_cases i <;>
    simp [rankTwoProjection, rankTwoMatrix, Matrix.mulVec, dotProduct,
      Matrix.diagonal]

def degenerateMeasurement : ProjectiveMeasurement TwoOutcomes Three where
  projector := fun w ↦ if w = 0 then rankTwoProjection else lastProjection
  nonzero := by
    intro w
    fin_cases w
    · simpa using rankTwoProjection_nonzero
    · simpa using lastProjection_nonzero
  orthogonal := by
    intro w v h
    fin_cases w <;> fin_cases v
    · exact (h rfl).elim
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [rankTwoProjection, lastProjection, rankTwoMatrix, lastMatrix,
          Matrix.mul_apply, Matrix.diagonal]
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [rankTwoProjection, lastProjection, rankTwoMatrix, lastMatrix,
          Matrix.mul_apply, Matrix.diagonal]
    · exact (h rfl).elim
  complete := by
    rw [Fin.sum_univ_two]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [rankTwoProjection, lastProjection, rankTwoMatrix, lastMatrix,
        Matrix.diagonal, Matrix.one_apply]

noncomputable def spanningKet : Ket Three :=
  fun i ↦
    if i = 0 then (1 / 3 : ℂ)
    else if i = 1 then (2 / 3 : ℂ)
    else (2 / 3 : ℂ)

noncomputable def spanningState : PureState Three where
  ket := spanningKet
  normalized := by
    norm_num [dotProduct, Fin.sum_univ_three, spanningKet,
      Complex.star_def, map_div₀, map_ofNat]

def state2 : PureState Three := basisState 2

theorem spanning_rankTwo_probability :
    outcomeProbability spanningState.toDensity rankTwoProjection = 5 / 9 := by
  norm_num [outcomeProbability, bornWeight, rankTwoProjection, rankTwoMatrix,
    spanningState, spanningKet, PureState.toDensity_matrix_apply,
    Matrix.mul_apply, Matrix.trace, Matrix.diagonal, Fin.sum_univ_three,
    Complex.star_def, map_div₀, map_ofNat]

theorem spanning_last_probability :
    outcomeProbability spanningState.toDensity lastProjection = 4 / 9 := by
  norm_num [outcomeProbability, bornWeight, lastProjection, lastMatrix,
    spanningState, spanningKet, PureState.toDensity_matrix_apply,
    Matrix.mul_apply, Matrix.trace, Matrix.diagonal, Fin.sum_univ_three,
    Complex.star_def, map_div₀, map_ofNat]

theorem state2_rankTwo_probability_zero :
    outcomeProbability state2.toDensity rankTwoProjection = 0 := by
  norm_num [outcomeProbability, bornWeight, rankTwoProjection, rankTwoMatrix,
    state2, basisState, PureState.toDensity_matrix_apply, Matrix.mul_apply,
    Matrix.trace, Matrix.diagonal, Fin.sum_univ_three, Matrix.single_apply]

theorem state2_rankTwo_branch_zero :
    ludersBranchMatrix state2.toDensity rankTwoProjection = 0 := by
  exact (outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero
    state2.toDensity rankTwoProjection).mp state2_rankTwo_probability_zero

theorem state2_rankTwo_not_positive :
    ¬ 0 < outcomeProbability state2.toDensity rankTwoProjection := by
  rw [state2_rankTwo_probability_zero]
  exact lt_irrefl 0

end EPR.Audit.Conditional
