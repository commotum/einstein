module

public import EPR.Audit.Continuum

/-!
# Continuous-variable signature and axiom audit

This private diagnostic leaf checks the full Stage 9 surface and prints the
axioms of every substantive mathematical and sentinel theorem. It is not part
of the public `EPR` import chain.
-/

namespace EPR.Audit.ContinuumAxioms

/-! ## Ordinary plane-wave obstruction -/

#check EPR.Continuum.planeWave
#check EPR.Continuum.planeWave_norm
#check EPR.Continuum.planeWave_not_memLp_two
#check EPR.Continuum.planeWave_not_integrable
#check EPR.Continuum.unnormalizedIntervalWeight
#check EPR.Continuum.unnormalizedIntervalWeight_eq

#print axioms EPR.Continuum.planeWave_norm
#print axioms EPR.Continuum.planeWave_not_memLp_two
#print axioms EPR.Continuum.planeWave_not_integrable
#print axioms EPR.Continuum.unnormalizedIntervalWeight_eq

/-! ## Fourier and generalized momentum declarations -/

#check EPR.Continuum.fourierInv_volume_eq_delta_zero
#check EPR.Continuum.generalizedPlaneWave
#check EPR.Continuum.generalizedPlaneWave_apply
#check EPR.Continuum.delta_position_eigenrelation
#check EPR.Continuum.lineDeriv_one_eq_deriv
#check EPR.Continuum.deriv_generalizedPlaneWave
#check EPR.Continuum.distributionalMomentum
#check EPR.Continuum.eprMomentumMode
#check EPR.Continuum.eprMomentumMode_eigenvalue
#check EPR.Continuum.eprShiftedOppositeMomentumMode
#check EPR.Continuum.eprShiftedOppositeMomentumMode_eigenvalue

#print axioms EPR.Continuum.fourierInv_volume_eq_delta_zero
#print axioms EPR.Continuum.generalizedPlaneWave_apply
#print axioms EPR.Continuum.delta_position_eigenrelation
#print axioms EPR.Continuum.lineDeriv_one_eq_deriv
#print axioms EPR.Continuum.deriv_generalizedPlaneWave
#print axioms EPR.Continuum.eprMomentumMode_eigenvalue
#print axioms EPR.Continuum.eprShiftedOppositeMomentumMode_eigenvalue

/-! ## Schwartz-domain operators -/

#check EPR.Continuum.positionSchwartz
#check EPR.Continuum.momentumSchwartz
#check EPR.Continuum.positionSchwartz_apply
#check EPR.Continuum.momentumSchwartz_apply
#check EPR.Continuum.momentum_position_commutator

#print axioms EPR.Continuum.positionSchwartz_apply
#print axioms EPR.Continuum.momentumSchwartz_apply
#print axioms EPR.Continuum.momentum_position_commutator

/-! ## Affine-line correlation distribution -/

#check EPR.Continuum.diagonalEmbedding
#check EPR.Continuum.affineLineEmbedding
#check EPR.Continuum.affineLineEmbedding_hasTemperateGrowth
#check EPR.Continuum.affineLineEmbedding_antilipschitz
#check EPR.Continuum.affineLineRestriction
#check EPR.Continuum.affineLineDelta
#check EPR.Continuum.affineLineDelta_apply
#check EPR.Continuum.integral_lineDeriv_schwartz_eq_zero
#check EPR.Continuum.affineLineRestriction_lineDeriv
#check EPR.Continuum.affineLineDelta_diagonalDerivative
#check EPR.Continuum.jointMomentumSum
#check EPR.Continuum.relativePosition
#check EPR.Continuum.affineLineDelta_relativePosition
#check EPR.Continuum.eprCorrelation
#check EPR.Continuum.eprCorrelation_apply
#check EPR.Continuum.eprCorrelation_relativePosition
#check EPR.Continuum.eprCorrelation_jointMomentumSum

#print axioms EPR.Continuum.affineLineEmbedding_hasTemperateGrowth
#print axioms EPR.Continuum.affineLineEmbedding_antilipschitz
#print axioms EPR.Continuum.affineLineDelta_apply
#print axioms EPR.Continuum.integral_lineDeriv_schwartz_eq_zero
#print axioms EPR.Continuum.affineLineRestriction_lineDeriv
#print axioms EPR.Continuum.affineLineDelta_diagonalDerivative
#print axioms EPR.Continuum.affineLineDelta_relativePosition
#print axioms EPR.Continuum.eprCorrelation_apply
#print axioms EPR.Continuum.eprCorrelation_relativePosition
#print axioms EPR.Continuum.eprCorrelation_jointMomentumSum

/-! ## Executable and symbolic sentinels -/

#check EPR.Audit.Continuum.eq6_zero_two
#check EPR.Audit.Continuum.eq6_can_exceed_one
#check EPR.Audit.Continuum.eq2_planeWave_not_memLp_two
#check EPR.Audit.Continuum.eq12_planeWave_not_memLp_two
#check EPR.Audit.Continuum.positive_momentum_sign
#check EPR.Audit.Continuum.opposite_momentum_sign
#check EPR.Audit.Continuum.delta_position_value_three
#check EPR.Audit.Continuum.affineLineDelta_offset_apply
#check EPR.Audit.Continuum.eprCorrelation_offset_five
#check EPR.Audit.Continuum.eprCorrelation_total_momentum_zero
#check EPR.Audit.Continuum.commutator_scale_two

#print axioms EPR.Audit.Continuum.eq6_zero_two
#print axioms EPR.Audit.Continuum.eq6_can_exceed_one
#print axioms EPR.Audit.Continuum.eq2_planeWave_not_memLp_two
#print axioms EPR.Audit.Continuum.eq12_planeWave_not_memLp_two
#print axioms EPR.Audit.Continuum.positive_momentum_sign
#print axioms EPR.Audit.Continuum.opposite_momentum_sign
#print axioms EPR.Audit.Continuum.delta_position_value_three
#print axioms EPR.Audit.Continuum.affineLineDelta_offset_apply
#print axioms EPR.Audit.Continuum.eprCorrelation_offset_five
#print axioms EPR.Audit.Continuum.eprCorrelation_total_momentum_zero
#print axioms EPR.Audit.Continuum.commutator_scale_two

end EPR.Audit.ContinuumAxioms
