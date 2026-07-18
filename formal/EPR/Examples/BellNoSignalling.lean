module

public import EPR.Quantum.NoSignalling
public import EPR.Examples.BellSteering
import Mathlib.Tactic

/-!
# Operational no-signalling for the Bell/Pauli scenario

This module specializes the generic outcome-forgotten local Lüders theorem to
both Pauli settings in the checked `|Φ⁺⟩` steering example. Every A-side
setting leaves B's unconditioned reduced density and all its projective Born
statistics unchanged. The selected positive-probability B states nevertheless
depend on the setting and outcome.

The coexistence of those two facts is the operational steering/no-signalling
distinction. It supplies no ontic no-disturbance, locality, same-reality, or
counterfactual conclusion.
-/

open scoped ComplexOrder Matrix

@[expose] public section

namespace EPR.Examples.BellNoSignalling

open EPR EPR.Quantum EPR.Examples.BellSteering

/-- The Bell joint state after an A-side Pauli measurement whose outcome is
discarded. -/
noncomputable def bellPhiPlusAfterLocalMeasurement (s : Setting) :
    BipartiteState QubitIndex QubitIndex :=
  localANonselectiveState bellPhiPlus.toDensity (settingMeasurement s)

@[simp]
theorem bellPhiPlusAfterLocalMeasurement_matrix (s : Setting) :
    (bellPhiPlusAfterLocalMeasurement s).matrix =
      ∑ w, ludersBranchMatrix bellPhiPlus.toDensity
        ((settingMeasurement s).localAProjection
          (κ := QubitIndex) w).lift :=
  rfl

/-- Every checked A-side Pauli setting is operationally non-signalling from A
to B for the Bell input. -/
theorem bellPhiPlus_operationalNoSignalling (s : Setting) :
    OperationalNoSignallingAtoB bellPhiPlus.toDensity
      (settingMeasurement s) :=
  localA_nonselective_noSignalling bellPhiPlus.toDensity
    (settingMeasurement s)

/-- The outcome-forgotten Bell measurement leaves B's reduced density equal to
its original unconditioned marginal. -/
theorem bellPhiPlus_reducedB_invariant (s : Setting) :
    reducedB (bellPhiPlusAfterLocalMeasurement s) =
      reducedB bellPhiPlus.toDensity :=
  bellPhiPlus_operationalNoSignalling s

/-- The unconditioned B marginal is independent of the choice between any two
checked Pauli settings on A. -/
theorem bellPhiPlus_sourceSetting_independent (s t : Setting) :
    reducedB (bellPhiPlusAfterLocalMeasurement s) =
      reducedB (bellPhiPlusAfterLocalMeasurement t) :=
  localA_nonselective_reducedB_independent bellPhiPlus.toDensity
    (settingMeasurement s) (settingMeasurement t)

/-- Every checked B-side Pauli projector has the same Born probability before
and after either outcome-forgotten A-side setting. -/
theorem bellPhiPlus_targetStatistic_invariant
    (sourceSetting targetSetting : Setting) (w : Outcome) :
    outcomeProbability
      (reducedB (bellPhiPlusAfterLocalMeasurement sourceSetting))
      ((settingMeasurement targetSetting).projector w) =
    outcomeProbability (reducedB bellPhiPlus.toDensity)
      ((settingMeasurement targetSetting).projector w) :=
  localA_nonselective_outcomeProbability bellPhiPlus.toDensity
    (settingMeasurement sourceSetting)
    ((settingMeasurement targetSetting).projector w)

/-- B-side Pauli statistics are independent of which A-side Pauli setting was
chosen and then forgotten. -/
theorem bellPhiPlus_targetStatistic_sourceSetting_independent
    (s t targetSetting : Setting) (w : Outcome) :
    outcomeProbability (reducedB (bellPhiPlusAfterLocalMeasurement s))
        ((settingMeasurement targetSetting).projector w) =
      outcomeProbability (reducedB (bellPhiPlusAfterLocalMeasurement t))
        ((settingMeasurement targetSetting).projector w) :=
  localA_nonselective_outcomeProbability_independent bellPhiPlus.toDensity
    (settingMeasurement s) (settingMeasurement t)
    ((settingMeasurement targetSetting).projector w)

/-- Selecting opposite computational-basis outcomes produces different B
conditional density states. -/
theorem bellPhiPlus_selected_z_outcomes_differ :
    localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) ≠
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 1) (bellPhiPlus_branchPositive .z 1) := by
  rw [bellPhiPlus_z_conditionalB, bellPhiPlus_z_conditionalB]
  intro h
  have h00 := congrArg
    (fun ρ : DensityState QubitIndex ↦ ρ.matrix 0 0) h
  norm_num [zState, zKet, PureState.toDensity_matrix_apply,
    Matrix.vecMulVec_apply] at h00

/-- Selecting the positive `Z` branch and the positive `X` branch produces
different B conditional density states. -/
theorem bellPhiPlus_selected_settings_differ :
    localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) ≠
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0) := by
  rw [bellPhiPlus_z_conditionalB, bellPhiPlus_x_conditionalB]
  intro h
  have h01 := congrArg
    (fun ρ : DensityState QubitIndex ↦ ρ.matrix 0 1) h
  norm_num [zState, zKet, xState, xKet,
    PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply,
    starRingEnd_invSqrtTwo, invSqrtTwo_sq] at h01

/-- Selected steering changes coexist with both outcome-forgotten Pauli
settings satisfying operational no-signalling. -/
theorem bellPhiPlus_selected_changes_with_noSignalling :
    localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) ≠
      localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .x 0) (bellPhiPlus_branchPositive .x 0) ∧
      OperationalNoSignallingAtoB bellPhiPlus.toDensity pauliZMeasurement ∧
      OperationalNoSignallingAtoB bellPhiPlus.toDensity pauliXMeasurement :=
  ⟨bellPhiPlus_selected_settings_differ,
    bellPhiPlus_operationalNoSignalling .z,
    bellPhiPlus_operationalNoSignalling .x⟩

end EPR.Examples.BellNoSignalling
