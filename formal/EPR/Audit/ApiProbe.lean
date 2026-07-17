module

import EPR.Foundations
import Mathlib.Analysis.InnerProductSpace.Positive

/-!
# Compile-checked mathlib API probes

This diagnostic leaf records the APIs on which the Stage 1 representation
decision is based. It is intentionally not imported by `EPR.lean`.
-/

open scoped ComplexOrder Kronecker

namespace EPR.Audit.ApiProbe

#check Matrix.IsHermitian
#check Matrix.PosSemidef
#check Matrix.trace
#check Matrix.kronecker
#check Matrix.trace_kronecker
#check Matrix.mul_kronecker_mul
#check Matrix.conjTranspose_kronecker
#check Matrix.vecMulVec
#check Matrix.posSemidef_iff_eq_sum_vecMulVec
#check TensorProduct
#check TensorProduct.map

example : (0 : QubitOperator).IsHermitian := Matrix.isHermitian_zero

example : (0 : QubitOperator).PosSemidef := Matrix.PosSemidef.zero

example (ψ : QubitKet) : (Matrix.vecMulVec ψ (star ψ)).PosSemidef :=
  Matrix.posSemidef_iff_eq_sum_vecMulVec.mpr ⟨1, fun _ ↦ ψ, by simp⟩

example {ι κ : Type*} [Fintype ι] [Fintype κ]
    (A : Operator ι) (B : Operator κ) :
    Matrix.trace (A ⊗ₖ B) = Matrix.trace A * Matrix.trace B :=
  Matrix.trace_kronecker A B

example {ι κ : Type*} (A : Operator ι) (B : Operator κ) :
    (A ⊗ₖ B).conjTranspose = A.conjTranspose ⊗ₖ B.conjTranspose :=
  Matrix.conjTranspose_kronecker A B

end EPR.Audit.ApiProbe
