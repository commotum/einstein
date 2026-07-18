module

public import EPR.Quantum.Conditional
public import Mathlib.Tactic

/-!
# Conditional-state diagnostics

These executable checks cover a proper rank-two projection on `Fin 3`, a
nonzero but zero-probability branch, both selected branches of a complete
two-outcome measurement, nonselective dephasing, coherence inside a degenerate
range, global phase, and one nonmaximally correlated bipartite example. They
contain no Bell/Pauli setting, perfect-prediction package, no-signalling
theorem, or interpretative premise.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Audit.Conditional

open EPR EPR.Quantum

/-! ## A proper degenerate `Fin 3` projective measurement -/

abbrev Three := Fin 3
abbrev TwoOutcomes := Fin 2

@[simp] theorem three_zero_ne_one : (0 : Three) ≠ 1 := by decide
@[simp] theorem three_zero_ne_two : (0 : Three) ≠ 2 := by decide
@[simp] theorem three_one_ne_zero : (1 : Three) ≠ 0 := by decide
@[simp] theorem three_one_ne_two : (1 : Three) ≠ 2 := by decide
@[simp] theorem three_two_ne_zero : (2 : Three) ≠ 0 := by decide
@[simp] theorem three_two_ne_one : (2 : Three) ≠ 1 := by decide

def rankTwoMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i.val = 2 then 0 else 1

def rankOneMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i.val = 2 then 1 else 0

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

def rankOneProjection : Projection Three where
  matrix := rankOneMatrix
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [rankOneMatrix, Matrix.diagonal, Matrix.conjTranspose]
  idempotent := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [rankOneMatrix, Matrix.mul_apply, Matrix.diagonal]

def degenerateProjector (w : TwoOutcomes) : Projection Three :=
  if w = 0 then rankTwoProjection else rankOneProjection

theorem rankTwoProjection_nonzero : rankTwoProjection.matrix ≠ 0 := by
  intro h
  have h00 := congrFun (congrFun h (0 : Three)) (0 : Three)
  simp [rankTwoProjection, rankTwoMatrix, Matrix.diagonal] at h00

theorem rankOneProjection_nonzero : rankOneProjection.matrix ≠ 0 := by
  intro h
  have h22 := congrFun (congrFun h (2 : Three)) (2 : Three)
  norm_num [rankOneProjection, rankOneMatrix, Matrix.diagonal] at h22

theorem rankTwoProjection_ne_identity :
    rankTwoProjection.matrix ≠ (1 : Operator Three) := by
  intro h
  have h22 := congrFun (congrFun h (2 : Three)) (2 : Three)
  norm_num [rankTwoProjection, rankTwoMatrix, Matrix.diagonal] at h22

theorem rankTwo_supports_two_basis_vectors :
    rankTwoProjection.matrix *ᵥ (Pi.single (0 : Three) 1) = Pi.single 0 1 ∧
      rankTwoProjection.matrix *ᵥ (Pi.single (1 : Three) 1) = Pi.single 1 1 := by
  constructor <;> funext i <;> fin_cases i <;>
    simp [rankTwoProjection, rankTwoMatrix, Matrix.mulVec, dotProduct,
      Matrix.diagonal]

def degeneratePVM : ProjectiveMeasurement TwoOutcomes Three where
  projector := degenerateProjector
  nonzero := by
    intro w
    fin_cases w
    · simpa [degenerateProjector] using rankTwoProjection_nonzero
    · simpa [degenerateProjector] using rankOneProjection_nonzero
  orthogonal := by
    intro w v hwv
    fin_cases w <;> fin_cases v
    · exact (hwv rfl).elim
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [degenerateProjector, rankTwoProjection, rankOneProjection,
          rankTwoMatrix, rankOneMatrix, Matrix.mul_apply, Matrix.diagonal]
    · ext i j
      fin_cases i <;> fin_cases j <;>
        simp [degenerateProjector, rankTwoProjection, rankOneProjection,
          rankTwoMatrix, rankOneMatrix, Matrix.mul_apply, Matrix.diagonal]
    · exact (hwv rfl).elim
  complete := by
    rw [Fin.sum_univ_two]
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [degenerateProjector, rankTwoProjection, rankOneProjection,
        rankTwoMatrix, rankOneMatrix, Matrix.diagonal]

def basisZeroThree : PureState Three where
  ket := Pi.single 0 1
  normalized := by
    rw [single_one_dotProduct]
    simp

/-! The second, nonzero projection is impossible in this input state. -/

theorem basisZero_positive_branch :
    degeneratePVM.probability basisZeroThree.toDensity 0 = 1 := by
  norm_num [ProjectiveMeasurement.probability, degeneratePVM, degenerateProjector,
    outcomeProbability, bornWeight, basisZeroThree, PureState.toDensity_matrix_apply,
    rankTwoProjection, rankTwoMatrix, Matrix.trace, Matrix.mul_apply,
    Matrix.vecMulVec_apply, Matrix.diagonal, Fin.sum_univ_three]

theorem basisZero_zero_branch :
    degeneratePVM.probability basisZeroThree.toDensity 1 = 0 := by
  norm_num [ProjectiveMeasurement.probability, degeneratePVM, degenerateProjector,
    outcomeProbability, bornWeight, basisZeroThree, PureState.toDensity_matrix_apply,
    rankOneProjection, rankOneMatrix, Matrix.trace, Matrix.mul_apply,
    Matrix.vecMulVec_apply, Matrix.diagonal, Fin.sum_univ_three]

theorem basisZero_zero_branch_matrix :
    ludersBranchMatrix basisZeroThree.toDensity (degeneratePVM.projector 1) = 0 := by
  rw [← outcomeProbability_eq_zero_iff_ludersBranchMatrix_eq_zero]
  exact basisZero_zero_branch

theorem basisZero_zero_branch_not_conditionable :
    ¬ 0 < degeneratePVM.probability basisZeroThree.toDensity 1 := by
  rw [basisZero_zero_branch]
  norm_num

/-! A coherent input spanning both outcomes checks both normalized branches
and nonselective dephasing. -/

noncomputable def coherentKet : Ket Three :=
  fun i ↦
    if i.val = 0 then (3 / 5 : ℂ)
    else if i.val = 2 then (4 / 5 : ℂ)
    else 0

noncomputable def coherentState : PureState Three where
  ket := coherentKet
  normalized := by
    norm_num [dotProduct, Fin.sum_univ_three, coherentKet, Complex.star_def,
      map_div₀, map_ofNat, three_zero_ne_two, three_one_ne_zero,
      three_one_ne_two, three_two_ne_zero]

theorem coherent_probability_rankTwo :
    degeneratePVM.probability coherentState.toDensity 0 = 9 / 25 := by
  norm_num [ProjectiveMeasurement.probability, degeneratePVM, degenerateProjector,
    outcomeProbability, bornWeight, coherentState, coherentKet,
    PureState.toDensity_matrix_apply, rankTwoProjection, rankTwoMatrix,
    Matrix.trace, Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.diagonal,
    Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat]

theorem coherent_probability_rankOne :
    degeneratePVM.probability coherentState.toDensity 1 = 16 / 25 := by
  norm_num [ProjectiveMeasurement.probability, degeneratePVM, degenerateProjector,
    outcomeProbability, bornWeight, coherentState, coherentKet,
    PureState.toDensity_matrix_apply, rankOneProjection, rankOneMatrix,
    Matrix.trace, Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.diagonal,
    Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat]

theorem coherent_probability_sum :
    ∑ w, degeneratePVM.probability coherentState.toDensity w = 1 :=
  degeneratePVM.probability_sum coherentState.toDensity

theorem coherent_rankTwo_probability :
    outcomeProbability coherentState.toDensity rankTwoProjection = 9 / 25 := by
  simpa [ProjectiveMeasurement.probability, degeneratePVM,
    degenerateProjector] using coherent_probability_rankTwo

theorem coherent_rankOne_probability :
    outcomeProbability coherentState.toDensity rankOneProjection = 16 / 25 := by
  simpa [ProjectiveMeasurement.probability, degeneratePVM,
    degenerateProjector] using coherent_probability_rankOne

def zeroThreeDensityMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i.val = 0 then 1 else 0

def lastThreeDensityMatrix : Operator Three :=
  Matrix.diagonal fun i ↦ if i.val = 2 then 1 else 0

theorem coherent_conditional_rankTwo :
    (conditionalState coherentState.toDensity rankTwoProjection
      (by rw [coherent_rankTwo_probability]; norm_num)).matrix =
        zeroThreeDensityMatrix := by
  rw [conditionalState_matrix, coherent_rankTwo_probability]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [ludersBranchMatrix, rankTwoProjection, rankTwoMatrix,
      coherentState, coherentKet, zeroThreeDensityMatrix,
      PureState.toDensity_matrix_apply, Matrix.mul_apply,
      Matrix.vecMulVec_apply, Matrix.diagonal,
      Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat]

theorem coherent_conditional_rankOne :
    (conditionalState coherentState.toDensity rankOneProjection
      (by rw [coherent_rankOne_probability]; norm_num)).matrix =
        lastThreeDensityMatrix := by
  rw [conditionalState_matrix, coherent_rankOne_probability]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [ludersBranchMatrix, rankOneProjection, rankOneMatrix,
      coherentState, coherentKet, lastThreeDensityMatrix,
      PureState.toDensity_matrix_apply, Matrix.mul_apply,
      Matrix.vecMulVec_apply, Matrix.diagonal,
      Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat];
    try { apply Fin.ext; rfl }

noncomputable def dephasedMatrix : Operator Three :=
  Matrix.diagonal fun i ↦
    if i.val = 0 then (9 / 25 : ℂ)
    else if i.val = 2 then (16 / 25 : ℂ)
    else 0

theorem coherent_nonselective_dephases :
    (degeneratePVM.nonselectiveState coherentState.toDensity).matrix =
      dephasedMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [ProjectiveMeasurement.nonselectiveState_matrix, degeneratePVM,
      degenerateProjector, ludersBranchMatrix, coherentState, coherentKet,
      PureState.toDensity_matrix_apply, rankTwoProjection, rankOneProjection,
      rankTwoMatrix, rankOneMatrix, dephasedMatrix, Matrix.trace,
      Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.diagonal,
      Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat];
    try { apply Fin.ext; rfl }

theorem coherent_nonselective_ne_input :
    degeneratePVM.nonselectiveState coherentState.toDensity ≠
      coherentState.toDensity := by
  intro h
  have h02 := congrArg (fun ρ ↦ ρ.matrix (0 : Three) (2 : Three)) h
  rw [coherent_nonselective_dephases] at h02
  norm_num [dephasedMatrix, Matrix.diagonal, coherentState, coherentKet,
    PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply,
    Complex.star_def, map_div₀, map_ofNat] at h02

/-! A superposition entirely inside the rank-two range keeps its coherence. -/

noncomputable def insideKet : Ket Three :=
  fun i ↦
    if i.val = 0 then (3 / 5 : ℂ)
    else if i.val = 1 then (4 / 5 : ℂ)
    else 0

noncomputable def insideState : PureState Three where
  ket := insideKet
  normalized := by
    norm_num [dotProduct, Fin.sum_univ_three, insideKet, Complex.star_def,
      map_div₀, map_ofNat]

theorem inside_rankTwo_probability :
    outcomeProbability insideState.toDensity rankTwoProjection = 1 := by
  norm_num [outcomeProbability, bornWeight, insideState, insideKet,
    PureState.toDensity_matrix_apply, rankTwoProjection, rankTwoMatrix,
    Matrix.trace, Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.diagonal,
    Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat]

theorem inside_conditional_preserves_coherence :
    conditionalState insideState.toDensity rankTwoProjection
      (by rw [inside_rankTwo_probability]; norm_num) = insideState.toDensity := by
  apply DensityState.ext
  rw [conditionalState_matrix, inside_rankTwo_probability]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [ludersBranchMatrix, insideState, insideKet,
      PureState.toDensity_matrix_apply, rankTwoProjection, rankTwoMatrix,
      Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.diagonal,
      Fin.sum_univ_three, Complex.star_def, map_div₀, map_ofNat]

theorem inside_coherence_nonzero :
    (conditionalState insideState.toDensity rankTwoProjection
      (by rw [inside_rankTwo_probability]; norm_num)).matrix 0 1 = 12 / 25 := by
  rw [inside_conditional_preserves_coherence]
  norm_num [insideState, insideKet, PureState.toDensity_matrix_apply,
    Complex.star_def, map_div₀, map_ofNat]

/-! Global phase changes the ket but not density-level conditioning. -/

theorem imaginary_unit_phase : Complex.I * star Complex.I = 1 := by
  norm_num [Complex.star_def]

noncomputable def phasedCoherentState : PureState Three :=
  coherentState.rephase Complex.I imaginary_unit_phase

theorem phasedCoherent_ket_ne : phasedCoherentState.ket ≠ coherentState.ket := by
  intro h
  have h0 := congrFun h (0 : Three)
  norm_num [phasedCoherentState, coherentState, coherentKet,
    PureState.rephase_ket] at h0
  have him := congrArg Complex.im h0
  norm_num at him

theorem phasedCoherent_density_eq :
    phasedCoherentState.toDensity = coherentState.toDensity := by
  exact PureState.rephase_toDensity coherentState Complex.I imaginary_unit_phase

theorem phasedCoherent_conditional_eq :
    conditionalState phasedCoherentState.toDensity rankTwoProjection
        (by rw [phasedCoherent_density_eq, coherent_rankTwo_probability]; norm_num) =
      conditionalState coherentState.toDensity rankTwoProjection
        (by rw [coherent_rankTwo_probability]; norm_num) := by
  have hp : 0 < outcomeProbability coherentState.toDensity rankTwoProjection := by
    rw [coherent_rankTwo_probability]
    norm_num
  unfold phasedCoherentState
  exact PureState.conditionalState_rephase coherentState rankTwoProjection
    Complex.I imaginary_unit_phase hp

/-! ## A nonmaximal, non-Bell bipartite conditioning audit -/

abbrev Qubit := Fin 2

noncomputable def biasedKet : Ket (BipartiteIndex Qubit Qubit) :=
  fun p ↦
    if p = ((0 : Qubit), (0 : Qubit)) then (3 / 5 : ℂ)
    else if p = ((1 : Qubit), (1 : Qubit)) then (4 / 5 : ℂ)
    else 0

noncomputable def biasedState : BipartitePureState Qubit Qubit where
  ket := biasedKet
  normalized := by
    norm_num [dotProduct, Fintype.sum_prod_type, Fin.sum_univ_two,
      biasedKet, Complex.star_def, map_div₀, map_ofNat]

def qubitZeroProjection : Projection Qubit where
  matrix := Matrix.single 0 0 1
  isHermitian := by
    unfold Matrix.IsHermitian
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.conjTranspose]
  idempotent := by
    ext i j
    fin_cases i <;> fin_cases j <;>
      simp [Matrix.single_apply, Matrix.mul_apply]

def localAZero : LocalProjectionA Qubit Qubit where
  projection := qubitZeroProjection

def zeroDensityMatrix : Operator Qubit := Matrix.single 0 0 1

theorem biased_local_probability :
    localAOutcomeProbability biasedState.toDensity localAZero = 9 / 25 := by
  norm_num [localAOutcomeProbability, outcomeProbability, bornWeight, localAZero,
    LocalProjectionA.lift, qubitZeroProjection, biasedState, biasedKet,
    PureState.toDensity_matrix_apply, Matrix.trace, Matrix.mul_apply,
    Matrix.vecMulVec_apply, Matrix.single_apply, Fin.sum_univ_two,
    Fintype.sum_prod_type, Complex.star_def, map_div₀, map_ofNat]

theorem biased_conditionalB_is_zero :
    (localAConditionalBState biasedState.toDensity localAZero
      (by rw [biased_local_probability]; norm_num)).matrix = zeroDensityMatrix := by
  rw [localAConditionalBState_matrix, biased_local_probability]
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [ludersBranchMatrix, localAZero, LocalProjectionA.lift,
      qubitZeroProjection, biasedState, biasedKet, zeroDensityMatrix,
      PureState.toDensity_matrix_apply, traceOutA_apply, Matrix.trace,
      Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.single_apply,
      Fin.sum_univ_two, Fintype.sum_prod_type, Complex.star_def,
      map_div₀, map_ofNat]

noncomputable def biasedReducedMatrix : Operator Qubit :=
  Matrix.diagonal fun i ↦ if i = 0 then (9 / 25 : ℂ) else (16 / 25 : ℂ)

theorem biased_reducedB :
    (reducedB biasedState.toDensity).matrix = biasedReducedMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [reducedB_matrix, traceOutA_apply, biasedState, biasedKet,
      biasedReducedMatrix, PureState.toDensity_matrix_apply,
      Matrix.vecMulVec_apply, Matrix.diagonal, Fin.sum_univ_two,
      Complex.star_def, map_div₀, map_ofNat]

theorem biased_conditionalB_ne_reducedB :
    localAConditionalBState biasedState.toDensity localAZero
      (by rw [biased_local_probability]; norm_num) ≠
        reducedB biasedState.toDensity := by
  intro h
  have h11 := congrArg (fun ρ ↦ ρ.matrix (1 : Qubit) (1 : Qubit)) h
  rw [biased_conditionalB_is_zero, biased_reducedB] at h11
  norm_num [zeroDensityMatrix, biasedReducedMatrix, Matrix.single_apply,
    Matrix.diagonal] at h11

end EPR.Audit.Conditional
