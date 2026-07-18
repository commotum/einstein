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
a normalized Hilbert-space state. It also does not supply spectral projectors,
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
delta. This is the generalized position eigen-equation behind Eq. (14). -/
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

/-- A generalized Fourier plane wave satisfies the distributional derivative
eigen-equation with coefficient `2π k i`. No separate nonzeroness theorem is
claimed here. -/
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
`h` appears in its eigenrelation theorem. -/
def eprMomentumMode (h p : ℝ) : 𝓢'(ℝ, ℂ) :=
  generalizedPlaneWave (p / h)

/-- Eq. (2)'s mode satisfies the generalized momentum eigen-equation with
coefficient `p` when `h ≠ 0`; this does not make it an `L²` vector or separately
prove the distribution nonzero. -/
theorem eprMomentumMode_eigenrelation {h p : ℝ} (hh : h ≠ 0) :
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

/-- The minus sign in Eq. (12) gives the generalized momentum eigen-equation
with coefficient `-p`; the constant offset phase does not alter the equation. -/
theorem eprShiftedOppositeMomentumMode_eigenrelation {h p x₀ : ℝ}
    (hh : h ≠ 0) :
    distributionalMomentum h (eprShiftedOppositeMomentumMode h p x₀) =
      ((-p : ℝ) : ℂ) • eprShiftedOppositeMomentumMode h p x₀ := by
  rw [eprShiftedOppositeMomentumMode, map_smul,
    eprMomentumMode_eigenrelation hh]
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

/-- The integral of a unit directional derivative of a Schwartz function on
the real line vanishes. The proof reads this integral as the Fourier transform
at frequency zero. -/
theorem integral_lineDeriv_schwartz_eq_zero (g : 𝓢(ℝ, ℂ)) :
    ∫ t : ℝ, (∂_{(1 : ℝ)} g) t = 0 := by
  have h := congrArg (fun q : 𝓢(ℝ, ℂ) => q 0)
    (SchwartzMap.fourier_lineDerivOp_eq g (1 : ℝ))
  rw [SchwartzMap.fourier_coe, Real.fourier_eq'] at h
  have hgrowth : Function.HasTemperateGrowth
      (fun x : ℝ => inner ℝ x (1 : ℝ)) := by
    fun_prop
  rw [smul_apply, SchwartzMap.smulLeftCLM_apply_apply hgrowth] at h
  simpa using h

/-- Differentiating a test function after restriction to the affine EPR line
is the diagonal directional derivative of the original test function. -/
theorem affineLineRestriction_lineDeriv (x₀ : ℝ)
    (f : 𝓢(ℝ × ℝ, ℂ)) (t : ℝ) :
    (∂_{(1 : ℝ)} (affineLineRestriction x₀ f)) t =
      (∂_{((1 : ℝ), (1 : ℝ))} f) (t, t + x₀) := by
  rw [SchwartzMap.lineDerivOp_apply, SchwartzMap.lineDerivOp_apply]
  rw [(affineLineRestriction x₀ f).differentiableAt.lineDeriv_eq_fderiv,
    f.differentiableAt.lineDeriv_eq_fderiv]
  change deriv (affineLineRestriction x₀ f : ℝ → ℂ) t =
    fderiv ℝ (f : (ℝ × ℝ) → ℂ) (t, t + x₀) (1, 1)
  have hembed : HasDerivAt (fun s : ℝ => (s, s + x₀))
      ((1 : ℝ), (1 : ℝ)) t :=
    (hasDerivAt_id t).prodMk ((hasDerivAt_id t).add_const x₀)
  have hcomp := (f.hasFDerivAt (t, t + x₀)).comp_hasDerivAt t hembed
  have hfun : (affineLineRestriction x₀ f : ℝ → ℂ) =
      fun s : ℝ => f (affineLineEmbedding x₀ s) := by
    rfl
  rw [hfun]
  simpa [Function.comp_def, affineLineEmbedding, diagonalEmbedding] using
    hcomp.deriv

/-- The affine-line delta is invariant along its tangent direction. This is
the distributional derivative relation underlying exact total-momentum zero. -/
theorem affineLineDelta_diagonalDerivative (x₀ : ℝ) :
    ∂_{((1 : ℝ), (1 : ℝ))} (affineLineDelta x₀) = 0 := by
  ext f
  rw [TemperedDistribution.lineDerivOp_apply_apply]
  change affineLineDelta x₀ (-∂_{((1 : ℝ), (1 : ℝ))} f) = 0
  rw [affineLineDelta_apply]
  simp only [neg_apply, integral_neg]
  have hi :
      (∫ t : ℝ, (∂_{((1 : ℝ), (1 : ℝ))} f) (t, t + x₀)) = 0 := by
    rw [← integral_lineDeriv_schwartz_eq_zero
      (affineLineRestriction x₀ f)]
    congr 1
    funext t
    exact (affineLineRestriction_lineDeriv x₀ f t).symm
  rw [hi, neg_zero]

/-- `P₁ + P₂` on two-variable tempered distributions, expressed as the
paper-scaled derivative in the diagonal direction. -/
def jointMomentumSum (h : ℝ) :
    𝓢'(ℝ × ℝ, ℂ) →L[ℂ] 𝓢'(ℝ × ℝ, ℂ) :=
  ((h : ℂ) / (2 * Real.pi * Complex.I)) •
    LineDeriv.lineDerivOpCLM ℂ (𝓢'(ℝ × ℝ, ℂ)) ((1 : ℝ), (1 : ℝ))

/-- The relative-position coordinate `x₂ - x₁` as a continuous real-linear
map into `ℂ`. -/
def relativePosition : ℝ × ℝ →L[ℝ] ℂ :=
  Complex.ofRealCLM.comp
    (ContinuousLinearMap.snd ℝ ℝ ℝ - ContinuousLinearMap.fst ℝ ℝ ℝ)

/-- The affine-line delta satisfies the coefficient-`x₀` relative-position
operator equation. This is the checked distributional position-correlation
half of Eq. (9); nonzeroness is not part of this theorem. -/
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
operator relation. This algebraic equality also holds at `h = 0`, where
`eprCorrelation` is zero; interpreting it as a nonzero generalized state uses
the source's physical `h > 0` and would additionally require a nonzeroness
proof not supplied here. -/
theorem eprCorrelation_relativePosition (h x₀ : ℝ) :
    TemperedDistribution.smulLeftCLM ℂ relativePosition
        (eprCorrelation h x₀) =
      (x₀ : ℂ) • eprCorrelation h x₀ := by
  rw [eprCorrelation, map_smul, affineLineDelta_relativePosition]
  simp only [smul_smul]
  rw [mul_comm]

/-- The paper-scaled affine-line correlation has exact total momentum zero:
`(P₁ + P₂) Ψ = 0` as a tempered-distribution equality. As above, the theorem
is an algebraic relation for every `h`, not a separate proof that the
distribution is nonzero. -/
theorem eprCorrelation_jointMomentumSum (h x₀ : ℝ) :
    jointMomentumSum h (eprCorrelation h x₀) = 0 := by
  rw [jointMomentumSum, smul_apply, eprCorrelation, map_smul,
    LineDeriv.lineDerivOpCLM_apply, affineLineDelta_diagonalDerivative,
    smul_zero, smul_zero]

end

end EPR.Continuum
