module

public import EPR.Quantum.Core
public import Mathlib.Analysis.Matrix.Order

/-!
# Finite-dimensional bipartite systems

This module defines ordered bipartite states, tensor products, explicitly
tagged local operators and observables, finite partial traces, and reduced
density states.  Its local-action results are algebraic tensor-factor facts;
they are not operational no-signalling results and make no ontic locality or
no-disturbance claim.
-/

open scoped ComplexOrder Kronecker Matrix

@[expose] public section

namespace EPR.Quantum

variable {ι κ : Type*} [Fintype ι] [Fintype κ]

/-- A normalized pure state on the ordered bipartite basis `A × B`. -/
abbrev BipartitePureState (ι κ : Type*) [Fintype ι] [Fintype κ] :=
  PureState (BipartiteIndex ι κ)

/-- A density state on the ordered bipartite basis `A × B`. -/
abbrev BipartiteState (ι κ : Type*) [Fintype ι] [Fintype κ] :=
  DensityState (BipartiteIndex ι κ)

/-- The raw tensor product ket in explicit `A`-then-`B` basis order. -/
def tensorKet (ψ : Ket ι) (φ : Ket κ) : Ket (BipartiteIndex ι κ) :=
  fun ik ↦ ψ ik.1 * φ ik.2

@[simp]
theorem tensorKet_apply (ψ : Ket ι) (φ : Ket κ) (i : ι) (k : κ) :
    tensorKet ψ φ (i, k) = ψ i * φ k :=
  rfl

theorem tensorKet_dot_star (ψ : Ket ι) (φ : Ket κ) :
    tensorKet ψ φ ⬝ᵥ star (tensorKet ψ φ) =
      (ψ ⬝ᵥ star ψ) * (φ ⬝ᵥ star φ) := by
  simp [dotProduct, tensorKet, Fintype.sum_prod_type, Fintype.sum_mul_sum,
    mul_comm, mul_left_comm, mul_assoc]

namespace PureState

/-- The normalized product of two normalized pure states. -/
def tensor (ψ : PureState ι) (φ : PureState κ) : BipartitePureState ι κ where
  ket := tensorKet ψ.ket φ.ket
  normalized := by rw [tensorKet_dot_star, ψ.normalized, φ.normalized, one_mul]

@[simp]
theorem tensor_ket (ψ : PureState ι) (φ : PureState κ) :
    (ψ.tensor φ).ket = tensorKet ψ.ket φ.ket :=
  rfl

end PureState

namespace DensityState

/-- The product density state, with subsystem order `A × B`. -/
def tensor (ρ : DensityState ι) (σ : DensityState κ) : BipartiteState ι κ where
  matrix := ρ.matrix ⊗ₖ σ.matrix
  posSemidef := ρ.posSemidef.kronecker σ.posSemidef
  trace_one := by rw [Matrix.trace_kronecker, ρ.trace_one, σ.trace_one, one_mul]

@[simp]
theorem tensor_matrix (ρ : DensityState ι) (σ : DensityState κ) :
    (ρ.tensor σ).matrix = ρ.matrix ⊗ₖ σ.matrix :=
  rfl

end DensityState

/-- Outer products commute with the chosen tensor-ket/Kronecker convention. -/
theorem vecMulVec_tensorKet (ψ : Ket ι) (φ : Ket κ) :
    Matrix.vecMulVec (tensorKet ψ φ) (star (tensorKet ψ φ)) =
      Matrix.vecMulVec ψ (star ψ) ⊗ₖ Matrix.vecMulVec φ (star φ) := by
  ext ⟨i, k⟩ ⟨j, l⟩
  simp [tensorKet, Matrix.vecMulVec_apply, Matrix.kronecker_apply,
    mul_comm, mul_left_comm, mul_assoc]

namespace PureState

/-- Pure-to-density conversion respects tensor products. -/
theorem toDensity_tensor (ψ : PureState ι) (φ : PureState κ) :
    (ψ.tensor φ).toDensity = ψ.toDensity.tensor φ.toDensity := by
  apply DensityState.ext
  exact vecMulVec_tensorKet ψ.ket φ.ket

end PureState

/-! ## Finite partial traces and reduced states -/

/-- Trace out subsystem `A`, leaving an operator on subsystem `B`. -/
def traceOutA (M : Operator (BipartiteIndex ι κ)) : Operator κ :=
  ∑ i : ι, M.submatrix (fun k ↦ (i, k)) (fun k ↦ (i, k))

/-- Trace out subsystem `B`, leaving an operator on subsystem `A`. -/
def traceOutB (M : Operator (BipartiteIndex ι κ)) : Operator ι :=
  ∑ k : κ, M.submatrix (fun i ↦ (i, k)) (fun i ↦ (i, k))

@[simp]
theorem traceOutA_apply (M : Operator (BipartiteIndex ι κ)) (k l : κ) :
    traceOutA M k l = ∑ i : ι, M (i, k) (i, l) := by
  simp [traceOutA]

@[simp]
theorem traceOutB_apply (M : Operator (BipartiteIndex ι κ)) (i j : ι) :
    traceOutB M i j = ∑ k : κ, M (i, k) (j, k) := by
  simp [traceOutB]

theorem traceOutA_sum {τ : Type*} [Fintype τ]
    (f : τ → Operator (BipartiteIndex ι κ)) :
    traceOutA (∑ t, f t) = ∑ t, traceOutA (f t) := by
  ext k l
  simp [traceOutA, Finset.sum_comm]

theorem traceOutB_sum {τ : Type*} [Fintype τ]
    (f : τ → Operator (BipartiteIndex ι κ)) :
    traceOutB (∑ t, f t) = ∑ t, traceOutB (f t) := by
  ext i j
  simp [traceOutB, Finset.sum_comm]

/-- Tracing out `A` preserves positive semidefiniteness. -/
theorem traceOutA_posSemidef {M : Operator (BipartiteIndex ι κ)}
    (hM : M.PosSemidef) : (traceOutA M).PosSemidef := by
  simpa [traceOutA] using
    Matrix.posSemidef_sum Finset.univ
      (fun i _ ↦ hM.submatrix (fun k ↦ (i, k)))

/-- Tracing out `B` preserves positive semidefiniteness. -/
theorem traceOutB_posSemidef {M : Operator (BipartiteIndex ι κ)}
    (hM : M.PosSemidef) : (traceOutB M).PosSemidef := by
  simpa [traceOutB] using
    Matrix.posSemidef_sum Finset.univ
      (fun k _ ↦ hM.submatrix (fun i ↦ (i, k)))

/-- Tracing out `A` preserves the total trace. -/
theorem trace_traceOutA (M : Operator (BipartiteIndex ι κ)) :
    Matrix.trace (traceOutA M) = Matrix.trace M := by
  simp [Matrix.trace, traceOutA, Fintype.sum_prod_type, Finset.sum_comm]

/-- Tracing out `B` preserves the total trace. -/
theorem trace_traceOutB (M : Operator (BipartiteIndex ι κ)) :
    Matrix.trace (traceOutB M) = Matrix.trace M := by
  simp [Matrix.trace, traceOutB, Fintype.sum_prod_type, Finset.sum_comm]

/-- The partial trace over `A` of a Kronecker product. -/
theorem traceOutA_kronecker (A : Operator ι) (B : Operator κ) :
    traceOutA (A ⊗ₖ B) = Matrix.trace A • B := by
  ext k l
  simp [traceOutA, Matrix.trace, Matrix.kronecker_apply, Finset.sum_mul]

/-- The partial trace over `B` of a Kronecker product. -/
theorem traceOutB_kronecker (A : Operator ι) (B : Operator κ) :
    traceOutB (A ⊗ₖ B) = Matrix.trace B • A := by
  ext i j
  simp [traceOutB, Matrix.trace, Matrix.kronecker_apply, Finset.mul_sum, mul_comm]

/-- The normalized reduced state of subsystem `A`. -/
def reducedA (ρ : BipartiteState ι κ) : DensityState ι where
  matrix := traceOutB ρ.matrix
  posSemidef := traceOutB_posSemidef ρ.posSemidef
  trace_one := by rw [trace_traceOutB, ρ.trace_one]

/-- The normalized reduced state of subsystem `B`. -/
def reducedB (ρ : BipartiteState ι κ) : DensityState κ where
  matrix := traceOutA ρ.matrix
  posSemidef := traceOutA_posSemidef ρ.posSemidef
  trace_one := by rw [trace_traceOutA, ρ.trace_one]

@[simp]
theorem reducedA_matrix (ρ : BipartiteState ι κ) :
    (reducedA ρ).matrix = traceOutB ρ.matrix :=
  rfl

@[simp]
theorem reducedB_matrix (ρ : BipartiteState ι κ) :
    (reducedB ρ).matrix = traceOutA ρ.matrix :=
  rfl

@[simp]
theorem reducedA_tensor (ρ : DensityState ι) (σ : DensityState κ) :
    reducedA (ρ.tensor σ) = ρ := by
  apply DensityState.ext
  rw [reducedA_matrix, DensityState.tensor_matrix, traceOutB_kronecker,
    σ.trace_one, one_smul]

@[simp]
theorem reducedB_tensor (ρ : DensityState ι) (σ : DensityState κ) :
    reducedB (ρ.tensor σ) = σ := by
  apply DensityState.ext
  rw [reducedB_matrix, DensityState.tensor_matrix, traceOutA_kronecker,
    ρ.trace_one, one_smul]

/-! ## Subsystem-tagged local operators and observables -/

/-- An operator explicitly tagged as acting on subsystem `A` of `A × B`. -/
structure LocalOperatorA (ι κ : Type*) where
  operator : Operator ι

/-- An operator explicitly tagged as acting on subsystem `B` of `A × B`. -/
structure LocalOperatorB (ι κ : Type*) where
  operator : Operator κ

namespace LocalOperatorA

omit [Fintype ι] [Fintype κ] in
@[ext]
theorem ext {A C : LocalOperatorA ι κ} (h : A.operator = C.operator) : A = C := by
  cases A
  cases C
  cases h
  rfl

/-- Lift an A-tagged operator to the ordered bipartite space. -/
def lift [DecidableEq κ] (A : LocalOperatorA ι κ) : Operator (BipartiteIndex ι κ) :=
  A.operator ⊗ₖ (1 : Operator κ)

end LocalOperatorA

namespace LocalOperatorB

omit [Fintype ι] [Fintype κ] in
@[ext]
theorem ext {B C : LocalOperatorB ι κ} (h : B.operator = C.operator) : B = C := by
  cases B
  cases C
  cases h
  rfl

/-- Lift a B-tagged operator to the ordered bipartite space. -/
def lift [DecidableEq ι] (B : LocalOperatorB ι κ) : Operator (BipartiteIndex ι κ) :=
  (1 : Operator ι) ⊗ₖ B.operator

end LocalOperatorB

variable [DecidableEq ι] [DecidableEq κ]

theorem LocalOperatorA.lift_mul (A C : LocalOperatorA ι κ) :
    (LocalOperatorA.mk (A.operator * C.operator) : LocalOperatorA ι κ).lift =
      A.lift * C.lift := by
  rw [← Matrix.mul_kronecker_mul]
  simp [LocalOperatorA.lift]

theorem LocalOperatorB.lift_mul (B C : LocalOperatorB ι κ) :
    (LocalOperatorB.mk (B.operator * C.operator) : LocalOperatorB ι κ).lift =
      B.lift * C.lift := by
  rw [← Matrix.mul_kronecker_mul]
  simp [LocalOperatorB.lift]

/-- Operators placed on opposite factors multiply to their Kronecker product. -/
theorem localA_mul_localB (A : LocalOperatorA ι κ) (B : LocalOperatorB ι κ) :
    A.lift * B.lift = A.operator ⊗ₖ B.operator := by
  rw [← Matrix.mul_kronecker_mul]
  simp [LocalOperatorA.lift, LocalOperatorB.lift]

/-- Opposite-factor operators commute as an algebraic tensor identity. -/
theorem localA_commute_localB (A : LocalOperatorA ι κ) (B : LocalOperatorB ι κ) :
    A.lift * B.lift = B.lift * A.lift := by
  rw [localA_mul_localB]
  rw [← Matrix.mul_kronecker_mul]
  simp [LocalOperatorA.lift, LocalOperatorB.lift]

theorem LocalOperatorA.lift_mul_tensorKet
    (A : LocalOperatorA ι κ) (ψ : Ket ι) (φ : Ket κ) :
    A.lift *ᵥ tensorKet ψ φ = tensorKet (A.operator *ᵥ ψ) φ := by
  ext ⟨i, k⟩
  simp [LocalOperatorA.lift, tensorKet, Matrix.mulVec, dotProduct,
    Fintype.sum_prod_type, Matrix.kronecker_apply, Finset.sum_mul, mul_assoc]

theorem LocalOperatorB.lift_mul_tensorKet
    (B : LocalOperatorB ι κ) (ψ : Ket ι) (φ : Ket κ) :
    B.lift *ᵥ tensorKet ψ φ = tensorKet ψ (B.operator *ᵥ φ) := by
  ext ⟨i, k⟩
  simp [LocalOperatorB.lift, tensorKet, Matrix.mulVec, dotProduct,
    Fintype.sum_prod_type, Matrix.kronecker_apply, Finset.mul_sum, mul_assoc]

/-- A Hermitian observable explicitly tagged as belonging to subsystem `A`. -/
structure LocalObservableA (ι κ : Type*) where
  observable : Observable ι

/-- A Hermitian observable explicitly tagged as belonging to subsystem `B`. -/
structure LocalObservableB (ι κ : Type*) where
  observable : Observable κ

namespace LocalObservableA

/-- Lift an A-tagged observable to the ordered bipartite space. -/
def lift (A : LocalObservableA ι κ) : Observable (BipartiteIndex ι κ) where
  matrix := A.observable.matrix ⊗ₖ (1 : Operator κ)
  isHermitian := by
    unfold Matrix.IsHermitian
    rw [Matrix.conjTranspose_kronecker, A.observable.isHermitian,
      Matrix.conjTranspose_one]

end LocalObservableA

namespace LocalObservableB

/-- Lift a B-tagged observable to the ordered bipartite space. -/
def lift (B : LocalObservableB ι κ) : Observable (BipartiteIndex ι κ) where
  matrix := (1 : Operator ι) ⊗ₖ B.observable.matrix
  isHermitian := by
    unfold Matrix.IsHermitian
    rw [Matrix.conjTranspose_kronecker, Matrix.conjTranspose_one,
      B.observable.isHermitian]

end LocalObservableB

end EPR.Quantum
