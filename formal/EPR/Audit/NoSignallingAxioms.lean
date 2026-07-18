module

public import EPR.Audit.NoSignalling

/-!
# Operational no-signalling signature and axiom audit

This diagnostic leaf checks the complete Stage 7 declaration inventory and
prints the trusted axioms of the generic marginal theorem, all corollaries,
the Bell specialization, and the executable direction/selection sentinels. It
is not part of the public `EPR` import chain.
-/

namespace EPR.Audit.NoSignallingAxioms

/-! ## Generic construction and theorem surface -/

#check EPR.Quantum.ProjectiveMeasurement.localAProjection
#check EPR.Quantum.ProjectiveMeasurement.sum_localAProjection_lift
#check EPR.Quantum.localANonselectiveState
#check EPR.Quantum.localANonselectiveState_matrix
#check EPR.Quantum.traceOutA_localA_mul_cycle
#check EPR.Quantum.traceOutA_ludersBranchMatrix_localA
#check EPR.Quantum.OperationalNoSignallingAtoB
#check EPR.Quantum.localA_nonselective_noSignalling
#check EPR.Quantum.localA_nonselective_outcomeProbability
#check EPR.Quantum.localA_nonselective_reducedB_independent
#check EPR.Quantum.localA_nonselective_outcomeProbability_independent

#print axioms EPR.Quantum.ProjectiveMeasurement.localAProjection
#print axioms EPR.Quantum.ProjectiveMeasurement.sum_localAProjection_lift
#print axioms EPR.Quantum.localANonselectiveState
#print axioms EPR.Quantum.localANonselectiveState_matrix
#print axioms EPR.Quantum.traceOutA_localA_mul_cycle
#print axioms EPR.Quantum.traceOutA_ludersBranchMatrix_localA
#print axioms EPR.Quantum.OperationalNoSignallingAtoB
#print axioms EPR.Quantum.localA_nonselective_noSignalling
#print axioms EPR.Quantum.localA_nonselective_outcomeProbability
#print axioms EPR.Quantum.localA_nonselective_reducedB_independent
#print axioms EPR.Quantum.localA_nonselective_outcomeProbability_independent

/-! ## Bell specialization -/

#check EPR.Examples.BellNoSignalling.bellPhiPlusAfterLocalMeasurement
#check EPR.Examples.BellNoSignalling.bellPhiPlusAfterLocalMeasurement_matrix
#check EPR.Examples.BellNoSignalling.bellPhiPlus_operationalNoSignalling
#check EPR.Examples.BellNoSignalling.bellPhiPlus_reducedB_invariant
#check EPR.Examples.BellNoSignalling.bellPhiPlus_sourceSetting_independent
#check EPR.Examples.BellNoSignalling.bellPhiPlus_targetStatistic_invariant
#check EPR.Examples.BellNoSignalling.bellPhiPlus_targetStatistic_sourceSetting_independent
#check EPR.Examples.BellNoSignalling.bellPhiPlus_selected_z_outcomes_differ
#check EPR.Examples.BellNoSignalling.bellPhiPlus_selected_settings_differ
#check EPR.Examples.BellNoSignalling.bellPhiPlus_selected_changes_with_noSignalling

#print axioms EPR.Examples.BellNoSignalling.bellPhiPlusAfterLocalMeasurement
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlusAfterLocalMeasurement_matrix
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_operationalNoSignalling
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_reducedB_invariant
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_sourceSetting_independent
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_targetStatistic_invariant
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_targetStatistic_sourceSetting_independent
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_selected_z_outcomes_differ
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_selected_settings_differ
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_selected_changes_with_noSignalling

/-! ## Executable and direction sentinels -/

#check EPR.Audit.NoSignalling.qubitMaximallyMixedMatrix
#check EPR.Audit.NoSignalling.bellPhiPlus_reducedB_matrix
#check EPR.Audit.NoSignalling.bellPhiPlus_joint_offDiagonal
#check EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_joint_offDiagonal
#check EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_joint_ne_input
#check EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_reducedB_matrix
#check EPR.Audit.NoSignalling.bellPhiPlus_x_nonselective_reducedB_matrix
#check EPR.Audit.NoSignalling.bellPhiPlus_z_x_reducedB_equal
#check EPR.Audit.NoSignalling.bellPhiPlus_selected_z0_ne_unconditionedB
#check EPR.Audit.NoSignalling.bellPhiPlus_all_target_statistics
#check EPR.Audit.NoSignalling.RectangularA
#check EPR.Audit.NoSignalling.RectangularB
#check EPR.Audit.NoSignalling.rectangular_AtoB_noSignalling
#check EPR.Audit.NoSignalling.rectangular_AtoB_all_statistics
#check EPR.Audit.NoSignalling.bellPhiPlus_joint_changes_selected_changes_marginal_does_not

#print axioms EPR.Audit.NoSignalling.qubitMaximallyMixedMatrix
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_reducedB_matrix
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_joint_offDiagonal
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_joint_offDiagonal
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_joint_ne_input
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_z_nonselective_reducedB_matrix
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_x_nonselective_reducedB_matrix
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_z_x_reducedB_equal
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_selected_z0_ne_unconditionedB
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_all_target_statistics
#print axioms EPR.Audit.NoSignalling.RectangularA
#print axioms EPR.Audit.NoSignalling.RectangularB
#print axioms EPR.Audit.NoSignalling.rectangular_AtoB_noSignalling
#print axioms EPR.Audit.NoSignalling.rectangular_AtoB_all_statistics
#print axioms EPR.Audit.NoSignalling.bellPhiPlus_joint_changes_selected_changes_marginal_does_not

end EPR.Audit.NoSignallingAxioms
