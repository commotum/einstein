module

import EPR

/-!
# Complementary public-theorem axiom audit

The stage-specific axiom leaves already print 132 of the 203 theorem
declarations in public modules. This private leaf prints the remaining 71, so
the aggregate Stage 10 target has declaration-complete public theorem
coverage. It also prints the two generic steering structures whose fields
carry the nonvacuous prediction interface.

This module imports only the public `EPR` root and is not re-exported by it.
-/

namespace EPR.Audit.PublicTheoremAxioms

/-! ## Quantum core: 9 previously unprinted public theorems -/

#print axioms EPR.Quantum.PureState.ext
#print axioms EPR.Quantum.PureState.star_dot_normalized
#print axioms EPR.Quantum.DensityState.ext
#print axioms EPR.Quantum.DensityState.isHermitian
#print axioms EPR.Quantum.PureState.toDensity_matrix
#print axioms EPR.Quantum.PureState.toDensity_matrix_apply
#print axioms EPR.Quantum.Observable.ext
#print axioms EPR.Quantum.Projection.ext
#print axioms EPR.Quantum.DensityState.trace_mul_eq_of_sharpValue

/-! ## Bipartite layer: 15 previously unprinted public theorems -/

#print axioms EPR.Quantum.tensorKet_apply
#print axioms EPR.Quantum.tensorKet_dot_star
#print axioms EPR.Quantum.PureState.tensor_ket
#print axioms EPR.Quantum.DensityState.tensor_matrix
#print axioms EPR.Quantum.vecMulVec_tensorKet
#print axioms EPR.Quantum.traceOutA_apply
#print axioms EPR.Quantum.traceOutB_apply
#print axioms EPR.Quantum.traceOutA_sum
#print axioms EPR.Quantum.traceOutB_sum
#print axioms EPR.Quantum.traceOutA_kronecker
#print axioms EPR.Quantum.traceOutB_kronecker
#print axioms EPR.Quantum.reducedA_matrix
#print axioms EPR.Quantum.reducedB_matrix
#print axioms EPR.Quantum.LocalOperatorA.ext
#print axioms EPR.Quantum.LocalOperatorB.ext

/-! ## Conditional layer: 27 previously unprinted public theorems -/

#print axioms EPR.Quantum.Projection.complement_matrix
#print axioms EPR.Quantum.SubnormalizedState.ext
#print axioms EPR.Quantum.SubnormalizedState.weight_nonneg
#print axioms EPR.Quantum.SubnormalizedState.weight_le_one
#print axioms EPR.Quantum.SubnormalizedState.coe_weight
#print axioms EPR.Quantum.SubnormalizedState.weight_eq_zero_iff_matrix_eq_zero
#print axioms EPR.Quantum.SubnormalizedState.normalize_matrix
#print axioms EPR.Quantum.trace_ludersBranchMatrix_eq_bornWeight
#print axioms EPR.Quantum.trace_ludersBranchMatrix
#print axioms EPR.Quantum.outcomeProbability_nonneg
#print axioms EPR.Quantum.outcomeProbability_complement
#print axioms EPR.Quantum.outcomeProbability_le_one
#print axioms EPR.Quantum.ludersBranch_matrix
#print axioms EPR.Quantum.ludersBranch_weight
#print axioms EPR.Quantum.conditionalState_matrix
#print axioms EPR.Quantum.ProjectiveMeasurement.probability_nonneg
#print axioms EPR.Quantum.ProjectiveMeasurement.probability_le_one
#print axioms EPR.Quantum.ProjectiveMeasurement.nonselectiveState_matrix
#print axioms EPR.Quantum.PureState.coe_outcomeProbability_toDensity
#print axioms EPR.Quantum.PureState.outcomeProbability_toDensity_ne_zero_iff_projectedKet_ne_zero
#print axioms EPR.Quantum.PureState.conditionalPureState_ket
#print axioms EPR.Quantum.PureState.rephase_ket
#print axioms EPR.Quantum.PureState.projectedKet_rephase
#print axioms EPR.Quantum.localARelativeBBranch_weight
#print axioms EPR.Quantum.localBRelativeABranch_weight
#print axioms EPR.Quantum.localAConditionalBState_matrix
#print axioms EPR.Quantum.localBConditionalAState_matrix

/-! ## Bell steering: 20 previously unprinted public theorems -/

#print axioms EPR.Examples.BellSteering.star_invSqrtTwo
#print axioms EPR.Examples.BellSteering.invSqrtTwo_mul_star
#print axioms EPR.Examples.BellSteering.starRingEnd_invSqrtTwo
#print axioms EPR.Examples.BellSteering.invSqrtTwo_re
#print axioms EPR.Examples.BellSteering.invSqrtTwo_im
#print axioms EPR.Examples.BellSteering.invSqrtTwoReal_pos
#print axioms EPR.Examples.BellSteering.invSqrtTwo_ne_zero
#print axioms EPR.Examples.BellSteering.pauliZOutcome_projector
#print axioms EPR.Examples.BellSteering.pauliXOutcome_projector
#print axioms EPR.Examples.BellSteering.tensorKet_cross_amplitudes
#print axioms EPR.Examples.BellSteering.settingOutcome_projector
#print axioms EPR.Examples.BellSteering.settingOutcome_projector_eq_settingMeasurement
#print axioms EPR.Examples.BellSteering.settingState_density_matrix_eq_settingProjector
#print axioms EPR.Examples.BellSteering.stateProjection_supports
#print axioms EPR.Examples.BellSteering.bellPhiPlus_conditional_support
#print axioms EPR.Examples.BellSteering.oppositeOutcome_zero
#print axioms EPR.Examples.BellSteering.oppositeOutcome_one
#print axioms EPR.Examples.BellSteering.oppositeOutcome_ne
#print axioms EPR.Examples.BellSteering.oppositeOutcome_involutive
#print axioms EPR.Examples.BellSteering.settingOutcome_value

/-! ## Generic steering structures -/

#print axioms EPR.Quantum.PerfectConditionalPrediction
#print axioms EPR.Quantum.SteeringScenario

end EPR.Audit.PublicTheoremAxioms
