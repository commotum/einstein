module

public import EPR.Quantum.Conditional

/-!
# Finite operational no-signalling

This module proves a directional, finite-dimensional operational statement.
For a complete projective measurement on subsystem `A`, the outcome-forgotten
local Lüders update is the sum of the raw joint branches
`(P_w ⊗ I) ρ (P_w ⊗ I)`. Tracing out `A` after that update gives exactly the
same reduced density state on `B` as before the measurement. Consequently all
projective Born statistics available on `B` are unchanged.

This is not a statement about a selected conditional branch. It also makes no
claim about spacetime separation, communication protocols, physical reality,
ontic disturbance, locality, counterfactual reasoning, or arbitrary quantum
channels. Those notions are not defined here.
-/

open scoped ComplexOrder Kronecker Matrix

@[expose] public section

namespace EPR.Quantum

variable {ω ι κ : Type*}
  [Fintype ω] [Fintype ι] [Fintype κ]
  [DecidableEq ι] [DecidableEq κ]

namespace ProjectiveMeasurement

/-- One source projector explicitly tagged as acting on subsystem `A`. -/
def localAProjection (M : ProjectiveMeasurement ω ι) (w : ω) :
    LocalProjectionA ι κ :=
  ⟨M.projector w⟩

/-- The lifted local projectors still resolve the identity on `A × B`. -/
theorem sum_localAProjection_lift (M : ProjectiveMeasurement ω ι) :
    ∑ w, ((M.localAProjection (κ := κ) w).lift).matrix = 1 := by
  classical
  change (∑ w, (M.projector w).matrix ⊗ₖ (1 : Operator κ)) = 1
  calc
    (∑ w, (M.projector w).matrix ⊗ₖ (1 : Operator κ)) =
        (∑ w, (M.projector w).matrix) ⊗ₖ (1 : Operator κ) := by
      ext p q
      simp only [Matrix.sum_apply, Matrix.kroneckerMap_apply]
      rw [Finset.sum_mul]
    _ = (1 : Operator ι) ⊗ₖ (1 : Operator κ) := by rw [M.complete]
    _ = 1 := Matrix.one_kronecker_one

end ProjectiveMeasurement

/-- The complete outcome-forgotten Lüders update performed locally on `A`.

The sum contains raw subnormalized branches, whose traces already carry their
Born weights. It is not an unweighted sum of normalized conditional states.
-/
noncomputable def localANonselectiveState
    (ρ : BipartiteState ι κ) (M : ProjectiveMeasurement ω ι) :
    BipartiteState ι κ where
  matrix := ∑ w, ludersBranchMatrix ρ
    (M.localAProjection (κ := κ) w).lift
  posSemidef :=
    Matrix.posSemidef_sum Finset.univ fun w _ ↦
      ludersBranchMatrix_posSemidef ρ
        (M.localAProjection (κ := κ) w).lift
  trace_one := by
    rw [Matrix.trace_sum]
    simp_rw [trace_ludersBranchMatrix_eq_bornWeight]
    unfold bornWeight
    rw [← Matrix.trace_sum, ← Finset.sum_mul,
      M.sum_localAProjection_lift]
    simp [ρ.trace_one]

@[simp]
theorem localANonselectiveState_matrix
    (ρ : BipartiteState ι κ) (M : ProjectiveMeasurement ω ι) :
    (localANonselectiveState ρ M).matrix =
      ∑ w, ludersBranchMatrix ρ
        (M.localAProjection (κ := κ) w).lift :=
  rfl

omit [DecidableEq ι] in
/-- A factor acting only on `A` may be cycled through the partial trace over
`A`. -/
theorem traceOutA_localA_mul_cycle (A : Operator ι)
    (X : Operator (BipartiteIndex ι κ)) :
    traceOutA ((A ⊗ₖ (1 : Operator κ)) * X) =
      traceOutA (X * (A ⊗ₖ (1 : Operator κ))) := by
  ext k l
  calc
    traceOutA ((A ⊗ₖ (1 : Operator κ)) * X) k l =
        ∑ i, ∑ j, A i j * X (j, k) (i, l) := by
      simp [traceOutA_apply, Matrix.mul_apply, Matrix.one_apply,
        Fintype.sum_prod_type]
    _ = ∑ j, ∑ i, A i j * X (j, k) (i, l) := Finset.sum_comm
    _ = ∑ j, ∑ i, X (j, k) (i, l) * A i j := by
      apply Finset.sum_congr rfl
      intro j _
      apply Finset.sum_congr rfl
      intro i _
      exact mul_comm _ _
    _ = traceOutA (X * (A ⊗ₖ (1 : Operator κ))) k l := by
      simp [traceOutA_apply, Matrix.mul_apply, Matrix.one_apply,
        Fintype.sum_prod_type]

omit [DecidableEq ι] in
/-- After tracing out `A`, a local selected Lüders sandwich reduces to one
right multiplication by its idempotent source projector. -/
theorem traceOutA_ludersBranchMatrix_localA
    (ρ : BipartiteState ι κ) (P : LocalProjectionA ι κ) :
    traceOutA (ludersBranchMatrix ρ P.lift) =
      traceOutA (ρ.matrix * P.lift.matrix) := by
  unfold ludersBranchMatrix
  rw [Matrix.mul_assoc]
  change traceOutA
      ((P.projection.matrix ⊗ₖ (1 : Operator κ)) *
        (ρ.matrix * P.lift.matrix)) = _
  rw [traceOutA_localA_mul_cycle]
  rw [Matrix.mul_assoc]
  change traceOutA (ρ.matrix *
    (P.lift.matrix * P.lift.matrix)) = _
  rw [P.lift.idempotent]

/-- Directional operational no-signalling from `A` to `B` for the stated
complete local projective measurement and input state. -/
def OperationalNoSignallingAtoB
    (ρ : BipartiteState ι κ) (M : ProjectiveMeasurement ω ι) : Prop :=
  reducedB (localANonselectiveState ρ M) = reducedB ρ

/-- Every complete projective Lüders measurement on `A`, when its outcome is
discarded, is operationally non-signalling from `A` to `B`. -/
theorem localA_nonselective_noSignalling
    (ρ : BipartiteState ι κ) (M : ProjectiveMeasurement ω ι) :
    OperationalNoSignallingAtoB ρ M := by
  apply DensityState.ext
  rw [reducedB_matrix, localANonselectiveState_matrix, reducedB_matrix]
  rw [traceOutA_sum]
  simp_rw [traceOutA_ludersBranchMatrix_localA]
  rw [← traceOutA_sum, ← Finset.mul_sum,
    M.sum_localAProjection_lift]
  simp

/-- Every projective Born statistic on `B` is unchanged by the outcome-
forgotten local measurement on `A`. -/
theorem localA_nonselective_outcomeProbability
    (ρ : BipartiteState ι κ) (M : ProjectiveMeasurement ω ι)
    (Q : Projection κ) :
    outcomeProbability (reducedB (localANonselectiveState ρ M)) Q =
      outcomeProbability (reducedB ρ) Q := by
  rw [localA_nonselective_noSignalling ρ M]

/-- Any two complete projective measurement choices on `A`, with outcomes
discarded, give the same unconditioned reduced state on `B`. -/
theorem localA_nonselective_reducedB_independent
    {τ : Type*} [Fintype τ]
    (ρ : BipartiteState ι κ)
    (M : ProjectiveMeasurement ω ι) (N : ProjectiveMeasurement τ ι) :
    reducedB (localANonselectiveState ρ M) =
      reducedB (localANonselectiveState ρ N) := by
  rw [localA_nonselective_noSignalling ρ M,
    localA_nonselective_noSignalling ρ N]

/-- The corresponding `B`-side projective statistics are independent of the
choice between any two complete A-side projective measurements. -/
theorem localA_nonselective_outcomeProbability_independent
    {τ : Type*} [Fintype τ]
    (ρ : BipartiteState ι κ)
    (M : ProjectiveMeasurement ω ι) (N : ProjectiveMeasurement τ ι)
    (Q : Projection κ) :
    outcomeProbability (reducedB (localANonselectiveState ρ M)) Q =
      outcomeProbability (reducedB (localANonselectiveState ρ N)) Q := by
  rw [localA_nonselective_reducedB_independent ρ M N]

end EPR.Quantum
