module

public import EPR.Quantum.Conditional

/-!
# Operational conditional prediction and steering

This module packages finite conditional-state facts without interpretation.
A `PerfectConditionalPrediction` includes strict positivity of the selected
source branch and probability one for a target spectral outcome in the
normalized conditional state. A `SteeringScenario` supplies such a prediction
for every setting and source outcome.

These structures do not assert that any outcome occurred, that a target value
was possessed before measurement, that an unconditioned marginal changed, or
that locality, reality, completeness, or counterfactual claims hold.
-/

@[expose] public section

namespace EPR.Quantum

/-- A possible selected source branch conditionally makes one target spectral
outcome certain. Strict source positivity prevents vacuous claims about an
impossible branch. -/
structure PerfectConditionalPrediction {ι κ : Type*}
    [Fintype ι] [Fintype κ] [DecidableEq ι] [DecidableEq κ]
    (ρ : BipartiteState ι κ) (source : LocalProjectionA ι κ)
    {B : Observable κ} (target : ProjectiveOutcome B) : Prop where
  source_positive : 0 < localAOutcomeProbability ρ source
  target_certain : outcomeProbability
    (localAConditionalBState ρ source source_positive)
    target.projector = 1

/-- Alternative source measurements with an explicit target response and a
checked perfect conditional prediction for every setting/outcome pair. -/
structure SteeringScenario (σ ω τ ι κ : Type*)
    [Fintype ω] [Fintype ι] [Fintype κ]
    [DecidableEq ι] [DecidableEq κ] where
  state : BipartiteState ι κ
  measurement : σ → ProjectiveMeasurement ω ι
  observable : σ → Observable κ
  targetOutcome : (s : σ) → τ → ProjectiveOutcome (observable s)
  response : σ → ω → τ
  predicts : ∀ s w, PerfectConditionalPrediction state
    ⟨(measurement s).projector w⟩ (targetOutcome s (response s w))

end EPR.Quantum
