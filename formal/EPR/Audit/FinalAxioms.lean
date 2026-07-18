module

import EPR.Audit.PublicAPI
import EPR.Audit.PublicTheoremAxioms
import EPR.Audit.ApiProbe
import EPR.Audit.QuantumCore
import EPR.Audit.QuantumCoreAxioms
import EPR.Audit.BipartiteAxioms
import EPR.Audit.ConditionalAxioms
import EPR.Audit.BellSteeringAxioms
import EPR.Audit.IncompatibilityAxioms
import EPR.Audit.NoSignallingAxioms
import EPR.Audit.EPRLogicAxioms
import EPR.Audit.ContinuumAxioms

/-!
# Whole-library signature and axiom audit

Importing this opt-in leaf compiles the public-root surface sentinel and every
stage-specific diagnostic/axiom leaf. The checks below select the principal
results that justify the final mathematical, operational, logical, correction,
and continuum claims.

This module is not re-exported by `EPR`.
-/

namespace EPR.Audit.FinalAxioms

#check EPR.Quantum.PureState.toDensity
#check EPR.Quantum.reducedB
#check EPR.Quantum.conditionalState_selected_probability_eq_one
#check EPR.Examples.BellSteering.bellPhiPlusSteeringScenario
#check EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#check EPR.Audit.Incompatibility.fin3_noncommuting_with_common_sharp_state
#check EPR.Quantum.localA_nonselective_noSignalling
#check EPR.Examples.BellNoSignalling.bellPhiPlus_selected_changes_with_noSignalling
#check EPR.Logic.epr_incompleteness
#check EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness
#check EPR.Audit.EPRLogic.allInterpretiveBridges_satisfiable
#check EPR.Audit.EPRLogic.toy_epr_incompleteness_via_explicit_premises
#check EPR.Audit.EPRLogic.operational_noSignalling_with_ontic_change
#check EPR.Continuum.planeWave_not_memLp_two
#check EPR.Continuum.momentum_position_commutator
#check EPR.Continuum.eprCorrelation_relativePosition
#check EPR.Continuum.eprCorrelation_jointMomentumSum

#print axioms EPR.Quantum.PureState.toDensity
#print axioms EPR.Quantum.reducedB
#print axioms EPR.Quantum.conditionalState_selected_probability_eq_one
#print axioms EPR.Examples.BellSteering.bellPhiPlusSteeringScenario
#print axioms EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#print axioms EPR.Audit.Incompatibility.fin3_noncommuting_with_common_sharp_state
#print axioms EPR.Quantum.localA_nonselective_noSignalling
#print axioms EPR.Examples.BellNoSignalling.bellPhiPlus_selected_changes_with_noSignalling
#print axioms EPR.Logic.epr_incompleteness
#print axioms EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness
#print axioms EPR.Audit.EPRLogic.allInterpretiveBridges_satisfiable
#print axioms EPR.Audit.EPRLogic.toy_epr_incompleteness_via_explicit_premises
#print axioms EPR.Audit.EPRLogic.operational_noSignalling_with_ontic_change
#print axioms EPR.Continuum.planeWave_not_memLp_two
#print axioms EPR.Continuum.momentum_position_commutator
#print axioms EPR.Continuum.eprCorrelation_relativePosition
#print axioms EPR.Continuum.eprCorrelation_jointMomentumSum

end EPR.Audit.FinalAxioms
