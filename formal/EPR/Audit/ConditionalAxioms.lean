module

import EPR.Audit.Conditional

/-!
# Conditional-state axiom audit

This diagnostic leaf prints the trusted axiom footprint of the principal
Stage 4 constructions, bridges, and executable checks. It is not imported by
the public `EPR` root.
-/

#check EPR.Quantum.SubnormalizedState
#check EPR.Quantum.SubnormalizedState.normalize
#check EPR.Quantum.conditionalState
#check EPR.Quantum.ProjectiveMeasurement
#check EPR.Quantum.ProjectiveMeasurement.nonselectiveState
#check EPR.Quantum.PureState.conditionalPureState
#check EPR.Quantum.reducedA
#check EPR.Quantum.reducedB
#check EPR.Quantum.localAConditionalBState
#check EPR.Quantum.localBConditionalAState

#print axioms EPR.Quantum.ludersBranchMatrix_posSemidef
#print axioms EPR.Quantum.outcomeProbability_mem_Icc
#print axioms EPR.Quantum.outcomeProbability_pos_iff_ludersBranchMatrix_ne_zero
#print axioms EPR.Quantum.SubnormalizedState.normalize
#print axioms EPR.Quantum.conditionalState
#print axioms EPR.Quantum.conditionalState_supports
#print axioms EPR.Quantum.conditionalState_selected_probability_eq_one
#print axioms EPR.Quantum.ProjectiveMeasurement.probability_sum
#print axioms EPR.Quantum.ProjectiveMeasurement.nonselectiveState
#print axioms EPR.Quantum.PureState.ludersBranchMatrix_toDensity
#print axioms EPR.Quantum.PureState.conditionalPureState
#print axioms EPR.Quantum.PureState.conditionalPureState_toDensity
#print axioms EPR.Quantum.PureState.rephase_toDensity
#print axioms EPR.Quantum.PureState.conditionalState_rephase
#print axioms EPR.Quantum.localARelativeBBranch
#print axioms EPR.Quantum.localBRelativeABranch
#print axioms EPR.Quantum.normalize_localARelativeBBranch
#print axioms EPR.Quantum.normalize_localBRelativeABranch
#print axioms EPR.Quantum.localAConditionalBState
#print axioms EPR.Quantum.localBConditionalAState
#print axioms EPR.Audit.Conditional.basisZero_zero_branch_matrix
#print axioms EPR.Audit.Conditional.coherent_conditional_rankTwo
#print axioms EPR.Audit.Conditional.coherent_conditional_rankOne
#print axioms EPR.Audit.Conditional.coherent_nonselective_dephases
#print axioms EPR.Audit.Conditional.inside_conditional_preserves_coherence
#print axioms EPR.Audit.Conditional.phasedCoherent_density_eq
#print axioms EPR.Audit.Conditional.phasedCoherent_conditional_eq
#print axioms EPR.Audit.Conditional.biased_conditionalB_ne_reducedB
