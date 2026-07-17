module

public import EPR.Foundations
public import Mathlib.Analysis.InnerProductSpace.Positive

/-!
# Finite-dimensional quantum core

This module defines normalized pure states, positive trace-one density states,
Hermitian observables, orthogonal projectors, projective outcomes, Born
probability, and sharpness. It contains mathematical and operational
vocabulary only; it makes no claim about physical reality, locality, or
completeness.
-/

@[expose] public section

open scoped ComplexOrder Matrix

namespace EPR.Quantum

variable {ι : Type*} [Fintype ι]

/-- A normalized finite-dimensional pure state in a fixed basis. -/
structure PureState (ι : Type*) [Fintype ι] where
  ket : Ket ι
  normalized : ket ⬝ᵥ star ket = 1

namespace PureState

@[ext]
theorem ext {ψ φ : PureState ι} (h : ψ.ket = φ.ket) : ψ = φ := by
  cases ψ
  cases φ
  cases h
  rfl

/-- A normalized pure state cannot contain the zero ket. -/
theorem ne_zero (ψ : PureState ι) : ψ.ket ≠ 0 := by
  intro h
  have hn := ψ.normalized
  rw [h] at hn
  simp at hn

/-- The equivalent conjugate-first normalization convention. -/
theorem star_dot_normalized (ψ : PureState ι) : star ψ.ket ⬝ᵥ ψ.ket = 1 := by
  simpa [dotProduct_comm] using ψ.normalized

end PureState

/-- A finite-dimensional density state: positive semidefinite with unit trace. -/
structure DensityState (ι : Type*) [Fintype ι] where
  matrix : Operator ι
  posSemidef : matrix.PosSemidef
  trace_one : matrix.trace = 1

namespace DensityState

@[ext]
theorem ext {ρ σ : DensityState ι} (h : ρ.matrix = σ.matrix) : ρ = σ := by
  cases ρ
  cases σ
  cases h
  rfl

/-- Positivity includes Hermiticity. -/
theorem isHermitian (ρ : DensityState ι) : ρ.matrix.IsHermitian :=
  ρ.posSemidef.isHermitian

/-- A trace-one density state cannot contain the zero matrix. -/
theorem ne_zero (ρ : DensityState ι) : ρ.matrix ≠ 0 := by
  intro h
  have ht := ρ.trace_one
  rw [h] at ht
  simp at ht

end DensityState

namespace PureState

/-- The rank-one density state associated with a normalized ket. -/
def toDensity (ψ : PureState ι) : DensityState ι where
  matrix := Matrix.vecMulVec ψ.ket (star ψ.ket)
  posSemidef :=
    Matrix.posSemidef_iff_eq_sum_vecMulVec.mpr
      ⟨1, fun _ ↦ ψ.ket, by simp⟩
  trace_one := by
    simpa using ψ.normalized

@[simp]
theorem toDensity_matrix (ψ : PureState ι) :
    ψ.toDensity.matrix = Matrix.vecMulVec ψ.ket (star ψ.ket) :=
  rfl

@[simp]
theorem toDensity_matrix_apply (ψ : PureState ι) (i j : ι) :
    ψ.toDensity.matrix i j = ψ.ket i * star (ψ.ket j) :=
  rfl

end PureState

/-- A finite-dimensional observable, represented by a Hermitian matrix. -/
structure Observable (ι : Type*) where
  matrix : Operator ι
  isHermitian : matrix.IsHermitian

namespace Observable

omit [Fintype ι] in
@[ext]
theorem ext {A B : Observable ι} (h : A.matrix = B.matrix) : A = B := by
  cases A
  cases B
  cases h
  rfl

/-- The zero observable. -/
def zero : Observable ι where
  matrix := 0
  isHermitian := Matrix.isHermitian_zero

/-- The identity observable. -/
def identity [DecidableEq ι] : Observable ι where
  matrix := 1
  isHermitian := Matrix.isHermitian_one

end Observable

/-- An orthogonal projector. Its range may have dimension greater than one. -/
structure Projection (ι : Type*) [Fintype ι] where
  matrix : Operator ι
  isHermitian : matrix.IsHermitian
  idempotent : matrix * matrix = matrix

namespace Projection

@[ext]
theorem ext {P Q : Projection ι} (h : P.matrix = Q.matrix) : P = Q := by
  cases P
  cases Q
  cases h
  rfl

/-- The zero orthogonal projector. It is not a valid projective outcome. -/
def zero : Projection ι where
  matrix := 0
  isHermitian := Matrix.isHermitian_zero
  idempotent := by simp

/-- The identity orthogonal projector. -/
def identity [DecidableEq ι] : Projection ι where
  matrix := 1
  isHermitian := Matrix.isHermitian_one
  idempotent := by simp

/-- The density state is supported in the range of the projector. -/
def Supports (P : Projection ι) (ρ : DensityState ι) : Prop :=
  P.matrix * ρ.matrix = ρ.matrix

end Projection

/-- A nonzero spectral projector for a real outcome of an observable.

No rank-one condition is imposed, so degenerate eigenspaces are supported.
-/
structure ProjectiveOutcome (A : Observable ι) where
  value : ℝ
  projector : Projection ι
  nonzero : projector.matrix ≠ 0
  spectral : A.matrix * projector.matrix = (value : ℂ) • projector.matrix

/-- The complex trace expression underlying the Born probability. -/
def bornWeight (ρ : DensityState ι) (P : Projection ι) : ℂ :=
  Matrix.trace (P.matrix * ρ.matrix)

/-- The real-valued Born probability expression for a projective outcome.

Probability bounds are theorems, not fields hidden in this definition.
-/
def outcomeProbability (ρ : DensityState ι) (P : Projection ι) : ℝ :=
  (bornWeight ρ P).re

/-- The Born weight of a projector and a density state is real. -/
theorem star_bornWeight (ρ : DensityState ι) (P : Projection ι) :
    star (bornWeight ρ P) = bornWeight ρ P := by
  rw [bornWeight, ← Matrix.trace_conjTranspose, Matrix.conjTranspose_mul]
  rw [P.isHermitian.eq, ρ.isHermitian.eq, Matrix.trace_mul_comm]

/-- The complex Born weight is the coercion of `outcomeProbability`. -/
theorem coe_outcomeProbability (ρ : DensityState ι) (P : Projection ι) :
    (outcomeProbability ρ P : ℂ) = bornWeight ρ P := by
  exact Complex.conj_eq_iff_re.mp (by simpa using star_bornWeight ρ P)

/-- Projector support implies probability one. -/
theorem outcomeProbability_eq_one_of_support
    (ρ : DensityState ι) (P : Projection ι) (h : P.Supports ρ) :
    outcomeProbability ρ P = 1 := by
  change P.matrix * ρ.matrix = ρ.matrix at h
  rw [outcomeProbability, bornWeight, h, ρ.trace_one]
  simp

namespace PureState

/-- A pure state is an eigenstate of an observable with the stated real value. -/
def IsEigenstate (ψ : PureState ι) (A : Observable ι) (a : ℝ) : Prop :=
  A.matrix *ᵥ ψ.ket = (a : ℂ) • ψ.ket

end PureState

namespace DensityState

/-- A density state has a sharp value when its support lies in that eigenspace. -/
def SharpValue (ρ : DensityState ι) (A : Observable ι) (a : ℝ) : Prop :=
  A.matrix * ρ.matrix = (a : ℂ) • ρ.matrix

/-- A density state is jointly sharp for two observables when each has a real
sharp value in that same state. -/
def JointlySharp (ρ : DensityState ι) (A B : Observable ι) : Prop :=
  ∃ a b : ℝ, ρ.SharpValue A a ∧ ρ.SharpValue B b

/-- A sharp value fixes the trace expectation of the observable. -/
theorem trace_mul_eq_of_sharpValue
    {ρ : DensityState ι} {A : Observable ι} {a : ℝ}
    (h : ρ.SharpValue A a) :
    Matrix.trace (A.matrix * ρ.matrix) = (a : ℂ) := by
  rw [h, Matrix.trace_smul, ρ.trace_one]
  simp

/-- A density state cannot have two different sharp values for one observable. -/
theorem sharpValue_unique
    {ρ : DensityState ι} {A : Observable ι} {a b : ℝ}
    (ha : ρ.SharpValue A a) (hb : ρ.SharpValue A b) : a = b := by
  apply Complex.ofReal_injective
  rw [← trace_mul_eq_of_sharpValue ha, ← trace_mul_eq_of_sharpValue hb]

end DensityState

namespace PureState

/-- A pure eigenstate yields a sharp value for its rank-one density state. -/
theorem toDensity_sharpValue
    {ψ : PureState ι} {A : Observable ι} {a : ℝ}
    (h : ψ.IsEigenstate A a) : ψ.toDensity.SharpValue A a := by
  change A.matrix *ᵥ ψ.ket = (a : ℂ) • ψ.ket at h
  unfold DensityState.SharpValue
  rw [toDensity_matrix, Matrix.mul_vecMulVec, h, Matrix.smul_vecMulVec]

end PureState

namespace ProjectiveOutcome

/-- A state supported in a spectral outcome's projector has that sharp value. -/
theorem sharpValue_of_support
    {A : Observable ι} (o : ProjectiveOutcome A) (ρ : DensityState ι)
    (h : o.projector.Supports ρ) : ρ.SharpValue A o.value := by
  unfold DensityState.SharpValue
  calc
    A.matrix * ρ.matrix = A.matrix * (o.projector.matrix * ρ.matrix) := by rw [h]
    _ = (A.matrix * o.projector.matrix) * ρ.matrix := by rw [Matrix.mul_assoc]
    _ = ((o.value : ℂ) • o.projector.matrix) * ρ.matrix := by rw [o.spectral]
    _ = (o.value : ℂ) • (o.projector.matrix * ρ.matrix) := by rw [Matrix.smul_mul]
    _ = (o.value : ℂ) • ρ.matrix := by rw [h]

end ProjectiveOutcome

end EPR.Quantum
