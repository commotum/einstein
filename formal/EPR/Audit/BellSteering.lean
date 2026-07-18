module

public import EPR.Examples.BellSteering
public import Mathlib.Tactic

/-!
# Bell-steering diagnostics

These executable checks make all four Pauli setting/outcome branches visible,
including raw and normalized relative states, probability-one matching
predictions, impossible opposite outcomes, signed sharp values, and ordered
tensor-factor conventions. They audit operational conditional-state facts
only and introduce no later-stage premise or conclusion.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Audit.BellSteering

open EPR EPR.Quantum EPR.Examples.BellSteering

noncomputable section

/-! ## Basis, sign, and tensor-order sentinels -/

theorem bell_basis_table :
    bellPhiPlus.ket (0, 0) = invSqrtTwo ∧
      bellPhiPlus.ket (1, 1) = invSqrtTwo ∧
      bellPhiPlus.ket (0, 1) = 0 ∧
      bellPhiPlus.ket (1, 0) = 0 :=
  bellPhiPlus_basis_convention

theorem outcome_value_table :
    outcomeValue 0 = 1 ∧ outcomeValue 1 = -1 := by
  norm_num [outcomeValue]

/-- An A-side `Z+` lift accepts `(A=0,B=1)` but rejects `(A=1,B=0)`.
This distinguishes the ordered `A × B` lift even though `|Φ⁺⟩` itself is
swap-symmetric. -/
theorem localAZPlus_lift_tensor_order :
    (localAProjection .z 0).lift.matrix
        (0, 1) (0, 1) = 1 ∧
      (localAProjection .z 0).lift.matrix
        (1, 0) (1, 0) = 0 := by
  constructor <;>
    norm_num [localAProjection, settingMeasurement, pauliZMeasurement,
      zProjection, stateProjection, zState, zKet, LocalProjectionA.lift,
      PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply]

theorem both_bell_expansions :
    bellPhiPlus.ket =
        invSqrtTwo • tensorKet (zState 0).ket (zState 0).ket +
        invSqrtTwo • tensorKet (zState 1).ket (zState 1).ket ∧
      bellPhiPlus.ket =
        invSqrtTwo • tensorKet (xState 0).ket (xState 0).ket +
        invSqrtTwo • tensorKet (xState 1).ket (xState 1).ket :=
  ⟨bellPhiPlus_z_expansion, bellPhiPlus_x_expansion⟩

/-! ## Exhaustive four-branch checks -/

theorem four_branch_probabilities :
    localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .z 0) = 1 / 2 ∧
      localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .z 1) = 1 / 2 ∧
      localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .x 0) = 1 / 2 ∧
      localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .x 1) = 1 / 2 :=
  ⟨bellPhiPlus_z_probability 0, bellPhiPlus_z_probability 1,
    bellPhiPlus_x_probability 0, bellPhiPlus_x_probability 1⟩

theorem four_raw_branch_weights :
    (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .z 0)).weight = 1 / 2 ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .z 1)).weight = 1 / 2 ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .x 0)).weight = 1 / 2 ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .x 1)).weight = 1 / 2 :=
  ⟨bellPhiPlus_relativeB_weight .z 0,
    bellPhiPlus_relativeB_weight .z 1,
    bellPhiPlus_relativeB_weight .x 0,
    bellPhiPlus_relativeB_weight .x 1⟩

theorem four_raw_branch_matrices :
    (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .z 0)).matrix =
          (1 / 2 : ℂ) • (zState 0).toDensity.matrix ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .z 1)).matrix =
          (1 / 2 : ℂ) • (zState 1).toDensity.matrix ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .x 0)).matrix =
          (1 / 2 : ℂ) • (xState 0).toDensity.matrix ∧
      (localARelativeBBranch bellPhiPlus.toDensity
        (localAProjection .x 1)).matrix =
          (1 / 2 : ℂ) • (xState 1).toDensity.matrix :=
  ⟨bellPhiPlus_z_relativeB_matrix 0,
    bellPhiPlus_z_relativeB_matrix 1,
    bellPhiPlus_x_relativeB_matrix 0,
    bellPhiPlus_x_relativeB_matrix 1⟩

/-- The raw X-minus branch has the required negative off-diagonal sign:
`(1/2)|-⟩⟨-|` has entry `-1/4`. -/
theorem xMinus_raw_offDiagonal :
    (localARelativeBBranch bellPhiPlus.toDensity
      (localAProjection .x 1)).matrix 0 1 = (-1 / 4 : ℂ) := by
  rw [bellPhiPlus_x_relativeB_matrix]
  norm_num [xState, xKet, PureState.toDensity_matrix_apply,
    Matrix.vecMulVec_apply, star_invSqrtTwo, invSqrtTwo_sq]

theorem four_conditional_states :
    localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) =
          (zState 0).toDensity ∧
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 1) (bellPhiPlus_branchPositive .z 1) =
          (zState 1).toDensity ∧
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0) =
          (xState 0).toDensity ∧
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 1) (bellPhiPlus_branchPositive .x 1) =
          (xState 1).toDensity :=
  ⟨bellPhiPlus_z_conditionalB 0 _, bellPhiPlus_z_conditionalB 1 _,
    bellPhiPlus_x_conditionalB 0 _, bellPhiPlus_x_conditionalB 1 _⟩

/-- After normalization, the X-minus conditional density has entry `-1/2`. -/
theorem xMinus_conditional_offDiagonal :
    (localAConditionalBState bellPhiPlus.toDensity
      (localAProjection .x 1) (bellPhiPlus_branchPositive .x 1)).matrix
        0 1 = (-1 / 2 : ℂ) := by
  rw [bellPhiPlus_x_conditionalB]
  norm_num [xState, xKet, PureState.toDensity_matrix_apply,
    Matrix.vecMulVec_apply, star_invSqrtTwo, invSqrtTwo_sq]

theorem four_matching_probabilities :
    outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0))
        (pauliZOutcome 0).projector = 1 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .z 1) (bellPhiPlus_branchPositive .z 1))
        (pauliZOutcome 1).projector = 1 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0))
        (pauliXOutcome 0).projector = 1 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .x 1) (bellPhiPlus_branchPositive .x 1))
        (pauliXOutcome 1).projector = 1 :=
  ⟨bellPhiPlus_z_target_probability_one 0 _,
    bellPhiPlus_z_target_probability_one 1 _,
    bellPhiPlus_x_target_probability_one 0 _,
    bellPhiPlus_x_target_probability_one 1 _⟩

theorem four_opposite_probabilities :
    outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0))
        (pauliZOutcome 1).projector = 0 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .z 1) (bellPhiPlus_branchPositive .z 1))
        (pauliZOutcome 0).projector = 0 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0))
        (pauliXOutcome 1).projector = 0 ∧
      outcomeProbability
        (localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .x 1) (bellPhiPlus_branchPositive .x 1))
        (pauliXOutcome 0).projector = 0 :=
  ⟨bellPhiPlus_z_opposite_probability_zero 0 _,
    bellPhiPlus_z_opposite_probability_zero 1 _,
    bellPhiPlus_x_opposite_probability_zero 0 _,
    bellPhiPlus_x_opposite_probability_zero 1 _⟩

theorem four_sharp_values :
    (localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0)).SharpValue
          pauliZ 1 ∧
      (localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 1) (bellPhiPlus_branchPositive .z 1)).SharpValue
          pauliZ (-1) ∧
      (localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0)).SharpValue
          pauliX 1 ∧
      (localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 1) (bellPhiPlus_branchPositive .x 1)).SharpValue
          pauliX (-1) := by
  constructor
  · simpa [outcomeValue] using
      bellPhiPlus_z_conditional_sharpValue 0
        (bellPhiPlus_branchPositive .z 0)
  constructor
  · simpa [outcomeValue] using
      bellPhiPlus_z_conditional_sharpValue 1
        (bellPhiPlus_branchPositive .z 1)
  constructor
  · simpa [outcomeValue] using
      bellPhiPlus_x_conditional_sharpValue 0
        (bellPhiPlus_branchPositive .x 0)
  · simpa [outcomeValue] using
      bellPhiPlus_x_conditional_sharpValue 1
        (bellPhiPlus_branchPositive .x 1)

/-! ## Packaged nonvacuity and coverage -/

theorem four_prediction_branches_positive :
    0 < localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .z 0) ∧
      0 < localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .z 1) ∧
      0 < localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .x 0) ∧
      0 < localAOutcomeProbability bellPhiPlus.toDensity
        (localAProjection .x 1) :=
  ⟨(bellPhiPlus_perfectPrediction .z 0).source_positive,
    (bellPhiPlus_perfectPrediction .z 1).source_positive,
    (bellPhiPlus_perfectPrediction .x 0).source_positive,
    (bellPhiPlus_perfectPrediction .x 1).source_positive⟩

theorem scenario_response_table :
    bellPhiPlusSteeringScenario.response .z 0 = 0 ∧
      bellPhiPlusSteeringScenario.response .z 1 = 1 ∧
      bellPhiPlusSteeringScenario.response .x 0 = 0 ∧
      bellPhiPlusSteeringScenario.response .x 1 = 1 := by
  decide

end


end EPR.Audit.BellSteering
