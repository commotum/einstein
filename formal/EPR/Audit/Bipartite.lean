module

public import EPR.Quantum.Bipartite
public import Mathlib.Tactic

/-!
# Bipartite-layer diagnostics

These checks deliberately use a heterogeneous `Fin 2 × Fin 3` system to make
subsystem swaps visible.  The final two-qubit example uses rational amplitudes
and includes a proof of non-productness; it is only a generic entanglement
sanity check, not the Bell steering example reserved for Stage 5.
-/

open scoped ComplexOrder Kronecker Matrix

@[expose] public section

namespace EPR.Audit.Bipartite

open EPR EPR.Quantum

/-- A normalized computational-basis state for a finite basis. -/
def basisState {n : Type*} [Fintype n] [DecidableEq n] (i : n) : PureState n where
  ket := Pi.single i 1
  normalized := by
    rw [single_one_dotProduct]
    simp

abbrev AIndex := Fin 2
abbrev BIndex := Fin 3

def stateA0 : PureState AIndex := basisState 0
def stateB2 : PureState BIndex := basisState 2

def productState23 : BipartitePureState AIndex BIndex := stateA0.tensor stateB2

example : reducedA productState23.toDensity = stateA0.toDensity := by
  change reducedA ((stateA0.tensor stateB2).toDensity) = stateA0.toDensity
  rw [PureState.toDensity_tensor, reducedA_tensor]

example : reducedB productState23.toDensity = stateB2.toDensity := by
  change reducedB ((stateA0.tensor stateB2).toDensity) = stateB2.toDensity
  rw [PureState.toDensity_tensor, reducedB_tensor]

/-! The asymmetric matrix-unit checks catch swapped trace conventions. -/

def offDiagonal : Operator (BipartiteIndex AIndex BIndex) :=
  Matrix.single ((0 : AIndex), (1 : BIndex)) ((0 : AIndex), (2 : BIndex)) 1

example : traceOutA offDiagonal =
    Matrix.single (1 : BIndex) (2 : BIndex) 1 := by
  ext k l
  fin_cases k <;> fin_cases l <;>
    simp [traceOutA_apply, offDiagonal, Matrix.single_apply]

example : traceOutB offDiagonal = 0 := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    simp [traceOutB_apply, offDiagonal, Matrix.single_apply]

example : traceOutA (1 : Operator (BipartiteIndex AIndex BIndex)) =
    (2 : ℂ) • (1 : Operator BIndex) := by
  rw [← Matrix.one_kronecker_one, traceOutA_kronecker]
  norm_num [Matrix.trace, Fin.sum_univ_two]

/-! Tagged local actions are checked independently on unequal factors. -/

def ketA0 : Ket AIndex := Pi.single 0 1
def ketA1 : Ket AIndex := Pi.single 1 1
def ketB0 : Ket BIndex := Pi.single 0 1
def ketB1 : Ket BIndex := Pi.single 1 1

def raiseA : LocalOperatorA AIndex BIndex where
  operator := Matrix.single 1 0 1

def raiseB : LocalOperatorB AIndex BIndex where
  operator := Matrix.single 1 0 1

theorem raiseA_action :
    raiseA.lift *ᵥ tensorKet ketA0 ketB0 = tensorKet ketA1 ketB0 := by
  rw [LocalOperatorA.lift_mul_tensorKet]
  congr 1
  funext i
  fin_cases i <;>
    simp [raiseA, ketA0, ketA1, Matrix.mulVec, dotProduct,
      Matrix.single_apply]

theorem raiseB_action :
    raiseB.lift *ᵥ tensorKet ketA0 ketB0 = tensorKet ketA0 ketB1 := by
  rw [LocalOperatorB.lift_mul_tensorKet]
  congr 1
  funext k
  fin_cases k <;>
    simp [raiseB, ketB0, ketB1, Matrix.mulVec, dotProduct,
      Matrix.single_apply]

example : raiseA.lift * raiseB.lift = raiseB.lift * raiseA.lift :=
  localA_commute_localB raiseA raiseB

/-! A normalized pure state proved not to be any raw tensor product. -/

noncomputable def rationalEntangledKet : Ket (BipartiteIndex AIndex AIndex) :=
  fun p ↦
    if p = ((0 : AIndex), (0 : AIndex)) then (3 / 5 : ℂ)
    else if p = ((1 : AIndex), (1 : AIndex)) then (4 / 5 : ℂ)
    else 0

noncomputable def rationalEntangledState : BipartitePureState AIndex AIndex where
  ket := rationalEntangledKet
  normalized := by
    norm_num [dotProduct, Fintype.sum_prod_type, Fin.sum_univ_two,
      rationalEntangledKet, Complex.star_def, map_div₀, map_ofNat]

theorem tensorKet_cross_amplitudes (ψ φ : Ket AIndex) :
    tensorKet ψ φ (0, 0) * tensorKet ψ φ (1, 1) =
      tensorKet ψ φ (0, 1) * tensorKet ψ φ (1, 0) := by
  simp [tensorKet]
  ring

/-- The rational-amplitude sanity state is not a product of any raw kets. -/
theorem rationalEntangledState_not_product :
    ¬ ∃ ψ φ : Ket AIndex, rationalEntangledKet = tensorKet ψ φ := by
  rintro ⟨ψ, φ, h⟩
  have hc := tensorKet_cross_amplitudes ψ φ
  have h00 := congrFun h ((0 : AIndex), (0 : AIndex))
  have h11 := congrFun h ((1 : AIndex), (1 : AIndex))
  have h01 := congrFun h ((0 : AIndex), (1 : AIndex))
  have h10 := congrFun h ((1 : AIndex), (0 : AIndex))
  rw [← h00, ← h11, ← h01, ← h10] at hc
  norm_num [rationalEntangledKet] at hc

noncomputable def rationalMarginal : Operator AIndex :=
  Matrix.diagonal fun i ↦ if i = 0 then (9 / 25 : ℂ) else (16 / 25 : ℂ)

example : (reducedA rationalEntangledState.toDensity).matrix = rationalMarginal := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [reducedA_matrix, traceOutB_apply, PureState.toDensity_matrix_apply,
      rationalEntangledState, rationalEntangledKet, rationalMarginal, Matrix.diagonal,
      Matrix.vecMulVec_apply, Complex.star_def, map_div₀, map_ofNat]

example : (reducedB rationalEntangledState.toDensity).matrix = rationalMarginal := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [reducedB_matrix, traceOutA_apply, PureState.toDensity_matrix_apply,
      rationalEntangledState, rationalEntangledKet, rationalMarginal, Matrix.diagonal,
      Matrix.vecMulVec_apply, Complex.star_def, map_div₀, map_ofNat]

end EPR.Audit.Bipartite
