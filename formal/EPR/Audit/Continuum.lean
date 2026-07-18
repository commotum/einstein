module

public import EPR.Continuum.Idealized
public import Mathlib.Tactic

/-!
# Continuous-variable diagnostics

This private leaf checks the normalization obstruction, both momentum signs,
the generalized position relations, and the Schwartz-domain commutator. It is
not imported by the public `EPR` root.
-/

@[expose] public section

namespace EPR.Audit.Continuum

open MeasureTheory
open scoped SchwartzMap

open EPR.Continuum

noncomputable section

/-! ## Eq. (2) and Eq. (6) sentinels -/

/-- A concrete interval in Eq. (6)'s formula has weight two, so the displayed
quantity cannot be a probability. -/
theorem eq6_zero_two (k : ℝ) :
    unnormalizedIntervalWeight k 0 2 = 2 := by
  rw [unnormalizedIntervalWeight_eq]
  norm_num

/-- The same concrete Eq. (6) weight exceeds one. -/
theorem eq6_can_exceed_one (k : ℝ) :
    1 < unnormalizedIntervalWeight k 0 2 := by
  rw [eq6_zero_two]
  norm_num

/-- Eq. (2)'s positive-sign paper frequency is not `L²`, for any supplied
`h` and `p`; no normalization wrapper is available here. -/
theorem eq2_planeWave_not_memLp_two (h p : ℝ) (_hh : h ≠ 0) :
    ¬ MemLp (planeWave (p / h)) 2 (volume : Measure ℝ) :=
  planeWave_not_memLp_two _

/-- Eq. (12)'s negative-sign frequency is equally non-`L²`; its constant phase
cannot repair normalization. -/
theorem eq12_planeWave_not_memLp_two (h p : ℝ) (_hh : h ≠ 0) :
    ¬ MemLp (planeWave (-p / h)) 2 (volume : Measure ℝ) :=
  planeWave_not_memLp_two _

/-! ## Generalized-eigenstate and correlation sentinels -/

/-- A concrete nonzero-`h` instance checks the positive momentum sign. -/
theorem positive_momentum_sign :
    distributionalMomentum 2 (eprMomentumMode 2 3) =
      (3 : ℂ) • eprMomentumMode 2 3 := by
  exact eprMomentumMode_eigenvalue (h := 2) (p := 3) (by norm_num)

/-- A concrete shifted instance checks Eq. (12)'s negative momentum sign. -/
theorem opposite_momentum_sign :
    distributionalMomentum 2 (eprShiftedOppositeMomentumMode 2 3 5) =
      (-3 : ℂ) • eprShiftedOppositeMomentumMode 2 3 5 := by
  simpa using eprShiftedOppositeMomentumMode_eigenvalue
    (h := 2) (p := 3) (x₀ := 5) (by norm_num)

/-- A concrete delta checks the generalized position-eigenvalue convention. -/
theorem delta_position_value_three :
    TemperedDistribution.smulLeftCLM ℂ (fun x : ℝ => (x : ℂ))
        (TemperedDistribution.delta 3) =
      (3 : ℂ) • TemperedDistribution.delta 3 :=
  delta_position_eigenrelation 3

/-- The affine-line construction exposes the intended coordinate support in
its action rather than hiding it behind a symbolic delta name. -/
theorem affineLineDelta_offset_apply (f : 𝓢(ℝ × ℝ, ℂ)) :
    affineLineDelta 5 f = ∫ t : ℝ, f (t, t + 5) :=
  affineLineDelta_apply 5 f

/-- At the concrete nonzero scale two, the paper-scaled correlation obeys the
relative-position value-five operator relation. -/
theorem eprCorrelation_offset_five :
    TemperedDistribution.smulLeftCLM ℂ relativePosition
        (eprCorrelation 2 5) =
      (5 : ℂ) • eprCorrelation 2 5 :=
  eprCorrelation_relativePosition 2 5

/-- The same concrete nonzero scale checks exact momentum anticorrelation. -/
theorem eprCorrelation_total_momentum_zero :
    jointMomentumSum 2 (eprCorrelation 2 5) = 0 :=
  eprCorrelation_jointMomentumSum 2 5

/-! ## Eq. (18) common-domain sentinel -/

/-- A concrete scale checks Eq. (18)'s sign while retaining an arbitrary
Schwartz test vector as the explicit common-domain argument. -/
theorem commutator_scale_two (f : 𝓢(ℝ, ℂ)) :
    momentumSchwartz 2 (positionSchwartz f) -
        positionSchwartz (momentumSchwartz 2 f) =
      ((2 : ℂ) / (2 * Real.pi * Complex.I)) • f :=
  momentum_position_commutator 2 f

end

end EPR.Audit.Continuum
