module

public import EPR.Quantum.Bipartite

/-!
# Finite-dimensional projective conditioning

This module implements the Lüders rule for finite projective measurements.
For a projection `P` and density state `ρ`, the selected subnormalized branch
is `PρP`; it is normalized only from explicit evidence that its Born
probability is strictly positive.  A full projective measurement separately
defines the nonselective sum of all branches.

The Lüders update is a mathematical measurement-model choice, especially for
degenerate projections. Outcome labels identify possible branches; no
declaration here asserts that an outcome actually occurred. Selective states,
nonselective states, and the unconditioned reduced states from the bipartite
layer are distinct APIs. Nothing here is an operational no-signalling result
or an ontic locality/no-disturbance claim.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Quantum

variable {ι : Type*} [Fintype ι]

namespace Projection

/-- The orthogonal complement of a projection. -/
def complement [DecidableEq ι] (P : Projection ι) : Projection ι where
  matrix := 1 - P.matrix
  isHermitian := Matrix.isHermitian_one.sub P.isHermitian
  idempotent := by
    rw [sub_mul, one_mul, mul_sub, mul_one, P.idempotent, sub_self, sub_zero]

@[simp]
theorem complement_matrix [DecidableEq ι] (P : Projection ι) :
    P.complement.matrix = 1 - P.matrix :=
  rfl

end Projection

/-! ## Subnormalized states and checked normalization -/

/-- A positive finite-dimensional operator with real trace at most one.

The zero operator is allowed. Positivity proves that its trace is real and
nonnegative; `trace_le_one` supplies the other half of subnormalization.
-/
structure SubnormalizedState (ι : Type*) [Fintype ι] where
  matrix : Operator ι
  posSemidef : matrix.PosSemidef
  trace_le_one : matrix.trace.re ≤ 1

namespace SubnormalizedState

@[ext]
theorem ext {σ τ : SubnormalizedState ι} (h : σ.matrix = τ.matrix) : σ = τ := by
  cases σ
  cases τ
  cases h
  rfl

/-- The real trace weight of a subnormalized state. -/
def weight (σ : SubnormalizedState ι) : ℝ :=
  σ.matrix.trace.re

/-- Positivity makes the trace weight nonnegative. -/
theorem weight_nonneg (σ : SubnormalizedState ι) : 0 ≤ σ.weight :=
  (Complex.nonneg_iff.mp σ.posSemidef.trace_nonneg).1

/-- The trace weight is at most one. -/
theorem weight_le_one (σ : SubnormalizedState ι) : σ.weight ≤ 1 :=
  σ.trace_le_one

/-- The complex trace is exactly the coercion of the real trace weight. -/
theorem coe_weight (σ : SubnormalizedState ι) :
    (σ.weight : ℂ) = σ.matrix.trace := by
  apply Complex.ext
  · rfl
  · exact (Complex.nonneg_iff.mp σ.posSemidef.trace_nonneg).2

/-- A positive subnormalized state has weight zero exactly when its matrix is
zero. -/
theorem weight_eq_zero_iff_matrix_eq_zero (σ : SubnormalizedState ι) :
    σ.weight = 0 ↔ σ.matrix = 0 := by
  rw [← Complex.ofReal_eq_zero, coe_weight,
    σ.posSemidef.trace_eq_zero_iff]

/-- Normalize a strictly positive-weight subnormalized state. -/
noncomputable def normalize (σ : SubnormalizedState ι) (h : 0 < σ.weight) :
    DensityState ι where
  matrix := ((σ.weight : ℂ)⁻¹) • σ.matrix
  posSemidef := by
    apply σ.posSemidef.smul
    rw [← Complex.ofReal_inv]
    exact Complex.zero_le_real.mpr (inv_nonneg.mpr σ.weight_nonneg)
  trace_one := by
    rw [Matrix.trace_smul, ← coe_weight]
    simp [smul_eq_mul, h.ne']

@[simp]
theorem normalize_matrix (σ : SubnormalizedState ι) (h : 0 < σ.weight) :
    (σ.normalize h).matrix = ((σ.weight : ℂ)⁻¹) • σ.matrix :=
  rfl

end SubnormalizedState

/-! ## Single selected Lüders branches -/

/-- The raw selected Lüders branch `PρP`. -/
def ludersBranchMatrix (ρ : DensityState ι) (P : Projection ι) : Operator ι :=
  P.matrix * ρ.matrix * P.matrix

/-- A selected Lüders branch is positive semidefinite. -/
theorem ludersBranchMatrix_posSemidef (ρ : DensityState ι) (P : Projection ι) :
    (ludersBranchMatrix ρ P).PosSemidef := by
  simpa [ludersBranchMatrix, P.isHermitian.eq] using
    ρ.posSemidef.mul_mul_conjTranspose_same P.matrix

/-- The trace of the selected branch is the complex Born weight. -/
theorem trace_ludersBranchMatrix_eq_bornWeight
    (ρ : DensityState ι) (P : Projection ι) :
    Matrix.trace (ludersBranchMatrix ρ P) = bornWeight ρ P := by
  rw [ludersBranchMatrix, Matrix.trace_mul_cycle, P.idempotent]
  rfl

/-- The trace of the selected branch is the real Born probability coerced to
`ℂ`. -/
theorem trace_ludersBranchMatrix (ρ : DensityState ι) (P : Projection ι) :
    Matrix.trace (ludersBranchMatrix ρ P) =
      (outcomeProbability ρ P : ℂ) := by
  rw [trace_ludersBranchMatrix_eq_bornWeight, coe_outcomeProbability]

/-- Every projective Born probability is nonnegative. -/
theorem outcomeProbability_nonneg (ρ : DensityState ι) (P : Projection ι) :
    0 ≤ outcomeProbability ρ P := by
  have htrace : (0 : ℂ) ≤ Matrix.trace (ludersBranchMatrix ρ P) :=
    (ludersBranchMatrix_posSemidef ρ P).trace_nonneg
  rw [trace_ludersBranchMatrix] at htrace
  exact Complex.zero_le_real.mp htrace

/-- The complementary projection has the complementary probability. -/
theorem outcomeProbability_complement [DecidableEq ι]
    (ρ : DensityState ι) (P : Projection ι) :
    outcomeProbability ρ P.complement = 1 - outcomeProbability ρ P := by
  classical
  unfold outcomeProbability bornWeight Projection.complement
  rw [sub_mul, one_mul, Matrix.trace_sub, ρ.trace_one]
  simp

/-- Every projective Born probability is at most one. -/
theorem outcomeProbability_le_one (ρ : DensityState ι) (P : Projection ι) :
    outcomeProbability ρ P ≤ 1 := by
  classical
  have h := outcomeProbability_nonneg ρ P.complement
  rw [outcomeProbability_complement] at h
  exact sub_nonneg.mp h

/-- Every projective Born probability lies in the unit interval. -/
theorem outcomeProbability_mem_Icc (ρ : DensityState ι) (P : Projection ι) :
    outcomeProbability ρ P ∈ Set.Icc (0 : ℝ) 1 :=
  ⟨outcomeProbability_nonneg ρ P, outcomeProbability_le_one ρ P⟩

/-- Package the selected Lüders branch as a checked subnormalized state. -/
def ludersBranch (ρ : DensityState ι) (P : Projection ι) :
    SubnormalizedState ι where
  matrix := ludersBranchMatrix ρ P
  posSemidef := ludersBranchMatrix_posSemidef ρ P
  trace_le_one := by
    rw [trace_ludersBranchMatrix_eq_bornWeight]
    simpa [outcomeProbability] using outcomeProbability_le_one ρ P

@[simp]
theorem ludersBranch_matrix (ρ : DensityState ι) (P : Projection ι) :
    (ludersBranch ρ P).matrix = ludersBranchMatrix ρ P :=
  rfl

@[simp]
theorem ludersBranch_weight (ρ : DensityState ι) (P : Projection ι) :
    (ludersBranch ρ P).weight = outcomeProbability ρ P := by
  rw [SubnormalizedState.weight, ludersBranch,
    trace_ludersBranchMatrix_eq_bornWeight]
  rfl

/-- A branch has zero probability exactly when its Lüders matrix is zero. -/
theorem outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero
    (ρ : DensityState ι) (P : Projection ι) :
    outcomeProbability ρ P = 0 ↔ ludersBranchMatrix ρ P = 0 := by
  rw [← Complex.ofReal_eq_zero, coe_outcomeProbability,
    ← trace_ludersBranchMatrix_eq_bornWeight,
    (ludersBranchMatrix_posSemidef ρ P).trace_eq_zero_iff]

/-- Strictly positive conditioning evidence exists exactly for a nonzero
selected branch. -/
theorem outcomeProbability_pos_iff_ludersBranchMatrix_ne_zero
    (ρ : DensityState ι) (P : Projection ι) :
    0 < outcomeProbability ρ P ↔ ludersBranchMatrix ρ P ≠ 0 := by
  constructor
  · intro hp hbranch
    exact hp.ne' <|
      outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero ρ P |>.mpr hbranch
  · intro hbranch
    have hp : outcomeProbability ρ P ≠ 0 := fun hzero ↦
      hbranch <|
        outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero ρ P |>.mp hzero
    exact lt_of_le_of_ne (outcomeProbability_nonneg ρ P) hp.symm

/-- Normalize a selected Lüders branch. Strict positivity is explicit in the
type, so a zero-probability branch cannot be conditioned. -/
noncomputable def conditionalState (ρ : DensityState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ρ P) : DensityState ι :=
  (ludersBranch ρ P).normalize (by simpa using h)

@[simp]
theorem conditionalState_matrix (ρ : DensityState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ρ P) :
    (conditionalState ρ P h).matrix =
      ((outcomeProbability ρ P : ℂ)⁻¹) • ludersBranchMatrix ρ P := by
  change (((ludersBranch ρ P).weight : ℂ)⁻¹) •
    (ludersBranch ρ P).matrix = _
  rw [ludersBranch_weight]
  rfl

/-- The selected conditional state is supported in the selected projector. -/
theorem conditionalState_supports (ρ : DensityState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ρ P) :
    P.Supports (conditionalState ρ P h) := by
  unfold Projection.Supports
  rw [conditionalState_matrix, Matrix.mul_smul]
  congr 1
  unfold ludersBranchMatrix
  calc
    P.matrix * (P.matrix * ρ.matrix * P.matrix) =
        (P.matrix * (P.matrix * ρ.matrix)) * P.matrix :=
      (Matrix.mul_assoc P.matrix (P.matrix * ρ.matrix) P.matrix).symm
    _ = (P.matrix * P.matrix) * ρ.matrix * P.matrix :=
      congrArg (fun M ↦ M * P.matrix)
        (Matrix.mul_assoc P.matrix P.matrix ρ.matrix).symm
    _ = P.matrix * ρ.matrix * P.matrix := by rw [P.idempotent]

/-- Reselecting the same projector in the conditional state has probability
one. -/
theorem conditionalState_selected_probability_eq_one
    (ρ : DensityState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ρ P) :
    outcomeProbability (conditionalState ρ P h) P = 1 :=
  outcomeProbability_eq_one_of_support _ _ (conditionalState_supports ρ P h)

/-! ## Complete projective measurements and nonselective states -/

/-- A finite projective measurement indexed by outcome labels `ω`.

Every projector is nonzero, different labels have orthogonal ranges, and the
projectors resolve the identity. The labels describe possible outcomes only.
-/
structure ProjectiveMeasurement (ω ι : Type*) [Fintype ω] [Fintype ι]
    [DecidableEq ι] where
  projector : ω → Projection ι
  nonzero : ∀ w, (projector w).matrix ≠ 0
  orthogonal : ∀ {w v}, w ≠ v →
    (projector w).matrix * (projector v).matrix = 0
  complete : ∑ w, (projector w).matrix = 1

namespace ProjectiveMeasurement

variable {ω : Type*} [Fintype ω] [DecidableEq ι]

/-- The Born probability of one labeled measurement outcome. -/
def probability (M : ProjectiveMeasurement ω ι) (ρ : DensityState ι)
    (w : ω) : ℝ :=
  outcomeProbability ρ (M.projector w)

theorem probability_nonneg (M : ProjectiveMeasurement ω ι)
    (ρ : DensityState ι) (w : ω) : 0 ≤ M.probability ρ w :=
  outcomeProbability_nonneg ρ (M.projector w)

theorem probability_le_one (M : ProjectiveMeasurement ω ι)
    (ρ : DensityState ι) (w : ω) : M.probability ρ w ≤ 1 :=
  outcomeProbability_le_one ρ (M.projector w)

/-- The probabilities of all outcomes in a complete projective measurement
sum to one. -/
theorem probability_sum (M : ProjectiveMeasurement ω ι)
    (ρ : DensityState ι) : ∑ w, M.probability ρ w = 1 := by
  unfold probability outcomeProbability bornWeight
  change ∑ w, Complex.reAddGroupHom
    (((M.projector w).matrix * ρ.matrix).trace) = 1
  rw [← map_sum, ← Matrix.trace_sum, ← Finset.sum_mul, M.complete]
  simp [ρ.trace_one]

/-- The nonselective Lüders state is the sum of every raw selected branch, not
an unweighted sum of normalized conditional states. -/
noncomputable def nonselectiveState (M : ProjectiveMeasurement ω ι)
    (ρ : DensityState ι) : DensityState ι where
  matrix := ∑ w, ludersBranchMatrix ρ (M.projector w)
  posSemidef :=
    Matrix.posSemidef_sum Finset.univ fun w _ ↦
      ludersBranchMatrix_posSemidef ρ (M.projector w)
  trace_one := by
    rw [Matrix.trace_sum]
    simp_rw [trace_ludersBranchMatrix_eq_bornWeight]
    unfold bornWeight
    rw [← Matrix.trace_sum, ← Finset.sum_mul, M.complete]
    simp [ρ.trace_one]

@[simp]
theorem nonselectiveState_matrix (M : ProjectiveMeasurement ω ι)
    (ρ : DensityState ι) :
    (M.nonselectiveState ρ).matrix =
      ∑ w, ludersBranchMatrix ρ (M.projector w) :=
  rfl

end ProjectiveMeasurement

/-! ## Pure-state bridge and phase invariance -/

namespace PureState

/-- The raw projected ket before normalization. -/
def projectedKet (ψ : PureState ι) (P : Projection ι) : Ket ι :=
  P.matrix *ᵥ ψ.ket

/-- A pure input's Lüders branch is the outer product of its projected ket. -/
theorem ludersBranchMatrix_toDensity (ψ : PureState ι) (P : Projection ι) :
    ludersBranchMatrix ψ.toDensity P =
      Matrix.vecMulVec (projectedKet ψ P) (star (projectedKet ψ P)) := by
  rw [ludersBranchMatrix, toDensity_matrix, Matrix.mul_vecMulVec,
    Matrix.vecMulVec_mul, projectedKet, Matrix.star_mulVec,
    P.isHermitian.eq]

/-- The projected ket's squared norm is the pure-state outcome probability. -/
theorem coe_outcomeProbability_toDensity (ψ : PureState ι) (P : Projection ι) :
    (outcomeProbability ψ.toDensity P : ℂ) =
      projectedKet ψ P ⬝ᵥ star (projectedKet ψ P) := by
  rw [coe_outcomeProbability, ← trace_ludersBranchMatrix_eq_bornWeight,
    ludersBranchMatrix_toDensity, Matrix.trace_vecMulVec]

/-- A pure branch has nonzero probability exactly when its projected ket is
nonzero. -/
theorem outcomeProbability_toDensity_ne_zero_iff_projectedKet_ne_zero
    (ψ : PureState ι) (P : Projection ι) :
    outcomeProbability ψ.toDensity P ≠ 0 ↔ projectedKet ψ P ≠ 0 := by
  have h := not_congr
    (outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero ψ.toDensity P)
  simpa [ludersBranchMatrix_toDensity] using h

/-- Normalize the projected ket from the same strict positive-probability
evidence used by the density conditional state. -/
noncomputable def conditionalPureState (ψ : PureState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ψ.toDensity P) : PureState ι where
  ket := ((Real.sqrt (outcomeProbability ψ.toDensity P) : ℂ)⁻¹) •
    projectedKet ψ P
  normalized := by
    let p := outcomeProbability ψ.toDensity P
    have hs : Real.sqrt p ≠ 0 := (Real.sqrt_pos.2 h).ne'
    have hnorm := coe_outcomeProbability_toDensity ψ P
    change (((Real.sqrt p : ℂ)⁻¹) • projectedKet ψ P) ⬝ᵥ
      star (((Real.sqrt p : ℂ)⁻¹) • projectedKet ψ P) = 1
    simp only [star_smul, smul_dotProduct, dotProduct_smul, smul_eq_mul]
    rw [← hnorm]
    have hstar : star (Real.sqrt p : ℂ) = (Real.sqrt p : ℂ) :=
      Complex.conj_ofReal _
    rw [star_inv₀, hstar]
    rw [← Complex.ofReal_inv, ← Complex.ofReal_mul, ← Complex.ofReal_mul]
    rw [← Complex.ofReal_one]
    apply Complex.ofReal_inj.mpr
    change (Real.sqrt p)⁻¹ * ((Real.sqrt p)⁻¹ * p) = 1
    field_simp [hs]
    simpa using (Real.sq_sqrt h.le).symm

@[simp]
theorem conditionalPureState_ket (ψ : PureState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ψ.toDensity P) :
    (conditionalPureState ψ P h).ket =
      ((Real.sqrt (outcomeProbability ψ.toDensity P) : ℂ)⁻¹) •
        projectedKet ψ P :=
  rfl

/-- Pure-ket and density-matrix conditioning give the same physical density
state. -/
theorem conditionalPureState_toDensity (ψ : PureState ι) (P : Projection ι)
    (h : 0 < outcomeProbability ψ.toDensity P) :
    (conditionalPureState ψ P h).toDensity =
      conditionalState ψ.toDensity P h := by
  apply DensityState.ext
  let p := outcomeProbability ψ.toDensity P
  let c : ℂ := (Real.sqrt p : ℂ)⁻¹
  have hp : p ≠ 0 := h.ne'
  have hs : Real.sqrt p ≠ 0 := (Real.sqrt_pos.2 h).ne'
  have hstar : star c = c := by
    dsimp [c]
    rw [map_inv₀]
    exact congrArg Inv.inv (Complex.conj_ofReal _)
  rw [toDensity_matrix, conditionalPureState_ket, conditionalState_matrix]
  change Matrix.vecMulVec (c • projectedKet ψ P)
      (star (c • projectedKet ψ P)) =
    ((p : ℂ)⁻¹) • ludersBranchMatrix ψ.toDensity P
  rw [star_smul, hstar, Matrix.smul_vecMulVec, Matrix.vecMulVec_smul,
    smul_smul, ← ludersBranchMatrix_toDensity]
  congr 1
  dsimp [c]
  rw [← Complex.ofReal_inv, ← Complex.ofReal_mul, ← Complex.ofReal_inv]
  apply Complex.ofReal_inj.mpr
  field_simp [hs, hp]
  simpa using (Real.sq_sqrt h.le).symm

/-- Multiply a normalized ket by a unit global phase. -/
def rephase (ψ : PureState ι) (c : ℂ) (hc : c * star c = 1) : PureState ι where
  ket := c • ψ.ket
  normalized := by
    change ∑ x, (c * ψ.ket x) * star (c * ψ.ket x) = 1
    simp_rw [star_mul']
    calc
      ∑ x, c * ψ.ket x * (star c * star (ψ.ket x)) =
          (c * star c) * ∑ x, ψ.ket x * star (ψ.ket x) := by
        rw [Finset.mul_sum]
        apply Finset.sum_congr rfl
        intro x _
        ring
      _ = 1 := by
        rw [hc, one_mul]
        simpa [dotProduct] using ψ.normalized

@[simp]
theorem rephase_ket (ψ : PureState ι) (c : ℂ) (hc : c * star c = 1) :
    (rephase ψ c hc).ket = c • ψ.ket :=
  rfl

/-- Global phase changes the ket representative but not its density state. -/
@[simp]
theorem rephase_toDensity (ψ : PureState ι) (c : ℂ) (hc : c * star c = 1) :
    (rephase ψ c hc).toDensity = ψ.toDensity := by
  apply DensityState.ext
  ext i j
  change c * ψ.ket i * star (c * ψ.ket j) =
    ψ.ket i * star (ψ.ket j)
  rw [star_mul']
  calc
    c * ψ.ket i * (star c * star (ψ.ket j)) =
        (c * star c) * (ψ.ket i * star (ψ.ket j)) := by ring
    _ = ψ.ket i * star (ψ.ket j) := by rw [hc, one_mul]

/-- Projection commutes with a global scalar phase. -/
theorem projectedKet_rephase (ψ : PureState ι) (P : Projection ι)
    (c : ℂ) (hc : c * star c = 1) :
    projectedKet (rephase ψ c hc) P = c • projectedKet ψ P := by
  simp [projectedKet, Matrix.mulVec_smul]

/-- A pure input's normalized conditional density state is global-phase
invariant. This does not assert literal equality of phase-different kets. -/
theorem conditionalState_rephase (ψ : PureState ι) (P : Projection ι)
    (c : ℂ) (hc : c * star c = 1)
    (h : 0 < outcomeProbability ψ.toDensity P) :
    conditionalState (rephase ψ c hc).toDensity P (by simpa using h) =
      conditionalState ψ.toDensity P h := by
  apply DensityState.ext
  rw [conditionalState_matrix, conditionalState_matrix]
  simp [rephase_toDensity]

end PureState

/-! ## Bipartite selected outcomes and conditional marginals -/

section Bipartite

variable {κ : Type*} [Fintype κ] [DecidableEq ι] [DecidableEq κ]

/-- Probability of an A-side local projection in a bipartite state. -/
def localAOutcomeProbability (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) : ℝ :=
  outcomeProbability ρ P.lift

/-- Probability of a B-side local projection in a bipartite state. -/
def localBOutcomeProbability (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) : ℝ :=
  outcomeProbability ρ P.lift

/-- The selected subnormalized joint branch for an A-side projection. -/
def localALudersBranch (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) : SubnormalizedState (BipartiteIndex ι κ) :=
  ludersBranch ρ P.lift

/-- The selected subnormalized joint branch for a B-side projection. -/
def localBLudersBranch (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) : SubnormalizedState (BipartiteIndex ι κ) :=
  ludersBranch ρ P.lift

/-- The subnormalized relative branch of `B` obtained from an A-side selected
projection, before division by its probability. -/
def localARelativeBBranch (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) : SubnormalizedState κ where
  matrix := traceOutA (ludersBranchMatrix ρ P.lift)
  posSemidef := traceOutA_posSemidef
    (ludersBranchMatrix_posSemidef ρ P.lift)
  trace_le_one := by
    rw [trace_traceOutA, trace_ludersBranchMatrix_eq_bornWeight]
    simpa [outcomeProbability] using outcomeProbability_le_one ρ P.lift

/-- The subnormalized relative branch of `A` obtained from a B-side selected
projection, before division by its probability. -/
def localBRelativeABranch (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) : SubnormalizedState ι where
  matrix := traceOutB (ludersBranchMatrix ρ P.lift)
  posSemidef := traceOutB_posSemidef
    (ludersBranchMatrix_posSemidef ρ P.lift)
  trace_le_one := by
    rw [trace_traceOutB, trace_ludersBranchMatrix_eq_bornWeight]
    simpa [outcomeProbability] using outcomeProbability_le_one ρ P.lift

omit [DecidableEq ι] in
@[simp]
theorem localARelativeBBranch_weight (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) :
    (localARelativeBBranch ρ P).weight = localAOutcomeProbability ρ P := by
  unfold SubnormalizedState.weight localARelativeBBranch
    localAOutcomeProbability outcomeProbability
  rw [trace_traceOutA, trace_ludersBranchMatrix_eq_bornWeight]

omit [DecidableEq κ] in
@[simp]
theorem localBRelativeABranch_weight (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) :
    (localBRelativeABranch ρ P).weight = localBOutcomeProbability ρ P := by
  unfold SubnormalizedState.weight localBRelativeABranch
    localBOutcomeProbability outcomeProbability
  rw [trace_traceOutB, trace_ludersBranchMatrix_eq_bornWeight]

/-- The normalized selected joint state after an A-side outcome. -/
noncomputable def localAConditionalJointState (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) (h : 0 < localAOutcomeProbability ρ P) :
    BipartiteState ι κ :=
  conditionalState ρ P.lift h

/-- The normalized selected joint state after a B-side outcome. -/
noncomputable def localBConditionalJointState (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) (h : 0 < localBOutcomeProbability ρ P) :
    BipartiteState ι κ :=
  conditionalState ρ P.lift h

/-- The conditional state of `B` after selecting an A-side projection. -/
noncomputable def localAConditionalBState (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) (h : 0 < localAOutcomeProbability ρ P) :
    DensityState κ :=
  reducedB (localAConditionalJointState ρ P h)

/-- The conditional state of `A` after selecting a B-side projection. -/
noncomputable def localBConditionalAState (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) (h : 0 < localBOutcomeProbability ρ P) :
    DensityState ι :=
  reducedA (localBConditionalJointState ρ P h)

omit [DecidableEq ι] in
/-- Normalizing the relative B branch agrees with reducing the normalized
selected joint state. -/
theorem normalize_localARelativeBBranch
    (ρ : BipartiteState ι κ) (P : LocalProjectionA ι κ)
    (h : 0 < localAOutcomeProbability ρ P) :
    (localARelativeBBranch ρ P).normalize (by simpa using h) =
      localAConditionalBState ρ P h := by
  apply DensityState.ext
  rw [SubnormalizedState.normalize_matrix, localAConditionalBState,
    reducedB_matrix, localAConditionalJointState, conditionalState_matrix,
    localARelativeBBranch_weight]
  exact (map_smul (traceOutALinear (ι := ι) (κ := κ))
    (localAOutcomeProbability ρ P : ℂ)⁻¹
    (ludersBranchMatrix ρ P.lift)).symm

omit [DecidableEq κ] in
/-- Normalizing the relative A branch agrees with reducing the normalized
selected joint state. -/
theorem normalize_localBRelativeABranch
    (ρ : BipartiteState ι κ) (P : LocalProjectionB ι κ)
    (h : 0 < localBOutcomeProbability ρ P) :
    (localBRelativeABranch ρ P).normalize (by simpa using h) =
      localBConditionalAState ρ P h := by
  apply DensityState.ext
  rw [SubnormalizedState.normalize_matrix, localBConditionalAState,
    reducedA_matrix, localBConditionalJointState, conditionalState_matrix,
    localBRelativeABranch_weight]
  exact (map_smul (traceOutBLinear (ι := ι) (κ := κ))
    (localBOutcomeProbability ρ P : ℂ)⁻¹
    (ludersBranchMatrix ρ P.lift)).symm

omit [DecidableEq ι] in
@[simp]
theorem localAConditionalBState_matrix (ρ : BipartiteState ι κ)
    (P : LocalProjectionA ι κ) (h : 0 < localAOutcomeProbability ρ P) :
    (localAConditionalBState ρ P h).matrix =
      traceOutA (((localAOutcomeProbability ρ P : ℂ)⁻¹) •
        ludersBranchMatrix ρ P.lift) := by
  rw [localAConditionalBState, reducedB_matrix,
    localAConditionalJointState, conditionalState_matrix]
  rfl

omit [DecidableEq κ] in
@[simp]
theorem localBConditionalAState_matrix (ρ : BipartiteState ι κ)
    (P : LocalProjectionB ι κ) (h : 0 < localBOutcomeProbability ρ P) :
    (localBConditionalAState ρ P h).matrix =
      traceOutB (((localBOutcomeProbability ρ P : ℂ)⁻¹) •
        ludersBranchMatrix ρ P.lift) := by
  rw [localBConditionalAState, reducedA_matrix,
    localBConditionalJointState, conditionalState_matrix]
  rfl

end Bipartite

end EPR.Quantum
