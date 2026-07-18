module

public import EPR.Logic.EPR
public import EPR.Examples.PauliIncompatibility

/-!
# Conditional Bell/Pauli EPR inference

This module connects the theory-neutral EPR logic to the already checked Bell
steering and Pauli incompatibility results. A Bell context identifies a
possible selected source setting/outcome branch; a separate
`OutcomeObtained` hypothesis says that branch is actual in its physical
situation. The uniform four-branch steering certificate supplies certainty,
while the Pauli no-joint-sharp-state theorem supplies the contradiction.

Ontic non-disturbance, the reality and value criteria, counterfactual
aggregation, and the completeness representation bridge remain hypotheses.
This module intentionally does not import operational no-signalling.
-/

@[expose] public section

namespace EPR.Examples.BellEPR

open EPR EPR.Quantum EPR.Logic
open EPR.Examples.BellSteering EPR.Examples.PauliIncompatibility

/-- One possible selected branch of a remote Bell measurement. The data do
not by themselves assert that the setting was chosen or the outcome occurred. -/
structure BellContext where
  sourceSetting : Setting
  selectedOutcome : Outcome
  deriving DecidableEq

/-- The operational perfect-prediction proposition exposed by the verified
Bell steering scenario for one of its four branches. -/
def BellPerfectPrediction (s : Setting) (w : Outcome) : Prop :=
  PerfectConditionalPrediction bellPhiPlusSteeringScenario.state
    ⟨(bellPhiPlusSteeringScenario.sourceMeasurement s).projector w⟩
    (bellPhiPlusSteeringScenario.targetOutcome s
      (bellPhiPlusSteeringScenario.response s w))

/-- Every Bell setting/outcome branch has the checked positive-probability,
probability-one prediction certificate. -/
theorem bellPhiPlus_perfectPrediction_fromScenario
    (s : Setting) (w : Outcome) : BellPerfectPrediction s w :=
  bellPhiPlusSteeringScenario.predicts s w

/-- Bell-specific certainty keeps the target quantity/value explicit and
routes its mathematical evidence through the bundled steering scenario. -/
def bellCertainPrediction {Reality : Type*}
    (p : PhysicalSituation BellContext Reality)
    (q : Setting) (v : Outcome) : Prop :=
  q = p.context.sourceSetting ∧
    v = p.context.selectedOutcome ∧
    BellPerfectPrediction p.context.sourceSetting p.context.selectedOutcome

/-- The remaining interpretative vocabulary for the Bell adapter. These are
relations only; the structure asserts none of the philosophical premises. -/
structure BellInterpretiveSemantics (Reality : Type*) where
  outcomeObtained : PhysicalSituation BellContext Reality → Prop
  elementOfReality : Reality → BellContext → Setting → Prop
  possessesValue : Reality → BellContext → Setting → Outcome → Prop
  simultaneouslyReal :
    Reality → BellContext → Setting → Outcome →
      BellContext → Setting → Outcome → Prop
  theoryCounterpart : DensityState QubitIndex → Setting → Prop

/-- Exact-value quantum representation for the Bell target quantities. -/
def bellJointlyRepresents
    (ρ : DensityState QubitIndex)
    (q₁ : Setting) (v₁ : Outcome) (q₂ : Setting) (v₂ : Outcome) : Prop :=
  ρ.SharpValue (settingObservable q₁) (outcomeValue v₁) ∧
    ρ.SharpValue (settingObservable q₂) (outcomeValue v₂)

/-- The Bell interpretation fixes only the already checked mathematical
certainty and joint-sharpness meanings; every ontic relation remains supplied
by `S`. -/
def bellEPRInterpretation {Reality : Type*}
    (S : BellInterpretiveSemantics Reality) :
    EPRInterpretation BellContext Reality Setting Outcome
      (DensityState QubitIndex) where
  outcomeObtained := S.outcomeObtained
  certainPrediction := bellCertainPrediction
  elementOfReality := S.elementOfReality
  possessesValue := S.possessesValue
  simultaneouslyReal := S.simultaneouslyReal
  theoryCounterpart := S.theoryCounterpart
  jointlyRepresents := bellJointlyRepresents

/-- A context-indexed Bell physical situation with explicit prior and post
ontic realities. -/
def bellPhiPlusPhysicalSituation {Reality : Type*}
    (s : Setting) (w : Outcome) (prior post : Reality) :
    PhysicalSituation BellContext Reality where
  context := ⟨s, w⟩
  priorReality := prior
  postReality := post

/-- Mathematical certainty in every Bell branch comes from the existing
four-branch steering certificate, independently of the ontic semantics. -/
theorem bellPhiPlus_certainPrediction
    {Reality : Type*} (S : BellInterpretiveSemantics Reality)
    (s : Setting) (w : Outcome) (prior post : Reality) :
    CertainPrediction (bellEPRInterpretation S)
      (bellPhiPlusPhysicalSituation s w prior post) s w :=
  ⟨rfl, rfl, bellPhiPlus_perfectPrediction_fromScenario s w⟩

/-- The selected Z and X branches are genuinely alternative contexts. -/
theorem bell_z_x_alternative
    {Reality : Type*} (zOutcome xOutcome : Outcome)
    (priorZ postZ priorX postX : Reality) :
    AlternativeContexts
      (bellPhiPlusPhysicalSituation .z zOutcome priorZ postZ)
      (bellPhiPlusPhysicalSituation .x xOutcome priorX postX) := by
  simp [AlternativeContexts, bellPhiPlusPhysicalSituation]

/-- Both alternative Bell contexts start from the same supplied reality. -/
theorem bell_z_x_samePrior
    {Reality : Type*} (zOutcome xOutcome : Outcome)
    (prior postZ postX : Reality) :
    SamePriorReality
      (bellPhiPlusPhysicalSituation .z zOutcome prior postZ)
      (bellPhiPlusPhysicalSituation .x xOutcome prior postX) :=
  rfl

/-- No density description can jointly represent the exact values associated
with an arbitrary selected Z branch and an arbitrary selected X branch. This
uses the checked no-joint-sharp theorem, not bare noncommutation. -/
theorem bellPhiPlus_noJointRepresentation_zx
    {Reality : Type*} (S : BellInterpretiveSemantics Reality)
    (ρ : DensityState QubitIndex) (zOutcome xOutcome : Outcome) :
    ¬ JointlyRepresents (bellEPRInterpretation S) ρ
      .z zOutcome .x xOutcome := by
  change ¬ (ρ.SharpValue pauliZ (outcomeValue zOutcome) ∧
    ρ.SharpValue pauliX (outcomeValue xOutcome))
  rintro ⟨hz, hx⟩
  exact pauliXZ_noJointSharpState
    ⟨ρ, outcomeValue xOutcome, outcomeValue zOutcome, hx, hz⟩

/-- Bell/Pauli specialization of the conditional EPR inference.

The outcomes are arbitrary, so the theorem uses the uniform four-branch Bell
certificate. The conclusion concerns the supplied quantum density description
and common prior reality only under every named interpretative premise. -/
theorem bellPhiPlus_epr_incompleteness
    {Reality : Type*} (S : BellInterpretiveSemantics Reality)
    (description : DensityState QubitIndex)
    (zOutcome xOutcome : Outcome)
    (priorZ postZ priorX postX : Reality)
    (hPrior : SamePriorReality
      (bellPhiPlusPhysicalSituation .z zOutcome priorZ postZ)
      (bellPhiPlusPhysicalSituation .x xOutcome priorX postX))
    (hOutcomeZ : OutcomeObtained (bellEPRInterpretation S)
      (bellPhiPlusPhysicalSituation .z zOutcome priorZ postZ))
    (hOutcomeX : OutcomeObtained (bellEPRInterpretation S)
      (bellPhiPlusPhysicalSituation .x xOutcome priorX postX))
    (hNoDisturbanceZ : NoOnticDisturbance
      (bellPhiPlusPhysicalSituation .z zOutcome priorZ postZ))
    (hNoDisturbanceX : NoOnticDisturbance
      (bellPhiPlusPhysicalSituation .x xOutcome priorX postX))
    (hCriterion : RealityCriterion (bellEPRInterpretation S))
    (hValueBridge : RealityValueBridge (bellEPRInterpretation S))
    (hCounterfactual : CounterfactualStability (bellEPRInterpretation S))
    (hRepresentation :
      CompletenessRepresentationBridge (bellEPRInterpretation S)) :
    ¬ CompleteFor (bellEPRInterpretation S) description priorZ := by
  have hPostZ : postZ = priorZ := hNoDisturbanceZ
  have hIncomplete :
      ¬ CompleteFor (bellEPRInterpretation S) description postZ :=
    epr_incompleteness
      (bell_z_x_alternative zOutcome xOutcome priorZ postZ priorX postX)
      hPrior
      hOutcomeZ hOutcomeX
      (bellPhiPlus_certainPrediction S .z zOutcome priorZ postZ)
      (bellPhiPlus_certainPrediction S .x xOutcome priorX postX)
      hNoDisturbanceZ hNoDisturbanceX hCriterion hValueBridge
      hCounterfactual hRepresentation
      (bellPhiPlus_noJointRepresentation_zx S description
        zOutcome xOutcome)
  rw [hPostZ] at hIncomplete
  exact hIncomplete

end EPR.Examples.BellEPR
