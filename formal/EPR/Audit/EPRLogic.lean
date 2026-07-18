module

public import EPR.Examples.BellEPR
public import EPR.Examples.BellNoSignalling
public import Mathlib.Tactic

/-!
# EPR logic separation diagnostics

This diagnostic leaf checks that the Stage 8 predicates are not definitionally
identified. Small proposition-valued interpretations witness that actuality,
reality, possessed values, counterfactual aggregation, and joint
representation can each be declined. A separate Bell sentinel places the
proved operational no-signalling fact alongside an explicitly changed toy
ontic reality, demonstrating that the former cannot supply the latter.

This module is not part of the public `EPR` import chain.
-/

@[expose] public section

namespace EPR.Audit.EPRLogic

open EPR EPR.Quantum EPR.Logic
open EPR.Examples.BellSteering EPR.Examples.BellEPR
open EPR.Examples.BellNoSignalling

/-! ## Small independently rejectable interpretations -/

/-- A compact interpretation whose seven semantic relations are independently
selectable propositions. Context is `Bool`; all other vocabulary types are
`Unit`. -/
def propositionInterpretation
    (outcome certain element value simultaneous counterpart joint : Prop) :
    EPRInterpretation Bool Unit Unit Unit Unit where
  outcomeObtained := fun _ ↦ outcome
  certainPrediction := fun _ _ _ ↦ certain
  elementOfReality := fun _ _ _ ↦ element
  possessesValue := fun _ _ _ _ ↦ value
  simultaneouslyReal := fun _ _ _ _ _ _ _ ↦ simultaneous
  theoryCounterpart := fun _ _ ↦ counterpart
  jointlyRepresents := fun _ _ _ _ _ ↦ joint

/-- A proposition-valued interpretation in which every semantic relation is
available. This is a consistency/usage example, not a physical assertion. -/
def acceptingInterpretation :
    EPRInterpretation Bool Unit Unit Unit Unit :=
  propositionInterpretation True True True True True True True

/-- All four interpretative bridges can be supplied coherently in the toy
accepting interpretation. The separate rejection witnesses below show that
none is forced by the vocabulary. -/
theorem allInterpretiveBridges_satisfiable :
    RealityCriterion acceptingInterpretation ∧
      RealityValueBridge acceptingInterpretation ∧
      CounterfactualStability acceptingInterpretation ∧
      CompletenessRepresentationBridge acceptingInterpretation := by
  simp [RealityCriterion, RealityValueBridge, CounterfactualStability,
    CompletenessRepresentationBridge, OutcomeObtained, CertainPrediction,
    ElementOfReality, PossessesValue, SimultaneouslyReal, TheoryCounterpart,
    JointlyRepresents, acceptingInterpretation, propositionInterpretation]

/-- A second proposition-valued interpretation used to exercise the complete
conditional theorem. Reality and simultaneous-reality relations hold, while
theory counterparts and joint representation are both declined. -/
def eprWitnessInterpretation :
    EPRInterpretation Bool Unit Unit Unit Unit :=
  propositionInterpretation True True True True True False False

/-- The four interpretative bridges required by `epr_incompleteness` are
jointly satisfiable in the witness interpretation. The representation bridge
is vacuous because that toy model declines theory counterparts; this theorem
tests interface coherence, not physical adequacy. -/
theorem eprWitnessInterpretiveBridges_satisfiable :
    RealityCriterion eprWitnessInterpretation ∧
      RealityValueBridge eprWitnessInterpretation ∧
      CounterfactualStability eprWitnessInterpretation ∧
      CompletenessRepresentationBridge eprWitnessInterpretation := by
  simp [RealityCriterion, RealityValueBridge, CounterfactualStability,
    CompletenessRepresentationBridge, OutcomeObtained, CertainPrediction,
    ElementOfReality, PossessesValue, SimultaneouslyReal, TheoryCounterpart,
    JointlyRepresents, eprWitnessInterpretation, propositionInterpretation]

/-- First toy context, with unchanged unit-valued reality. -/
def firstSituation : PhysicalSituation Bool Unit where
  context := false
  priorReality := ()
  postReality := ()

/-- Alternative toy context sharing the same unchanged reality. -/
def secondSituation : PhysicalSituation Bool Unit where
  context := true
  priorReality := ()
  postReality := ()

theorem toy_alternative_contexts :
    AlternativeContexts firstSituation secondSituation := by
  simp [AlternativeContexts, firstSituation, secondSituation]

theorem toy_same_prior : SamePriorReality firstSituation secondSituation :=
  rfl

theorem toy_first_noOnticDisturbance :
    NoOnticDisturbance firstSituation :=
  rfl

theorem toy_second_noOnticDisturbance :
    NoOnticDisturbance secondSituation :=
  rfl

/-- A checked wiring example that invokes the abstract EPR theorem with every
premise supplied explicitly. It says only that the deliberately constructed
proposition model is incomplete for its unit theory description. -/
theorem toy_epr_incompleteness_via_explicit_premises :
    ¬ CompleteFor eprWitnessInterpretation () firstSituation.postReality := by
  rcases eprWitnessInterpretiveBridges_satisfiable with
    ⟨hCriterion, hValueBridge, hCounterfactual, hRepresentation⟩
  exact epr_incompleteness
    (I := eprWitnessInterpretation)
    (s := firstSituation) (t := secondSituation)
    (theory := ()) (q₁ := ()) (q₂ := ()) (v₁ := ()) (v₂ := ())
    toy_alternative_contexts toy_same_prior
    (by trivial) (by trivial) (by trivial) (by trivial)
    toy_first_noOnticDisturbance toy_second_noOnticDisturbance
    hCriterion hValueBridge hCounterfactual hRepresentation
    (by simp [JointlyRepresents, eprWitnessInterpretation,
      propositionInterpretation])

/-- Certainty and an obtained outcome are independent predicates. -/
theorem certainty_does_not_assert_outcome :
    CertainPrediction
        (propositionInterpretation False True True True True True True)
        firstSituation () () ∧
      ¬ OutcomeObtained
        (propositionInterpretation False True True True True True True)
        firstSituation := by
  simp [CertainPrediction, OutcomeObtained, propositionInterpretation]

/-- The sufficient reality criterion is not forced by the vocabulary. -/
theorem realityCriterion_rejectable :
    ¬ RealityCriterion
      (propositionInterpretation True True False True True True True) := by
  intro h
  have hElement := h firstSituation () () trivial trivial
    toy_first_noOnticDisturbance
  simp [ElementOfReality, propositionInterpretation] at hElement

/-- An element of reality need not definitionally possess the predicted value;
the separate value bridge can consistently be rejected. -/
theorem realityValueBridge_rejectable :
    ¬ RealityValueBridge
      (propositionInterpretation True True True False True True True) := by
  intro h
  have hValue := h firstSituation () () trivial trivial
    toy_first_noOnticDisturbance trivial
  simp [PossessesValue, propositionInterpretation] at hValue

/-- Two contextual elements and values do not form simultaneous reality unless
the counterfactual premise is supplied. -/
theorem counterfactualStability_rejectable :
    ¬ CounterfactualStability
      (propositionInterpretation True True True True False True True) := by
  intro h
  have hSimultaneous := h firstSituation secondSituation () () () ()
    toy_alternative_contexts rfl trivial trivial trivial trivial
  simp [SimultaneouslyReal, propositionInterpretation] at hSimultaneous

/-- Bare theory counterparts do not definitionally yield a joint exact-value
representation. -/
theorem completenessRepresentationBridge_rejectable :
    ¬ CompletenessRepresentationBridge
      (propositionInterpretation True True True True True True False) := by
  intro h
  have hJoint := h () () false () () true () () trivial trivial trivial
  simp [JointlyRepresents, propositionInterpretation] at hJoint

/-- Relative completeness can hold while joint representation fails when the
extra representation bridge is declined. -/
theorem completeness_without_joint_representation :
    CompleteFor
        (propositionInterpretation True True True True True True False)
        () () ∧
      ¬ JointlyRepresents
        (propositionInterpretation True True True True True True False)
        () () () () () := by
  constructor
  · intro _ _ _
    trivial
  · simp [JointlyRepresents, propositionInterpretation]

/-! ## Bell mathematical-input and operational/ontic sentinels -/

/-- The bundled Bell scenario supplies both settings and every outcome; no
branch calculation is repeated in Stage 8. -/
theorem bell_all_branch_predictions :
    (∀ w : Outcome, BellPerfectPrediction .z w) ∧
      (∀ w : Outcome, BellPerfectPrediction .x w) :=
  ⟨bellPhiPlus_perfectPrediction_fromScenario .z,
    bellPhiPlus_perfectPrediction_fromScenario .x⟩

/-- A semantics in which no selected branch is asserted actual. The other
relations are irrelevant to this actuality diagnostic. -/
def noOutcomeBellSemantics : BellInterpretiveSemantics Unit where
  outcomeObtained := fun _ ↦ False
  elementOfReality := fun _ _ _ ↦ True
  possessesValue := fun _ _ _ _ ↦ True
  simultaneouslyReal := fun _ _ _ _ _ _ _ ↦ True
  theoryCounterpart := fun _ _ ↦ True

/-- Positive-probability perfect prediction for a branch coexists with denial
that its source outcome was actually obtained. -/
theorem bell_prediction_does_not_assert_actuality :
    BellPerfectPrediction .z 0 ∧
      ¬ OutcomeObtained (bellEPRInterpretation noOutcomeBellSemantics)
        (bellPhiPlusPhysicalSituation .z 0 () ()) := by
  exact ⟨bellPhiPlus_perfectPrediction_fromScenario .z 0, by
    simp [OutcomeObtained, bellEPRInterpretation, noOutcomeBellSemantics]⟩

/-- A toy ontic labeling in which the post-context B reality differs from its
prior reality. -/
def onticallyChangedBellSituation : PhysicalSituation BellContext Bool :=
  bellPhiPlusPhysicalSituation .z 0 false true

/-- The checked Bell operational no-signalling theorem and denial of ontic
no-disturbance are logically compatible. This is a concrete non-implication
sentinel, not a claim that the toy Boolean ontology describes nature. -/
theorem operational_noSignalling_with_ontic_change :
    OperationalNoSignallingAtoB bellPhiPlus.toDensity pauliZMeasurement ∧
      ¬ NoOnticDisturbance onticallyChangedBellSituation := by
  constructor
  · exact bellPhiPlus_operationalNoSignalling .z
  · simp [NoOnticDisturbance, onticallyChangedBellSituation,
      bellPhiPlusPhysicalSituation]

/-- The Pauli obstruction excludes the Bell joint-representation meaning for
every density description and all four pairs of selected outcomes. -/
theorem bell_all_outcomes_no_joint_representation
    (ρ : DensityState QubitIndex) :
    ∀ zOutcome xOutcome : Outcome,
      ¬ JointlyRepresents (bellEPRInterpretation noOutcomeBellSemantics) ρ
        .z zOutcome .x xOutcome :=
  fun zOutcome xOutcome ↦
    bellPhiPlus_noJointRepresentation_zx noOutcomeBellSemantics ρ
      zOutcome xOutcome

end EPR.Audit.EPRLogic
