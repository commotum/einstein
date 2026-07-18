module

public import EPR.Audit.BellSteering

/-!
# Bell-steering signature and axiom audit

This diagnostic leaf checks the generic steering package, the principal
four-branch Bell/Pauli results, and the executable convention sentinels. It is
not part of the public `EPR` import chain.
-/

namespace EPR.Audit.BellSteeringAxioms

/-! ## Generic operational package signatures -/

#check EPR.Quantum.PerfectConditionalPrediction
#check EPR.Quantum.PerfectConditionalPrediction.source_positive
#check EPR.Quantum.PerfectConditionalPrediction.target_certain

#check EPR.Quantum.SteeringScenario
#check EPR.Quantum.SteeringScenario.sourceObservable
#check EPR.Quantum.SteeringScenario.sourceOutcome
#check EPR.Quantum.SteeringScenario.sourceMeasurement
#check EPR.Quantum.SteeringScenario.sourceProjector_eq
#check EPR.Quantum.SteeringScenario.targetObservable
#check EPR.Quantum.SteeringScenario.targetOutcome
#check EPR.Quantum.SteeringScenario.response
#check EPR.Quantum.SteeringScenario.predicts

/-! ## Principal concrete API signatures -/

#check EPR.Examples.BellSteering.bellPhiPlus
#check EPR.Examples.BellSteering.bellPhiPlus_z_expansion
#check EPR.Examples.BellSteering.bellPhiPlus_x_expansion
#check EPR.Examples.BellSteering.pauliZMeasurement
#check EPR.Examples.BellSteering.pauliXMeasurement
#check EPR.Examples.BellSteering.bellPhiPlus_probability
#check EPR.Examples.BellSteering.bellPhiPlus_branchPositive
#check EPR.Examples.BellSteering.bellPhiPlus_relativeB_matrix
#check EPR.Examples.BellSteering.bellPhiPlus_relativeB_weight
#check EPR.Examples.BellSteering.bellPhiPlus_conditionalB
#check EPR.Examples.BellSteering.bellPhiPlus_target_probability_one
#check EPR.Examples.BellSteering.bellPhiPlus_perfectPrediction
#check EPR.Examples.BellSteering.bellPhiPlus_opposite_probability_zero
#check EPR.Examples.BellSteering.bellPhiPlus_conditional_sharpValue
#check EPR.Examples.BellSteering.bellPhiPlusSteeringScenario

/-! ## Normalization, state convention, and expansion trust -/

#print axioms EPR.Examples.BellSteering.invSqrtTwoReal_sq
#print axioms EPR.Examples.BellSteering.invSqrtTwo_sq
#print axioms EPR.Examples.BellSteering.zState
#print axioms EPR.Examples.BellSteering.xState
#print axioms EPR.Examples.BellSteering.bellPhiPlus
#print axioms EPR.Examples.BellSteering.bellPhiPlus_basis_convention
#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_expansion
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_expansion
#print axioms EPR.Examples.BellSteering.bellPhiPlus_not_product

/-! ## Spectral outcomes and complete measurements -/

#print axioms EPR.Examples.BellSteering.zState_isEigenstate
#print axioms EPR.Examples.BellSteering.xState_isEigenstate
#print axioms EPR.Examples.BellSteering.pauliZOutcome
#print axioms EPR.Examples.BellSteering.pauliXOutcome
#print axioms EPR.Examples.BellSteering.pauliZMeasurement
#print axioms EPR.Examples.BellSteering.pauliXMeasurement

/-! ## All-setting branch, conditioning, and prediction results -/

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_probability
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_probability
#print axioms EPR.Examples.BellSteering.bellPhiPlus_probability
#print axioms EPR.Examples.BellSteering.bellPhiPlus_branchPositive

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_relativeB_matrix
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_relativeB_matrix
#print axioms EPR.Examples.BellSteering.bellPhiPlus_relativeB_matrix
#print axioms EPR.Examples.BellSteering.bellPhiPlus_relativeB_weight

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_conditionalB
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_conditionalB
#print axioms EPR.Examples.BellSteering.bellPhiPlus_conditionalB

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_target_probability_one
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_target_probability_one
#print axioms EPR.Examples.BellSteering.bellPhiPlus_target_probability_one
#print axioms EPR.Examples.BellSteering.bellPhiPlus_perfectPrediction

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_opposite_probability_zero
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_opposite_probability_zero
#print axioms EPR.Examples.BellSteering.bellPhiPlus_opposite_probability_zero

#print axioms EPR.Examples.BellSteering.bellPhiPlus_z_conditional_sharpValue
#print axioms EPR.Examples.BellSteering.bellPhiPlus_x_conditional_sharpValue
#print axioms EPR.Examples.BellSteering.bellPhiPlus_conditional_sharpValue
#print axioms EPR.Examples.BellSteering.bellPhiPlusSteeringScenario

/-! ## Executable four-branch and convention sentinels -/

#check EPR.Audit.BellSteering.bell_basis_table
#check EPR.Audit.BellSteering.outcome_value_table
#check EPR.Audit.BellSteering.localAZPlus_lift_tensor_order
#check EPR.Audit.BellSteering.both_bell_expansions
#check EPR.Audit.BellSteering.four_branch_probabilities
#check EPR.Audit.BellSteering.four_raw_branch_weights
#check EPR.Audit.BellSteering.four_raw_branch_matrices
#check EPR.Audit.BellSteering.xMinus_raw_offDiagonal
#check EPR.Audit.BellSteering.four_conditional_states
#check EPR.Audit.BellSteering.xMinus_conditional_offDiagonal
#check EPR.Audit.BellSteering.four_matching_probabilities
#check EPR.Audit.BellSteering.four_opposite_probabilities
#check EPR.Audit.BellSteering.four_sharp_values
#check EPR.Audit.BellSteering.four_prediction_branches_positive
#check EPR.Audit.BellSteering.scenario_response_table

#print axioms EPR.Audit.BellSteering.bell_basis_table
#print axioms EPR.Audit.BellSteering.outcome_value_table
#print axioms EPR.Audit.BellSteering.localAZPlus_lift_tensor_order
#print axioms EPR.Audit.BellSteering.both_bell_expansions
#print axioms EPR.Audit.BellSteering.four_branch_probabilities
#print axioms EPR.Audit.BellSteering.four_raw_branch_weights
#print axioms EPR.Audit.BellSteering.four_raw_branch_matrices
#print axioms EPR.Audit.BellSteering.xMinus_raw_offDiagonal
#print axioms EPR.Audit.BellSteering.four_conditional_states
#print axioms EPR.Audit.BellSteering.xMinus_conditional_offDiagonal
#print axioms EPR.Audit.BellSteering.four_matching_probabilities
#print axioms EPR.Audit.BellSteering.four_opposite_probabilities
#print axioms EPR.Audit.BellSteering.four_sharp_values
#print axioms EPR.Audit.BellSteering.four_prediction_branches_positive
#print axioms EPR.Audit.BellSteering.scenario_response_table

end EPR.Audit.BellSteeringAxioms
