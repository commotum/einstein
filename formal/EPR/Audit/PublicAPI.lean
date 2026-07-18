module

import EPR

/-!
# Public-root surface audit

This diagnostic imports only `EPR` and checks representative stable
declarations from every completed branch. A declaration missing from the
umbrella API cannot pass here through a direct internal or audit import.

This module is not re-exported by `EPR`.
-/

namespace EPR.Audit.PublicAPI

/-! ## Finite state and measurement API -/

#check EPR.Ket
#check EPR.Operator
#check EPR.Quantum.PureState
#check EPR.Quantum.DensityState
#check EPR.Quantum.Observable
#check EPR.Quantum.ProjectiveOutcome
#check EPR.Quantum.outcomeProbability
#check EPR.Quantum.DensityState.SharpValue
#check EPR.Quantum.DensityState.JointlySharp
#check EPR.Quantum.BipartiteState
#check EPR.Quantum.LocalOperatorA
#check EPR.Quantum.LocalOperatorB
#check EPR.Quantum.reducedA
#check EPR.Quantum.reducedB
#check EPR.Quantum.SubnormalizedState
#check EPR.Quantum.conditionalState
#check EPR.Quantum.ProjectiveMeasurement
#check EPR.Quantum.ProjectiveMeasurement.nonselectiveState
#check EPR.Quantum.localAConditionalBState
#check EPR.Quantum.PerfectConditionalPrediction
#check EPR.Quantum.SteeringScenario

/-! ## Finite example, incompatibility, and operational API -/

#check EPR.Examples.BellSteering.Setting
#check EPR.Examples.BellSteering.bellPhiPlus
#check EPR.Examples.BellSteering.bellPhiPlus_probability
#check EPR.Examples.BellSteering.bellPhiPlus_conditionalB
#check EPR.Examples.BellSteering.bellPhiPlusSteeringScenario
#check EPR.Quantum.Observable.Noncommutes
#check EPR.Quantum.Observable.NoCommonEigenvector
#check EPR.Quantum.Observable.NoJointSharpState
#check EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#check EPR.Quantum.OperationalNoSignallingAtoB
#check EPR.Quantum.localA_nonselective_noSignalling
#check EPR.Examples.BellNoSignalling.bellPhiPlus_operationalNoSignalling
#check EPR.Examples.BellNoSignalling.bellPhiPlus_selected_changes_with_noSignalling

/-! ## Conditional EPR logic API -/

#check EPR.Logic.PhysicalSituation
#check EPR.Logic.EPRInterpretation
#check EPR.Logic.AlternativeContexts
#check EPR.Logic.SamePriorReality
#check EPR.Logic.SamePostReality
#check EPR.Logic.OutcomeObtained
#check EPR.Logic.CertainPrediction
#check EPR.Logic.ElementOfReality
#check EPR.Logic.PossessesValue
#check EPR.Logic.SimultaneouslyReal
#check EPR.Logic.TheoryCounterpart
#check EPR.Logic.JointlyRepresents
#check EPR.Logic.NoOnticDisturbance
#check EPR.Logic.RealityCriterion
#check EPR.Logic.RealityValueBridge
#check EPR.Logic.CounterfactualStability
#check EPR.Logic.CompleteFor
#check EPR.Logic.CompletenessRepresentationBridge
#check EPR.Logic.epr_incompleteness
#check EPR.Examples.BellEPR.BellInterpretiveSemantics
#check EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness

/-! ## Independent continuum API -/

#check EPR.Continuum.planeWave_not_memLp_two
#check EPR.Continuum.unnormalizedIntervalWeight_eq
#check EPR.Continuum.eprMomentumMode_eigenrelation
#check EPR.Continuum.eprShiftedOppositeMomentumMode_eigenrelation
#check EPR.Continuum.positionSchwartz
#check EPR.Continuum.momentumSchwartz
#check EPR.Continuum.momentum_position_commutator
#check EPR.Continuum.affineLineDelta
#check EPR.Continuum.eprCorrelation_relativePosition
#check EPR.Continuum.eprCorrelation_jointMomentumSum

end EPR.Audit.PublicAPI
