module

public import EPR.Audit.EPRLogic

/-!
# EPR logic signature and axiom audit

This diagnostic leaf checks every explicit Stage 8 declaration and prints the
trusted axioms of the abstract logic, Bell adapter, and separation sentinels.
It is not part of the public `EPR` import chain.
-/

namespace EPR.Audit.EPRLogicAxioms

/-! ## Theory-neutral logic -/

#check EPR.Logic.PhysicalSituation
#check EPR.Logic.AlternativeContexts
#check EPR.Logic.SamePriorReality
#check EPR.Logic.SamePostReality
#check EPR.Logic.NoOnticDisturbance
#check EPR.Logic.samePostReality_of_noOnticDisturbance
#check EPR.Logic.EPRInterpretation
#check EPR.Logic.OutcomeObtained
#check EPR.Logic.CertainPrediction
#check EPR.Logic.ElementOfReality
#check EPR.Logic.PossessesValue
#check EPR.Logic.SimultaneouslyReal
#check EPR.Logic.TheoryCounterpart
#check EPR.Logic.JointlyRepresents
#check EPR.Logic.RealityCriterion
#check EPR.Logic.RealityValueBridge
#check EPR.Logic.CounterfactualStability
#check EPR.Logic.CompleteFor
#check EPR.Logic.CompletenessRepresentationBridge
#check EPR.Logic.reality_of_perfect_prediction
#check EPR.Logic.possessed_value_of_perfect_prediction
#check EPR.Logic.simultaneous_reality_of_alternative_predictions
#check EPR.Logic.theoryCounterpart_of_complete
#check EPR.Logic.joint_representation_of_complete
#check EPR.Logic.not_complete_of_no_joint_representation
#check EPR.Logic.epr_incompleteness

#print axioms EPR.Logic.PhysicalSituation
#print axioms EPR.Logic.AlternativeContexts
#print axioms EPR.Logic.SamePriorReality
#print axioms EPR.Logic.SamePostReality
#print axioms EPR.Logic.NoOnticDisturbance
#print axioms EPR.Logic.samePostReality_of_noOnticDisturbance
#print axioms EPR.Logic.EPRInterpretation
#print axioms EPR.Logic.OutcomeObtained
#print axioms EPR.Logic.CertainPrediction
#print axioms EPR.Logic.ElementOfReality
#print axioms EPR.Logic.PossessesValue
#print axioms EPR.Logic.SimultaneouslyReal
#print axioms EPR.Logic.TheoryCounterpart
#print axioms EPR.Logic.JointlyRepresents
#print axioms EPR.Logic.RealityCriterion
#print axioms EPR.Logic.RealityValueBridge
#print axioms EPR.Logic.CounterfactualStability
#print axioms EPR.Logic.CompleteFor
#print axioms EPR.Logic.CompletenessRepresentationBridge
#print axioms EPR.Logic.reality_of_perfect_prediction
#print axioms EPR.Logic.possessed_value_of_perfect_prediction
#print axioms EPR.Logic.simultaneous_reality_of_alternative_predictions
#print axioms EPR.Logic.theoryCounterpart_of_complete
#print axioms EPR.Logic.joint_representation_of_complete
#print axioms EPR.Logic.not_complete_of_no_joint_representation
#print axioms EPR.Logic.epr_incompleteness

/-! ## Bell/Pauli adapter -/

#check EPR.Examples.BellEPR.BellContext
#check EPR.Examples.BellEPR.BellPerfectPrediction
#check EPR.Examples.BellEPR.bellPhiPlus_perfectPrediction_fromScenario
#check EPR.Examples.BellEPR.bellCertainPrediction
#check EPR.Examples.BellEPR.BellInterpretiveSemantics
#check EPR.Examples.BellEPR.bellJointlyRepresents
#check EPR.Examples.BellEPR.bellEPRInterpretation
#check EPR.Examples.BellEPR.bellPhysicalSituation
#check EPR.Examples.BellEPR.bellPhiPlus_certainPrediction
#check EPR.Examples.BellEPR.bell_z_x_alternative
#check EPR.Examples.BellEPR.bell_z_x_samePrior
#check EPR.Examples.BellEPR.bellPhiPlus_noJointRepresentation_zx
#check EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness

#print axioms EPR.Examples.BellEPR.BellContext
#print axioms EPR.Examples.BellEPR.BellPerfectPrediction
#print axioms EPR.Examples.BellEPR.bellPhiPlus_perfectPrediction_fromScenario
#print axioms EPR.Examples.BellEPR.bellCertainPrediction
#print axioms EPR.Examples.BellEPR.BellInterpretiveSemantics
#print axioms EPR.Examples.BellEPR.bellJointlyRepresents
#print axioms EPR.Examples.BellEPR.bellEPRInterpretation
#print axioms EPR.Examples.BellEPR.bellPhysicalSituation
#print axioms EPR.Examples.BellEPR.bellPhiPlus_certainPrediction
#print axioms EPR.Examples.BellEPR.bell_z_x_alternative
#print axioms EPR.Examples.BellEPR.bell_z_x_samePrior
#print axioms EPR.Examples.BellEPR.bellPhiPlus_noJointRepresentation_zx
#print axioms EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness

/-! ## Separation and dependency sentinels -/

#check EPR.Audit.EPRLogic.propositionInterpretation
#check EPR.Audit.EPRLogic.firstSituation
#check EPR.Audit.EPRLogic.secondSituation
#check EPR.Audit.EPRLogic.toy_alternative_contexts
#check EPR.Audit.EPRLogic.toy_same_prior
#check EPR.Audit.EPRLogic.toy_first_noOnticDisturbance
#check EPR.Audit.EPRLogic.toy_second_noOnticDisturbance
#check EPR.Audit.EPRLogic.certainty_does_not_assert_outcome
#check EPR.Audit.EPRLogic.realityCriterion_rejectable
#check EPR.Audit.EPRLogic.realityValueBridge_rejectable
#check EPR.Audit.EPRLogic.counterfactualStability_rejectable
#check EPR.Audit.EPRLogic.completenessRepresentationBridge_rejectable
#check EPR.Audit.EPRLogic.completeness_without_joint_representation
#check EPR.Audit.EPRLogic.bell_all_branch_predictions
#check EPR.Audit.EPRLogic.noOutcomeBellSemantics
#check EPR.Audit.EPRLogic.bell_prediction_does_not_assert_actuality
#check EPR.Audit.EPRLogic.onticallyChangedBellSituation
#check EPR.Audit.EPRLogic.operational_noSignalling_with_ontic_change
#check EPR.Audit.EPRLogic.bell_all_outcomes_no_joint_representation

#print axioms EPR.Audit.EPRLogic.propositionInterpretation
#print axioms EPR.Audit.EPRLogic.firstSituation
#print axioms EPR.Audit.EPRLogic.secondSituation
#print axioms EPR.Audit.EPRLogic.toy_alternative_contexts
#print axioms EPR.Audit.EPRLogic.toy_same_prior
#print axioms EPR.Audit.EPRLogic.toy_first_noOnticDisturbance
#print axioms EPR.Audit.EPRLogic.toy_second_noOnticDisturbance
#print axioms EPR.Audit.EPRLogic.certainty_does_not_assert_outcome
#print axioms EPR.Audit.EPRLogic.realityCriterion_rejectable
#print axioms EPR.Audit.EPRLogic.realityValueBridge_rejectable
#print axioms EPR.Audit.EPRLogic.counterfactualStability_rejectable
#print axioms EPR.Audit.EPRLogic.completenessRepresentationBridge_rejectable
#print axioms EPR.Audit.EPRLogic.completeness_without_joint_representation
#print axioms EPR.Audit.EPRLogic.bell_all_branch_predictions
#print axioms EPR.Audit.EPRLogic.noOutcomeBellSemantics
#print axioms EPR.Audit.EPRLogic.bell_prediction_does_not_assert_actuality
#print axioms EPR.Audit.EPRLogic.onticallyChangedBellSituation
#print axioms EPR.Audit.EPRLogic.operational_noSignalling_with_ontic_change
#print axioms EPR.Audit.EPRLogic.bell_all_outcomes_no_joint_representation

end EPR.Audit.EPRLogicAxioms
