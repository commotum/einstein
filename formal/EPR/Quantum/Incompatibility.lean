module

public import EPR.Quantum.Core

/-!
# Finite-dimensional observable incompatibility

This module separates three mathematical notions for finite-dimensional
Hermitian observables:

* commutation of their matrices;
* possession of a common nonzero raw eigenvector; and
* existence of one density state sharp for both observables.

The notions are deliberately not identified. In particular, noncommutation by
itself does not imply absence of a common eigenvector in arbitrary dimension.
The checked bridge below instead proves that a jointly sharp density state
supplies a common nonzero eigenvector, so a no-common-eigenvector theorem is
sufficient to exclude jointly sharp pure and mixed states.

All declarations are mathematical. They make no claim about measurement,
physical reality, disturbance, locality, completeness, or counterfactual
reasoning.
-/

@[expose] public section

namespace EPR.Quantum

open EPR
open scoped Matrix

variable {ι : Type*} [Fintype ι]

namespace Observable

/-- Two observables commute when their matrices commute under multiplication. -/
def Commutes (A B : Observable ι) : Prop :=
  Commute A.matrix B.matrix

/-- Matrix noncommutation, kept separate from spectral incompatibility. -/
def Noncommutes (A B : Observable ι) : Prop :=
  ¬ A.Commutes B

/-- A raw ket is an eigenvector of an observable for the stated real value.
Normalization and nonzeroness are separate conditions. -/
def IsEigenvector (A : Observable ι) (ψ : Ket ι) (a : ℝ) : Prop :=
  A.matrix *ᵥ ψ = (a : ℂ) • ψ

/-- Two observables have a common eigenvector when one nonzero raw ket obeys
both eigenvalue equations, possibly with different real eigenvalues. -/
def HasCommonEigenvector (A B : Observable ι) : Prop :=
  ∃ ψ : Ket ι, ψ ≠ 0 ∧
    ∃ a b : ℝ, A.IsEigenvector ψ a ∧ B.IsEigenvector ψ b

/-- There is no nonzero raw ket satisfying both eigenvalue equations. -/
def NoCommonEigenvector (A B : Observable ι) : Prop :=
  ¬ A.HasCommonEigenvector B

/-- Some pure or mixed density state is sharp for both observables. -/
def HasJointSharpState (A B : Observable ι) : Prop :=
  ∃ ρ : DensityState ι, ρ.JointlySharp A B

/-- No density state, pure or mixed, is sharp for both observables. -/
def NoJointSharpState (A B : Observable ι) : Prop :=
  ¬ A.HasJointSharpState B

@[simp]
theorem commutes_comm (A B : Observable ι) :
    A.Commutes B ↔ B.Commutes A :=
  Commute.symm_iff

@[simp]
theorem hasCommonEigenvector_comm (A B : Observable ι) :
    A.HasCommonEigenvector B ↔ B.HasCommonEigenvector A := by
  constructor
  · rintro ⟨ψ, hψ, a, b, ha, hb⟩
    exact ⟨ψ, hψ, b, a, hb, ha⟩
  · rintro ⟨ψ, hψ, b, a, hb, ha⟩
    exact ⟨ψ, hψ, a, b, ha, hb⟩

@[simp]
theorem hasJointSharpState_comm (A B : Observable ι) :
    A.HasJointSharpState B ↔ B.HasJointSharpState A := by
  constructor
  · rintro ⟨ρ, a, b, ha, hb⟩
    exact ⟨ρ, b, a, hb, ha⟩
  · rintro ⟨ρ, b, a, hb, ha⟩
    exact ⟨ρ, a, b, ha, hb⟩

end Observable

namespace PureState

/-- The raw-ket eigenvector predicate agrees definitionally with the existing
normalized pure-state predicate. -/
theorem isEigenvector_iff_isEigenstate (ψ : PureState ι)
    (A : Observable ι) (a : ℝ) :
    A.IsEigenvector ψ.ket a ↔ ψ.IsEigenstate A a :=
  Iff.rfl

end PureState

namespace DensityState

/-- A trace-one density matrix has at least one nonzero column. -/
theorem exists_col_ne_zero (ρ : DensityState ι) :
    ∃ j : ι, ρ.matrix.col j ≠ 0 := by
  by_contra h
  apply ρ.ne_zero
  ext i j
  have hcol : ρ.matrix.col j = 0 := by
    by_contra hj
    exact h ⟨j, hj⟩
  simpa using congrFun hcol i

/-- Every column of a density matrix with sharp value `a` is a raw
eigenvector with value `a`; a zero column is allowed by this local statement. -/
theorem col_isEigenvector_of_sharpValue
    {ρ : DensityState ι} {A : Observable ι} {a : ℝ}
    (h : ρ.SharpValue A a) (j : ι) :
    A.IsEigenvector (ρ.matrix.col j) a := by
  unfold Observable.IsEigenvector DensityState.SharpValue at *
  funext i
  have hij := congrFun (congrFun h i) j
  simpa [Matrix.mulVec, dotProduct, Matrix.mul_apply, Matrix.col_apply,
    Matrix.smul_apply, smul_eq_mul] using hij

end DensityState

namespace Observable

/-- A density state sharp for both observables has a common nonzero raw
eigenvector. The witness is a nonzero column of its trace-one matrix. -/
theorem hasCommonEigenvector_of_hasJointSharpState
    {A B : Observable ι} (h : A.HasJointSharpState B) :
    A.HasCommonEigenvector B := by
  rcases h with ⟨ρ, a, b, ha, hb⟩
  obtain ⟨j, hj⟩ := ρ.exists_col_ne_zero
  exact ⟨ρ.matrix.col j, hj, a, b,
    ρ.col_isEigenvector_of_sharpValue ha j,
    ρ.col_isEigenvector_of_sharpValue hb j⟩

/-- Excluding every common nonzero eigenvector excludes every jointly sharp
density state, including mixed states. -/
theorem noJointSharpState_of_noCommonEigenvector
    {A B : Observable ι} (h : A.NoCommonEigenvector B) :
    A.NoJointSharpState B :=
  fun hsharp ↦ h (hasCommonEigenvector_of_hasJointSharpState hsharp)

end Observable

end EPR.Quantum
