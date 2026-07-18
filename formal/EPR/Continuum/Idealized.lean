module

public import Mathlib.Analysis.Distribution.TemperedDistribution

/-!
# Idealized continuous-variable EPR calculations

This independent analytic leaf gives a rigorous generalized-state status to a
stable fragment of EPR's original position--momentum construction. Ordinary
plane waves are proved nonintegrable and non-`L²`; Dirac and affine-line
objects are tempered distributions; and position and momentum act on the
explicit common invariant domain `𝓢(ℝ, ℂ)`.

The module does **not** turn any generalized eigenfunction or distribution into
a normalized project state. It also does not supply spectral projectors,
continuous Born probabilities, conditional measurement states, or an instance
of the exact EPR reality criterion. In particular, `eprCorrelation` names the
audited distribution `h δ(x₁ - x₂ + x₀)`; it is not a claim that the paper's
raw oscillatory momentum integral converges as an ordinary integral.
-/

@[expose] public section

namespace EPR.Continuum

open MeasureTheory ContinuousLinearMap FourierTransform LineDeriv
open scoped ENNReal SchwartzMap FourierTransform LineDeriv

noncomputable section

/-! ## Plane waves and the false normalization -/

/-- The positive-phase Fourier plane wave with frequency `k`, using mathlib's
`2π` Fourier convention. This is an ordinary function, not an `L²` state. -/
def planeWave (k x : ℝ) : ℂ :=
  Complex.exp (((2 * Real.pi * k * x : ℝ) : ℂ) * Complex.I)

@[simp]
theorem planeWave_norm (k x : ℝ) : ‖planeWave k x‖ = 1 := by
  simpa [planeWave] using
    Complex.norm_exp_ofReal_mul_I (2 * Real.pi * k * x)

/-- A real-line plane wave is not square-integrable, including at frequency
zero. This prevents Eq. (2) from being used as a normalized `L²` state. -/
theorem planeWave_not_memLp_two (k : ℝ) :
    ¬ MemLp (planeWave k) 2 (volume : Measure ℝ) := by
  intro h
  have hconst : MemLp (fun _ : ℝ => (1 : ℂ)) 2 (volume : Measure ℝ) :=
    h.congr_norm (by fun_prop) <| Filter.Eventually.of_forall fun x => by
      simp [planeWave_norm]
  rw [memLp_const_iff (by norm_num) (by norm_num)] at hconst
  simp at hconst

/-- The same constant-modulus plane wave is not Lebesgue integrable over the
whole real line. -/
theorem planeWave_not_integrable (k : ℝ) :
    ¬ Integrable (planeWave k) (volume : Measure ℝ) := by
  rw [← memLp_one_iff_integrable]
  intro h
  have hconst : MemLp (fun _ : ℝ => (1 : ℂ)) 1 (volume : Measure ℝ) :=
    h.congr_norm (by fun_prop) <| Filter.Eventually.of_forall fun x => by
      simp [planeWave_norm]
  rw [memLp_const_iff (by norm_num) (by norm_num)] at hconst
  simp at hconst

/-- The oriented interval weight computed in Eq. (6). The name deliberately
does not call this a probability: the total real-line mass is infinite. -/
def unnormalizedIntervalWeight (k a b : ℝ) : ℝ :=
  ∫ x in a..b, ‖planeWave k x‖ ^ 2

/-- Eq. (6)'s calculation is algebraically correct as an oriented interval
integral, but it is not normalized probability. For `a ≤ b` it is the
nonnegative Lebesgue interval mass `b - a`. -/
theorem unnormalizedIntervalWeight_eq (k a b : ℝ) :
    unnormalizedIntervalWeight k a b = b - a := by
  simp [unnormalizedIntervalWeight, planeWave_norm]

/-! ## Fourier deltas and generalized momentum modes -/

/-- In mathlib's Fourier convention, inverse Fourier transform of Lebesgue
volume is the Dirac delta at zero. This is an equality of tempered
distributions. -/
theorem fourierInv_volume_eq_delta_zero :
    𝓕⁻ ((volume : Measure ℝ).toTemperedDistribution) =
      TemperedDistribution.delta (0 : ℝ) := by
  rw [← TemperedDistribution.fourier_delta_zero]
  exact fourierInv_fourier_eq _

/-- The positive-phase generalized plane wave is the inverse Fourier
transform of a point mass in frequency space. -/
def generalizedPlaneWave (k : ℝ) : 𝓢'(ℝ, ℂ) :=
  𝓕⁻ (TemperedDistribution.delta k)

/-- The generalized plane wave acts by integration against the corresponding
ordinary constant-modulus function. -/
theorem generalizedPlaneWave_apply (k : ℝ) (f : 𝓢(ℝ, ℂ)) :
    generalizedPlaneWave k f = ∫ x : ℝ, planeWave k x * f x := by
  rw [generalizedPlaneWave, TemperedDistribution.fourierInv_apply,
    TemperedDistribution.delta_apply, SchwartzMap.fourierInv_coe,
    Real.fourierInv_eq']
  simp only [Real.inner_apply, smul_eq_mul]
  congr 1
  funext x
  unfold planeWave
  congr 3
  ring_nf

/-- Multiplication by position sends a Dirac delta at `k` to `k` times that
delta. This is the generalized position-eigenvalue relation behind Eq. (14). -/
theorem delta_position_eigenrelation (k : ℝ) :
    TemperedDistribution.smulLeftCLM ℂ (fun x : ℝ => (x : ℂ))
        (TemperedDistribution.delta k) =
      (k : ℂ) • TemperedDistribution.delta k := by
  ext f
  rw [TemperedDistribution.smulLeftCLM_apply_apply,
    TemperedDistribution.delta_apply,
    SchwartzMap.smulLeftCLM_apply_apply (by fun_prop), smul_apply,
    TemperedDistribution.delta_apply]

/-- A unit directional distributional derivative is the ordinary
one-dimensional distributional derivative. -/
theorem lineDeriv_one_eq_deriv (u : 𝓢'(ℝ, ℂ)) :
    ∂_{(1 : ℝ)} u = TemperedDistribution.derivCLM ℂ u := by
  ext f
  rw [TemperedDistribution.lineDerivOp_apply_apply,
    TemperedDistribution.derivCLM_apply_apply]
  congr 2

/-- A generalized Fourier plane wave is an eigen-distribution of the
distributional derivative with eigenvalue `2π k i`. -/
theorem deriv_generalizedPlaneWave (k : ℝ) :
    TemperedDistribution.derivCLM ℂ (generalizedPlaneWave k) =
      (((2 * Real.pi * k : ℝ) : ℂ) * Complex.I) •
        generalizedPlaneWave k := by
  rw [← lineDeriv_one_eq_deriv, generalizedPlaneWave,
    TemperedDistribution.lineDerivOp_fourierInv_eq]
  have hinner : (fun x : ℝ => ((inner ℝ x (1 : ℝ) : ℝ) : ℂ)) =
      fun x : ℝ => (x : ℂ) := by
    funext x
    simp
  rw [hinner, delta_position_eigenrelation, smul_smul,
    FourierTransform.fourierInv_smul]
  congr 1
  push_cast
  ring_nf

/-- The paper's momentum coefficient `h/(2πi)` acting on tempered
distributions. This is a generalized-state operator, not a self-adjoint
operator package on a Hilbert-space domain. -/
def distributionalMomentum (h : ℝ) : 𝓢'(ℝ, ℂ) →L[ℂ] 𝓢'(ℝ, ℂ) :=
  ((h : ℂ) / (2 * Real.pi * Complex.I)) •
    TemperedDistribution.derivCLM ℂ

/-- Eq. (2)'s momentum mode, with frequency `p/h`. The nonzero hypothesis on
`h` appears in its eigenvalue theorem. -/
def eprMomentumMode (h p : ℝ) : 𝓢'(ℝ, ℂ) :=
  generalizedPlaneWave (p / h)

/-- Eq. (2) is a generalized momentum eigenstate with eigenvalue `p` when
`h ≠ 0`; this does not make it an `L²` vector. -/
theorem eprMomentumMode_eigenvalue {h p : ℝ} (hh : h ≠ 0) :
    distributionalMomentum h (eprMomentumMode h p) =
      (p : ℂ) • eprMomentumMode h p := by
  rw [distributionalMomentum, smul_apply, eprMomentumMode,
    deriv_generalizedPlaneWave, smul_smul]
  rw [show
    ((h : ℂ) / (2 * Real.pi * Complex.I)) *
        (((2 * Real.pi * (p / h) : ℝ) : ℂ) * Complex.I) = (p : ℂ) by
      push_cast
      field_simp [hh]]

/-- Eq. (12)'s opposite-momentum mode, including the constant phase contributed
by the position offset `x₀`. -/
def eprShiftedOppositeMomentumMode (h p x₀ : ℝ) : 𝓢'(ℝ, ℂ) :=
  Complex.exp ((((2 * Real.pi * x₀ * p) / h : ℝ) : ℂ) * Complex.I) •
    eprMomentumMode h (-p)

/-- The minus sign in Eq. (12) gives generalized momentum eigenvalue `-p`;
the constant offset phase does not alter the eigenvalue. -/
theorem eprShiftedOppositeMomentumMode_eigenvalue {h p x₀ : ℝ}
    (hh : h ≠ 0) :
    distributionalMomentum h (eprShiftedOppositeMomentumMode h p x₀) =
      ((-p : ℝ) : ℂ) • eprShiftedOppositeMomentumMode h p x₀ := by
  rw [eprShiftedOppositeMomentumMode, map_smul,
    eprMomentumMode_eigenvalue hh]
  simp only [smul_smul]
  rw [mul_comm]

/-! ## Position and momentum on their named common domain -/

/-- Position multiplication restricted to the common invariant Schwartz
domain. -/
def positionSchwartz : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  SchwartzMap.smulLeftCLM ℂ (fun x : ℝ => (x : ℂ))

/-- The paper's momentum operator `h/(2πi) d/dx`, restricted to Schwartz
space. -/
def momentumSchwartz (h : ℝ) : 𝓢(ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  ((h : ℂ) / (2 * Real.pi * Complex.I)) • SchwartzMap.derivCLM ℂ ℂ

@[simp]
theorem positionSchwartz_apply (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    positionSchwartz f x = (x : ℂ) * f x := by
  have hx : Function.HasTemperateGrowth (fun y : ℝ => (y : ℂ)) := by
    fun_prop
  simp only [positionSchwartz,
    SchwartzMap.smulLeftCLM_apply_apply hx, smul_eq_mul]

@[simp]
theorem momentumSchwartz_apply (h : ℝ) (f : 𝓢(ℝ, ℂ)) (x : ℝ) :
    momentumSchwartz h f x =
      ((h : ℂ) / (2 * Real.pi * Complex.I)) * deriv f x := by
  simp [momentumSchwartz, smul_eq_mul]

/-- Eq. (18), with its exact sign, on the explicitly named common invariant
domain `𝓢(ℝ, ℂ)`. No bounded or everywhere-defined `L²` identity is claimed. -/
theorem momentum_position_commutator (h : ℝ) (f : 𝓢(ℝ, ℂ)) :
    momentumSchwartz h (positionSchwartz f) -
        positionSchwartz (momentumSchwartz h f) =
      ((h : ℂ) / (2 * Real.pi * Complex.I)) • f := by
  ext x
  have hderiv := (hasDerivAt_id x).smul (f.hasDerivAt x)
  have hposition :
      (positionSchwartz f : ℝ → ℂ) = (id : ℝ → ℝ) • (f : ℝ → ℂ) := by
    funext y
    rw [positionSchwartz_apply]
    change (y : ℂ) * f y = y • f y
    exact Complex.real_smul.symm
  have hpositionDeriv :
      deriv (positionSchwartz f : ℝ → ℂ) x = x • deriv f x + f x := by
    rw [hposition]
    simpa only [id_eq, one_smul] using hderiv.deriv
  change
    momentumSchwartz h (positionSchwartz f) x -
        positionSchwartz (momentumSchwartz h f) x =
      ((h : ℂ) / (2 * Real.pi * Complex.I)) * f x
  rw [momentumSchwartz_apply, positionSchwartz_apply,
    momentumSchwartz_apply, hpositionDeriv]
  simp only [Complex.real_smul]
  ring

/-! ## The affine-line correlation distribution -/

/-- The diagonal continuous linear embedding `t ↦ (t,t)`. -/
def diagonalEmbedding : ℝ →L[ℝ] ℝ × ℝ :=
  (ContinuousLinearMap.id ℝ ℝ).prod (ContinuousLinearMap.id ℝ ℝ)

/-- The affine line `t ↦ (t,t+x₀)` supporting
`δ(x₁ - x₂ + x₀)`. -/
def affineLineEmbedding (x₀ : ℝ) (t : ℝ) : ℝ × ℝ :=
  diagonalEmbedding t + (0, x₀)

theorem affineLineEmbedding_hasTemperateGrowth (x₀ : ℝ) :
    Function.HasTemperateGrowth (affineLineEmbedding x₀) := by
  unfold affineLineEmbedding
  fun_prop

theorem affineLineEmbedding_antilipschitz (x₀ : ℝ) :
    AntilipschitzWith 1 (affineLineEmbedding x₀) := by
  intro x y
  simp [affineLineEmbedding, diagonalEmbedding, Prod.edist_eq]

/-- Restrict a two-variable Schwartz function to the affine correlation line. -/
def affineLineRestriction (x₀ : ℝ) :
    𝓢(ℝ × ℝ, ℂ) →L[ℂ] 𝓢(ℝ, ℂ) :=
  SchwartzMap.compCLMOfAntilipschitz ℂ
    (affineLineEmbedding_hasTemperateGrowth x₀)
    (affineLineEmbedding_antilipschitz x₀)

/-- The tempered distribution conventionally written
`δ(x₁ - x₂ + x₀)`: it integrates test functions along `x₂ = x₁ + x₀`. -/
def affineLineDelta (x₀ : ℝ) : 𝓢'(ℝ × ℝ, ℂ) :=
  toPointwiseConvergenceCLM _ _ _ _
    (SchwartzMap.integralCLM ℂ (volume : Measure ℝ) ∘L
      affineLineRestriction x₀)

theorem affineLineDelta_apply (x₀ : ℝ) (f : 𝓢(ℝ × ℝ, ℂ)) :
    affineLineDelta x₀ f = ∫ t : ℝ, f (t, t + x₀) := by
  change (∫ t : ℝ, f (affineLineEmbedding x₀ t)) = _
  congr 1
  funext t
  simp [affineLineEmbedding, diagonalEmbedding]

/-- The relative-position coordinate `x₂ - x₁` as a continuous real-linear
map into `ℂ`. -/
def relativePosition : ℝ × ℝ →L[ℝ] ℂ :=
  Complex.ofRealCLM.comp
    (ContinuousLinearMap.snd ℝ ℝ ℝ - ContinuousLinearMap.fst ℝ ℝ ℝ)

/-- The affine-line delta has exact relative-position value `x₀`. This is the
checked distributional position-correlation half of Eq. (9). -/
theorem affineLineDelta_relativePosition (x₀ : ℝ) :
    TemperedDistribution.smulLeftCLM ℂ relativePosition
        (affineLineDelta x₀) =
      (x₀ : ℂ) • affineLineDelta x₀ := by
  ext f
  have hg : Function.HasTemperateGrowth
      (relativePosition : ℝ × ℝ → ℂ) := by
    fun_prop
  simp only [TemperedDistribution.smulLeftCLM_apply_apply,
    affineLineDelta_apply]
  change
    (∫ t : ℝ, (SchwartzMap.smulLeftCLM ℂ relativePosition f)
      (t, t + x₀)) = (x₀ : ℂ) * affineLineDelta x₀ f
  rw [affineLineDelta_apply]
  have hrelative (t : ℝ) :
      relativePosition (t, t + x₀) = (x₀ : ℂ) := by
    simp [relativePosition]
  calc
    (∫ t : ℝ, (SchwartzMap.smulLeftCLM ℂ relativePosition f)
        (t, t + x₀)) =
        ∫ t : ℝ, relativePosition (t, t + x₀) * f (t, t + x₀) := by
      congr 1
      funext t
      rw [SchwartzMap.smulLeftCLM_apply_apply hg]
      rfl
    _ = ∫ t : ℝ, (x₀ : ℂ) * f (t, t + x₀) := by
      congr 1
      funext t
      rw [hrelative]
    _ = (x₀ : ℂ) * ∫ t : ℝ, f (t, t + x₀) :=
      integral_const_mul (μ := volume) (x₀ : ℂ)
        (fun t : ℝ => f (t, t + x₀))

/-- The distribution identified by the paper's Fourier audit for Eq. (9),
namely `h δ(x₁ - x₂ + x₀)`. The source convention assumes physical `h > 0`. -/
def eprCorrelation (h x₀ : ℝ) : 𝓢'(ℝ × ℝ, ℂ) :=
  (h : ℂ) • affineLineDelta x₀

theorem eprCorrelation_apply (h x₀ : ℝ) (f : 𝓢(ℝ × ℝ, ℂ)) :
    eprCorrelation h x₀ f = (h : ℂ) * ∫ t : ℝ, f (t, t + x₀) := by
  simp [eprCorrelation, affineLineDelta_apply]

/-- Scaling by the paper's factor `h` preserves the exact relative-position
correlation. -/
theorem eprCorrelation_relativePosition (h x₀ : ℝ) :
    TemperedDistribution.smulLeftCLM ℂ relativePosition
        (eprCorrelation h x₀) =
      (x₀ : ℂ) • eprCorrelation h x₀ := by
  rw [eprCorrelation, map_smul, affineLineDelta_relativePosition]
  simp only [smul_smul]
  rw [mul_comm]

end

end EPR.Continuum
