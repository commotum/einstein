module

public import EPR.Examples.BellNoSignalling
public import Mathlib.Tactic

/-!
# Operational no-signalling diagnostics

This executable leaf checks the Bell raw nonselective sums, verifies that the
joint state can change while the `B` marginal does not, expands both Pauli
settings, distinguishes selected conditional states from the unconditioned
marginal, and instantiates the directional theorem on a rectangular
`Fin 2 × Fin 3` system.
-/

open scoped ComplexOrder Kronecker Matrix

@[expose] public section

namespace EPR.Audit.NoSignalling

open EPR EPR.Quantum EPR.Examples.BellSteering
open EPR.Examples.BellNoSignalling

noncomputable section

/-! ## Exact Bell marginal and joint-state sentinels -/

def qubitMaximallyMixedMatrix : Operator QubitIndex :=
  (1 / 2 : ℂ) • 1

/-- The original Bell marginal on `B` is the maximally mixed qubit state. -/
theorem bellPhiPlus_reducedB_matrix :
    (reducedB bellPhiPlus.toDensity).matrix = qubitMaximallyMixedMatrix := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [reducedB_matrix, traceOutA_apply, bellPhiPlus,
      bellPhiPlusKet, qubitMaximallyMixedMatrix,
      PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply,
      Matrix.one_apply, Fin.sum_univ_two, invSqrtTwo_sq]

/-- The original Bell coherence between `|00⟩` and `|11⟩` is `1/2`. -/
theorem bellPhiPlus_joint_offDiagonal :
    bellPhiPlus.toDensity.matrix
      ((0 : QubitIndex), (0 : QubitIndex))
      ((1 : QubitIndex), (1 : QubitIndex)) = 1 / 2 := by
  norm_num [bellPhiPlus, bellPhiPlusKet,
    PureState.toDensity_matrix_apply, Matrix.vecMulVec_apply,
    invSqrtTwo_sq]

/-- Forgetting the computational-basis outcome removes that joint coherence.
This confirms that no-signalling does not assert equality of joint states. -/
theorem bellPhiPlus_z_nonselective_joint_offDiagonal :
    (bellPhiPlusAfterLocalMeasurement .z).matrix
      ((0 : QubitIndex), (0 : QubitIndex))
      ((1 : QubitIndex), (1 : QubitIndex)) = 0 := by
  norm_num [bellPhiPlusAfterLocalMeasurement,
    localANonselectiveState, ProjectiveMeasurement.localAProjection,
    ludersBranchMatrix, settingMeasurement, pauliZMeasurement,
    zProjection, stateProjection, zState, zKet, LocalProjectionA.lift,
    bellPhiPlus, bellPhiPlusKet, PureState.toDensity_matrix_apply,
    Matrix.mul_apply, Matrix.vecMulVec_apply, Matrix.one_apply,
    Fintype.sum_prod_type, Fin.sum_univ_two, invSqrtTwo_sq]

theorem bellPhiPlus_z_nonselective_joint_ne_input :
    bellPhiPlusAfterLocalMeasurement .z ≠ bellPhiPlus.toDensity := by
  intro h
  have hoff := congrArg
    (fun ρ : BipartiteState QubitIndex QubitIndex ↦ ρ.matrix
      ((0 : QubitIndex), (0 : QubitIndex))
      ((1 : QubitIndex), (1 : QubitIndex))) h
  rw [bellPhiPlus_z_nonselective_joint_offDiagonal,
    bellPhiPlus_joint_offDiagonal] at hoff
  norm_num at hoff

/-- Despite the changed joint state, the exact post-Z B marginal is still
maximally mixed. -/
theorem bellPhiPlus_z_nonselective_reducedB_matrix :
    (reducedB (bellPhiPlusAfterLocalMeasurement .z)).matrix =
      qubitMaximallyMixedMatrix := by
  rw [bellPhiPlus_reducedB_invariant, bellPhiPlus_reducedB_matrix]

/-- The same exact B marginal is obtained after forgetting the X outcome. -/
theorem bellPhiPlus_x_nonselective_reducedB_matrix :
    (reducedB (bellPhiPlusAfterLocalMeasurement .x)).matrix =
      qubitMaximallyMixedMatrix := by
  rw [bellPhiPlus_reducedB_invariant, bellPhiPlus_reducedB_matrix]

/-- Both checked source settings have the same unconditioned B marginal. -/
theorem bellPhiPlus_z_x_reducedB_equal :
    reducedB (bellPhiPlusAfterLocalMeasurement .z) =
      reducedB (bellPhiPlusAfterLocalMeasurement .x) :=
  bellPhiPlus_sourceSetting_independent .z .x

/-! ## Selected-state versus unconditioned-state sentinels -/

/-- A selected positive-probability branch differs from the unconditioned B
marginal; its `(0,0)` entry is one rather than one half. -/
theorem bellPhiPlus_selected_z0_ne_unconditionedB :
    localAConditionalBState bellPhiPlus.toDensity
        (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) ≠
      reducedB bellPhiPlus.toDensity := by
  rw [bellPhiPlus_z_conditionalB]
  intro h
  have h00 := congrArg
    (fun ρ : DensityState QubitIndex ↦ ρ.matrix 0 0) h
  rw [bellPhiPlus_reducedB_matrix] at h00
  norm_num [zState, zKet, PureState.toDensity_matrix_apply,
    Matrix.vecMulVec_apply, qubitMaximallyMixedMatrix,
    Matrix.one_apply] at h00

/-- The concrete arbitrary-statistic theorem covers every source setting,
target Pauli setting, and target outcome. -/
theorem bellPhiPlus_all_target_statistics
    (sourceSetting targetSetting : Setting) (w : Outcome) :
    outcomeProbability
      (reducedB (bellPhiPlusAfterLocalMeasurement sourceSetting))
        ((settingMeasurement targetSetting).projector w) =
      outcomeProbability (reducedB bellPhiPlus.toDensity)
        ((settingMeasurement targetSetting).projector w) :=
  bellPhiPlus_targetStatistic_invariant sourceSetting targetSetting w

/-! ## Direction and tensor-order sentinel -/

abbrev RectangularA := Fin 2
abbrev RectangularB := Fin 3

/-- The generic theorem leaves a `Fin 3` B state after acting on `Fin 2` A,
so swapping `reducedA` for `reducedB` cannot typecheck here. -/
theorem rectangular_AtoB_noSignalling
    (ρ : BipartiteState RectangularA RectangularB) :
    reducedB (localANonselectiveState ρ pauliZMeasurement) = reducedB ρ :=
  localA_nonselective_noSignalling ρ pauliZMeasurement

/-- The rectangular specialization also covers an arbitrary B-side
projection, not a hard-coded Pauli outcome. -/
theorem rectangular_AtoB_all_statistics
    (ρ : BipartiteState RectangularA RectangularB)
    (Q : Projection RectangularB) :
    outcomeProbability
        (reducedB (localANonselectiveState ρ pauliZMeasurement)) Q =
      outcomeProbability (reducedB ρ) Q :=
  localA_nonselective_outcomeProbability ρ pauliZMeasurement Q

/-- The executable distinction packages a changed joint state, an unchanged
unconditioned B marginal, and a selected state different from that marginal. -/
theorem bellPhiPlus_joint_changes_selected_changes_marginal_does_not :
    bellPhiPlusAfterLocalMeasurement .z ≠ bellPhiPlus.toDensity ∧
      reducedB (bellPhiPlusAfterLocalMeasurement .z) =
        reducedB bellPhiPlus.toDensity ∧
      localAConditionalBState bellPhiPlus.toDensity
          (localAProjection .z 0) (bellPhiPlus_branchPositive .z 0) ≠
        reducedB bellPhiPlus.toDensity :=
  ⟨bellPhiPlus_z_nonselective_joint_ne_input,
    bellPhiPlus_reducedB_invariant .z,
    bellPhiPlus_selected_z0_ne_unconditionedB⟩

end

end EPR.Audit.NoSignalling
