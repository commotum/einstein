module

public import Mathlib.Logic.Basic

/-!
# Conditional EPR logic

This module provides a theory-neutral vocabulary for the logical steps in the
EPR argument. A physical situation records an experimental context and
possibly different ontic realities before and after that context. Certainty,
an obtained outcome, an element of reality, possession of a value, a theory
counterpart, and joint representation are deliberately distinct predicates.

The reality criterion, the bridge from a reality element to a possessed value,
counterfactual aggregation, and the bridge from complete theory counterparts
to joint representation are propositions supplied to the main theorem. None
is asserted as a fact about nature. Operational no-signalling is neither
defined nor imported here and cannot prove ontic no-disturbance.
-/

@[expose] public section

namespace EPR.Logic

variable {Context Reality Quantity Value TheoryDescription : Type*}

/-- One context-indexed physical situation, with ontic reality before and
after that context kept separate. -/
structure PhysicalSituation (Context Reality : Type*) where
  context : Context
  priorReality : Reality
  postReality : Reality

/-- The two situations represent different experimental contexts. This does
not by itself say that either context occurred or that their realities agree. -/
def AlternativeContexts (s t : PhysicalSituation Context Reality) : Prop :=
  s.context ≠ t.context

/-- The alternatives start from the same modeled underlying reality. -/
def SamePriorReality (s t : PhysicalSituation Context Reality) : Prop :=
  s.priorReality = t.priorReality

/-- The two context-specific post-situations have the same ontic reality. -/
def SamePostReality (s t : PhysicalSituation Context Reality) : Prop :=
  s.postReality = t.postReality

/-- Ontic no-disturbance means that the modeled reality itself is unchanged.
This is strictly stronger in kind than equality of operational marginals and
is never produced unconditionally. -/
def NoOnticDisturbance (s : PhysicalSituation Context Reality) : Prop :=
  s.postReality = s.priorReality

/-- Common prior reality plus ontic stability in both alternative situations
transports them to the same post reality. -/
theorem samePostReality_of_noOnticDisturbance
    {s t : PhysicalSituation Context Reality}
    (hPrior : SamePriorReality s t)
    (hs : NoOnticDisturbance s) (ht : NoOnticDisturbance t) :
    SamePostReality s t :=
  hs.trans (hPrior.trans ht.symm)

/-- User-supplied semantic relations for an EPR reading. The fields are
vocabulary, not assumptions that any proposition holds. -/
structure EPRInterpretation
    (Context Reality Quantity Value TheoryDescription : Type*) where
  outcomeObtained : PhysicalSituation Context Reality → Prop
  certainPrediction :
    PhysicalSituation Context Reality → Quantity → Value → Prop
  elementOfReality : Reality → Context → Quantity → Prop
  possessesValue : Reality → Context → Quantity → Value → Prop
  simultaneouslyReal :
    Reality → Context → Quantity → Value →
      Context → Quantity → Value → Prop
  theoryCounterpart : TheoryDescription → Quantity → Prop
  jointlyRepresents :
    TheoryDescription → Quantity → Value → Quantity → Value → Prop

/-- The source outcome encoded by a context was actually obtained. This is not
implied by a branch having positive probability. -/
def OutcomeObtained
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (s : PhysicalSituation Context Reality) : Prop :=
  I.outcomeObtained s

/-- Operational evidence that the stated value is predictable with certainty
in the selected context. This does not assert actuality or possession. -/
def CertainPrediction
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (s : PhysicalSituation Context Reality) (q : Quantity) (v : Value) : Prop :=
  I.certainPrediction s q v

/-- A context-indexed element of physical reality for a quantity. A specific
possessed value remains a separate predicate. -/
def ElementOfReality
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (r : Reality) (c : Context) (q : Quantity) : Prop :=
  I.elementOfReality r c q

/-- The modeled reality possesses the stated value for a quantity in one
context. This is not definitionally a quantum sharp-value judgment. -/
def PossessesValue
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (r : Reality) (c : Context) (q : Quantity) (v : Value) : Prop :=
  I.possessesValue r c q v

/-- Two context-tagged quantity/value assignments are simultaneously real for
one underlying reality. The contexts remain visible in the proposition. -/
def SimultaneouslyReal
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (r : Reality)
    (c₁ : Context) (q₁ : Quantity) (v₁ : Value)
    (c₂ : Context) (q₂ : Quantity) (v₂ : Value) : Prop :=
  I.simultaneouslyReal r c₁ q₁ v₁ c₂ q₂ v₂

/-- The theory description contains a counterpart for the stated quantity.
Readout of a definite value is deliberately not built into this predicate. -/
def TheoryCounterpart
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (theory : TheoryDescription) (q : Quantity) : Prop :=
  I.theoryCounterpart theory q

/-- One theory description represents both exact values together. Concrete
interpretations may instantiate this with joint quantum sharpness. -/
def JointlyRepresents
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (theory : TheoryDescription)
    (q₁ : Quantity) (v₁ : Value) (q₂ : Quantity) (v₂ : Value) : Prop :=
  I.jointlyRepresents theory q₁ v₁ q₂ v₂

/-- EPR's sufficient reality criterion. Actuality, operational certainty, and
ontic non-disturbance are three separate antecedents. -/
def RealityCriterion
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription) :
    Prop :=
  ∀ s q v,
    OutcomeObtained I s →
    CertainPrediction I s q v →
    NoOnticDisturbance s →
    ElementOfReality I s.postReality s.context q

/-- The extra value-assignment step: a reality element identified through an
actual certain prediction is taken to possess the predicted value. Keeping it
named avoids identifying an element of reality with a value by definition. -/
def RealityValueBridge
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription) :
    Prop :=
  ∀ s q v,
    OutcomeObtained I s →
    CertainPrediction I s q v →
    NoOnticDisturbance s →
    ElementOfReality I s.postReality s.context q →
    PossessesValue I s.postReality s.context q v

/-- The counterfactual/context-independence premise. Elements and possessed
values inferred in distinct but same-reality contexts may be aggregated into
one simultaneous-reality judgment. -/
def CounterfactualStability
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription) :
    Prop :=
  ∀ s t q₁ v₁ q₂ v₂,
    AlternativeContexts s t →
    SamePostReality s t →
    ElementOfReality I s.postReality s.context q₁ →
    PossessesValue I s.postReality s.context q₁ v₁ →
    ElementOfReality I t.postReality t.context q₂ →
    PossessesValue I t.postReality t.context q₂ v₂ →
    SimultaneouslyReal I s.postReality
      s.context q₁ v₁ t.context q₂ v₂

/-- Completeness relative to one theory description and one reality: every
context-indexed element of that reality has a theory counterpart. -/
def CompleteFor
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription)
    (theory : TheoryDescription) (r : Reality) : Prop :=
  ∀ c q, ElementOfReality I r c q → TheoryCounterpart I theory q

/-- The further representation/readout premise not supplied by the bare word
“counterpart”: counterparts for simultaneously real quantities must be
jointly representable with their definite values. -/
def CompletenessRepresentationBridge
    (I : EPRInterpretation Context Reality Quantity Value TheoryDescription) :
    Prop :=
  ∀ theory r c₁ q₁ v₁ c₂ q₂ v₂,
    SimultaneouslyReal I r c₁ q₁ v₁ c₂ q₂ v₂ →
    TheoryCounterpart I theory q₁ →
    TheoryCounterpart I theory q₂ →
    JointlyRepresents I theory q₁ v₁ q₂ v₂

/-- One application of the sufficient reality criterion. -/
theorem reality_of_perfect_prediction
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {s : PhysicalSituation Context Reality} {q : Quantity} {v : Value}
    (hCriterion : RealityCriterion I)
    (hOutcome : OutcomeObtained I s)
    (hPrediction : CertainPrediction I s q v)
    (hNoDisturbance : NoOnticDisturbance s) :
    ElementOfReality I s.postReality s.context q :=
  hCriterion s q v hOutcome hPrediction hNoDisturbance

/-- The predicted value is assigned only through the separate value bridge. -/
theorem possessed_value_of_perfect_prediction
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {s : PhysicalSituation Context Reality} {q : Quantity} {v : Value}
    (hBridge : RealityValueBridge I)
    (hOutcome : OutcomeObtained I s)
    (hPrediction : CertainPrediction I s q v)
    (hNoDisturbance : NoOnticDisturbance s)
    (hElement : ElementOfReality I s.postReality s.context q) :
    PossessesValue I s.postReality s.context q v :=
  hBridge s q v hOutcome hPrediction hNoDisturbance hElement

/-- Alternative predictions yield simultaneous reality only through all of
the named actuality, locality, reality, value, same-reality, and aggregation
steps. -/
theorem simultaneous_reality_of_alternative_predictions
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {s t : PhysicalSituation Context Reality}
    {q₁ q₂ : Quantity} {v₁ v₂ : Value}
    (hCriterion : RealityCriterion I)
    (hValueBridge : RealityValueBridge I)
    (hCounterfactual : CounterfactualStability I)
    (hAlternative : AlternativeContexts s t)
    (hPrior : SamePriorReality s t)
    (hOutcomeS : OutcomeObtained I s) (hOutcomeT : OutcomeObtained I t)
    (hPredictionS : CertainPrediction I s q₁ v₁)
    (hPredictionT : CertainPrediction I t q₂ v₂)
    (hNoDisturbanceS : NoOnticDisturbance s)
    (hNoDisturbanceT : NoOnticDisturbance t) :
    SimultaneouslyReal I s.postReality
      s.context q₁ v₁ t.context q₂ v₂ := by
  have hElementS := reality_of_perfect_prediction hCriterion
    hOutcomeS hPredictionS hNoDisturbanceS
  have hElementT := reality_of_perfect_prediction hCriterion
    hOutcomeT hPredictionT hNoDisturbanceT
  have hValueS := possessed_value_of_perfect_prediction hValueBridge
    hOutcomeS hPredictionS hNoDisturbanceS hElementS
  have hValueT := possessed_value_of_perfect_prediction hValueBridge
    hOutcomeT hPredictionT hNoDisturbanceT hElementT
  exact hCounterfactual s t q₁ v₁ q₂ v₂ hAlternative
    (samePostReality_of_noOnticDisturbance hPrior
      hNoDisturbanceS hNoDisturbanceT)
    hElementS hValueS hElementT hValueT

/-- Completeness supplies the theory counterpart promised by its definition. -/
theorem theoryCounterpart_of_complete
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {theory : TheoryDescription} {r : Reality} {c : Context} {q : Quantity}
    (hComplete : CompleteFor I theory r)
    (hElement : ElementOfReality I r c q) :
    TheoryCounterpart I theory q :=
  hComplete c q hElement

/-- Completeness plus the explicit representation bridge converts two
simultaneous reality elements into one joint theory representation. -/
theorem joint_representation_of_complete
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {theory : TheoryDescription} {r : Reality}
    {c₁ c₂ : Context} {q₁ q₂ : Quantity} {v₁ v₂ : Value}
    (hRepresentation : CompletenessRepresentationBridge I)
    (hComplete : CompleteFor I theory r)
    (hElementOne : ElementOfReality I r c₁ q₁)
    (hElementTwo : ElementOfReality I r c₂ q₂)
    (hSimultaneous : SimultaneouslyReal I r c₁ q₁ v₁ c₂ q₂ v₂) :
    JointlyRepresents I theory q₁ v₁ q₂ v₂ :=
  hRepresentation theory r c₁ q₁ v₁ c₂ q₂ v₂ hSimultaneous
    (theoryCounterpart_of_complete hComplete hElementOne)
    (theoryCounterpart_of_complete hComplete hElementTwo)

/-- A mathematical exclusion of the required joint representation refutes
relative completeness once the interpretative representation bridge is
supplied. -/
theorem not_complete_of_no_joint_representation
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {theory : TheoryDescription} {r : Reality}
    {c₁ c₂ : Context} {q₁ q₂ : Quantity} {v₁ v₂ : Value}
    (hRepresentation : CompletenessRepresentationBridge I)
    (hElementOne : ElementOfReality I r c₁ q₁)
    (hElementTwo : ElementOfReality I r c₂ q₂)
    (hSimultaneous : SimultaneouslyReal I r c₁ q₁ v₁ c₂ q₂ v₂)
    (hNoJoint : ¬ JointlyRepresents I theory q₁ v₁ q₂ v₂) :
    ¬ CompleteFor I theory r := by
  intro hComplete
  exact hNoJoint (joint_representation_of_complete hRepresentation hComplete
    hElementOne hElementTwo hSimultaneous)

/-- The abstract conditional EPR incompleteness theorem.

Every nonmathematical move is an explicit hypothesis. The conclusion is only
that the selected theory description is not complete for the common modeled
reality; it does not say that no complete theory can exist. -/
theorem epr_incompleteness
    {I : EPRInterpretation Context Reality Quantity Value TheoryDescription}
    {s t : PhysicalSituation Context Reality}
    {theory : TheoryDescription}
    {q₁ q₂ : Quantity} {v₁ v₂ : Value}
    (hAlternative : AlternativeContexts s t)
    (hPrior : SamePriorReality s t)
    (hOutcomeS : OutcomeObtained I s) (hOutcomeT : OutcomeObtained I t)
    (hPredictionS : CertainPrediction I s q₁ v₁)
    (hPredictionT : CertainPrediction I t q₂ v₂)
    (hNoDisturbanceS : NoOnticDisturbance s)
    (hNoDisturbanceT : NoOnticDisturbance t)
    (hCriterion : RealityCriterion I)
    (hValueBridge : RealityValueBridge I)
    (hCounterfactual : CounterfactualStability I)
    (hRepresentation : CompletenessRepresentationBridge I)
    (hNoJoint : ¬ JointlyRepresents I theory q₁ v₁ q₂ v₂) :
    ¬ CompleteFor I theory s.postReality := by
  have hElementS := reality_of_perfect_prediction hCriterion
    hOutcomeS hPredictionS hNoDisturbanceS
  have hElementT := reality_of_perfect_prediction hCriterion
    hOutcomeT hPredictionT hNoDisturbanceT
  have hSamePost := samePostReality_of_noOnticDisturbance hPrior
    hNoDisturbanceS hNoDisturbanceT
  have hElementTCommon :
      ElementOfReality I s.postReality t.context q₂ := by
    rw [hSamePost]
    exact hElementT
  have hSimultaneous := simultaneous_reality_of_alternative_predictions
    hCriterion hValueBridge hCounterfactual hAlternative hPrior
    hOutcomeS hOutcomeT hPredictionS hPredictionT
    hNoDisturbanceS hNoDisturbanceT
  exact not_complete_of_no_joint_representation hRepresentation
    hElementS hElementTCommon hSimultaneous hNoJoint

end EPR.Logic
