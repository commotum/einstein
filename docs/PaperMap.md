# EPR 1935 Paper Map

This is the living map from *Can Quantum-Mechanical Description of Physical
Reality Be Considered Complete?* to the Lean library. The status column
distinguishes checked declarations from later obligations.

| Paper locus | Source claim or construction | Formal treatment | Current status |
| --- | --- | --- | --- |
| Printed p. 777, §1 completeness condition | Every element of physical reality must have a counterpart in a complete physical theory. | `CompleteFor I theory r` yields only `TheoryCounterpart I theory q` for each context-indexed `ElementOfReality I r c q`. Definite-value joint representation is a further premise, `CompletenessRepresentationBridge`. | Checked in `EPR.Logic.EPR` by `theoryCounterpart_of_complete` and `joint_representation_of_complete`. |
| Printed p. 777, §1 reality criterion | Prediction with certainty—probability one—without disturbance is a sufficient, not necessary, condition for an element of reality. | `OutcomeObtained`, `CertainPrediction`, and `NoOnticDisturbance` are separate antecedents of the supplied `RealityCriterion`; it concludes `ElementOfReality`. The separately supplied `RealityValueBridge` concludes `PossessesValue` for the predicted value. | Checked as a conditional interface in `EPR.Logic.EPR`; none of the criterion, actuality, ontic, or value premises is asserted as a fact of nature. |
| Printed p. 778, Eqs. (2)–(4) | The positive-phase plane wave has exact momentum value `p₀` under `P = h/(2πi) d/dx`. | `planeWave_not_memLp_two` and `planeWave_not_integrable` reject normalized-state use. `generalizedPlaneWave` is `𝓕⁻δ`; with `h ≠ 0`, `eprMomentumMode_eigenvalue` proves the eigenvalue `p₀` in tempered distributions. | Generalized eigenrelation and nonnormalizability checked in `EPR.Continuum.Idealized`; no `PureState`/`DensityState` or Born-probability claim. |
| Printed p. 778, Eqs. (5)–(6) | Multiplication by position is not sharp in the plane wave; integrating its unit modulus over `[a,b]` gives `b-a`, described as relative probability. | `unnormalizedIntervalWeight_eq` checks `b-a` only as oriented Lebesgue interval weight. `eq6_can_exceed_one` checks value two on `[0,2]`; the total real-line mass is infinite. | Calculation and normalization obstruction checked; it is deliberately not encoded as probability. |
| Printed p. 778, paragraphs after Eq. (6) | The paper states a disjunction: the wave-function description is incomplete, or noncommuting quantities cannot have simultaneous reality. | Keep matrix noncommutation, common-eigenvector exclusion, and absence of a jointly sharp density state distinct. The final finite contradiction uses `NoJointSharpState`, not bare noncommutation. | `EPR.Quantum.Incompatibility` makes the distinctions; `EPR.Examples.PauliIncompatibility` proves `pauliXZ_noJointSharpState`; `EPR.Audit.Incompatibility` supplies a noncommuting pair with a common jointly sharp state. |
| Printed p. 779, Eqs. (7)–(8) | Alternative measurements on system I select different relative states of system II after a source outcome is found. | Represent each selected coefficient by a raw subnormalized relative branch, normalize only for positive probability, and keep the possible branch distinct from the assertion `OutcomeObtained`. | `EPR.Quantum.Conditional` supplies conditioning; `EPR.Quantum.Steering` packages nonvacuous conditional certainty; `EPR.Examples.BellSteering` checks all four `bellPhiPlus` branches. Stage 8's Bell adapter keeps actuality separate. |
| Modern finite operational result, not a separate paper claim | Discarding the outcome of a complete projective Lüders measurement on A leaves B's unconditioned reduced density and every projective Born statistic unchanged. | Sum the raw weighted local branches, prove directional A-to-B reduced-state equality, and keep this outcome-forgotten state distinct from every selected conditional state. | `EPR.Quantum.NoSignalling` proves the generic finite result; `EPR.Examples.BellNoSignalling` checks both Bell/Pauli source settings and their selected-state contrast. |
| Printed p. 779, paragraph after Eq. (8) | Because I and II no longer interact, the paper says that an operation on I causes no real change in II. | `NoOnticDisturbance s` means equality of the modeled prior and post realities. It is an explicit ontic premise, not a consequence of absent interaction or `OperationalNoSignallingAtoB`. | Checked as a separate predicate in `EPR.Logic.EPR`; `EPR.Audit.EPRLogic.operational_noSignalling_with_ontic_change` demonstrates operational no-signalling coexisting with its denial in a toy ontology. |
| Printed p. 779, “two different wave functions … same reality” | Two alternative conditional wave functions are assigned to the same underlying reality of II. | `SamePriorReality s t`, together with `NoOnticDisturbance s` and `NoOnticDisturbance t`, transports the alternatives to `SamePostReality s t`. This transport is distinct from counterfactual aggregation. | Checked by `samePostReality_of_noOnticDisturbance`; the equality premises remain explicit. |
| Printed pp. 779–780, Eq. (9) | The oscillatory momentum integral is intended as a two-particle object with exact relative-position and opposite-momentum correlations. | For physical `h > 0` its audited distributional target is `h δ(x₁-x₂+x₀)`, not an `L²(ℝ²)` wavefunction. `affineLineDelta` pairs tests as `∫f(t,t+x₀)dt`; `eprCorrelation_relativePosition` and `eprCorrelation_jointMomentumSum` prove `(Q₂-Q₁)Ψ=x₀Ψ` and `(P₁+P₂)Ψ=0`. | Affine-line pairing, scaling, and both algebraic correlation relations checked. The raw oscillatory-integral equality, topological-support/non-`L²` representability theorems, and continuous conditioning remain named extension obligations. |
| Printed pp. 779–780, Eqs. (10)–(13) | Continuous momentum modes on I select an opposite-momentum coefficient mode on II. | Both signs are non-`L²`. `eprMomentumMode_eigenvalue` checks `+p`; `eprShiftedOppositeMomentumMode_eigenvalue` includes the `x₀` phase and checks `-p`, with `h ≠ 0`, as tempered-distribution eigenrelations. Eq. (11) is distributional, not a Bochner `L²` expansion. | Mode signs/eigenvalues and nonnormalizability checked. Delta normalization, direct-integral coefficient extraction, and spectral conditioning remain outside the current API. |
| Printed p. 780, Eqs. (14)–(17) | Dirac position modes yield the selected coefficient `hδ(x-x₂+x₀)` with value `x+x₀` for `Q₂`. | `delta_position_eigenrelation` proves the generalized delta eigenrelation; `affineLineDelta_apply` checks the joint affine-line pairing convention and the multiplier theorem checks the relative coordinate. Deltas remain distributions, never normalized vectors. | Generalized position relation and affine-line pairing checked. The full Eq. (15) distributional expansion, topological support/non-`L²` representability, and a continuous selected-state semantics remain extension obligations. |
| Printed p. 780, Eq. (18) | `PQ-QP = h/(2πi)`. | `positionSchwartz` and `momentumSchwartz` act on the named common invariant domain `𝓢(ℝ,ℂ)`; `momentum_position_commutator` proves the source sign there. | Checked on Schwartz space only; no everywhere-defined bounded `L²` identity or self-adjoint/maximal-domain theorem is claimed. |
| Printed p. 780, first final paragraph | Either remote choice permits a certainty claim and hence a context-specific element of reality; both alternatives are then treated as belonging to one reality. | Checked `CertainPrediction` plus supplied actuality, `NoOnticDisturbance`, and `RealityCriterion` produce each `ElementOfReality`; `RealityValueBridge` produces each `PossessesValue`; `CounterfactualStability` alone aggregates them into `SimultaneouslyReal`. | `simultaneous_reality_of_alternative_predictions` checks the full conditional chain without identifying any adjacent step. |
| Printed p. 780, incompleteness paragraph | Assuming completeness and simultaneous reality conflicts with the wave-function description. | `CompleteFor` supplies two `TheoryCounterpart`s; `CompletenessRepresentationBridge` turns those counterparts and `SimultaneouslyReal` into `JointlyRepresents`; a separate no-joint-representation fact refutes relative completeness. | `epr_incompleteness` proves the abstract conditional result. `bellPhiPlus_epr_incompleteness` specializes it using the bundled four-branch Bell scenario and the `pauliXZ_noJointSharpState` contradiction. |
| Printed p. 780, objection paragraph | The paper rejects making simultaneous reality depend on which remote measurement is chosen. | Preserve that disputed move as the explicit `CounterfactualStability` premise rather than deriving it from certainty or same-reality transport. | Checked as an independently rejectable premise by `counterfactualStability_rejectable`. |
| Printed p. 780, final paragraph | A complete replacement theory might exist. | The conclusion is only `¬ CompleteFor I theory r` for the supplied description and reality; it is not a theorem that no complete theory exists. | The abstract and Bell theorems have this relative, conditional conclusion. |

For the finite reconstruction of Eqs. (7)–(8), a coefficient wave function
associated with one basis outcome generally has squared norm equal to that
outcome's probability, rather than norm one. `localARelativeBBranch` is the
density-level analogue of that raw coefficient branch; its weight is the local
outcome probability, and `localAConditionalBState` is available only after a
strictly positive-probability proof permits normalization. The projective
Lüders treatment of degenerate outcomes and the explicit nonselective state
are documented modern modeling choices. They clarify omissions in the paper;
they are not presented as measurement rules derived from its text. This
normalization correction is recorded as C-009 in `docs/Corrections.md`.

## Stage 9 continuous-variable boundary

`EPR.Continuum.Idealized` is a separate analytic leaf importing only pinned
mathlib's tempered-distribution infrastructure. It is deliberately absent from
the finite quantum, Bell, operational no-signalling, and logical dependency
chains. Its declarations divide the source calculations into three types:

1. `planeWave` is an ordinary complex function used only for pointwise norm
   and integration facts. `planeWave_not_memLp_two` and
   `planeWave_not_integrable` rule out normalized real-line state semantics;
   `unnormalizedIntervalWeight_eq` preserves Eq. (6)'s algebra without calling
   it probability.
2. `generalizedPlaneWave`, `eprMomentumMode`, deltas, `affineLineDelta`, and
   `eprCorrelation` are tempered distributions. Their theorems are equality or
   generalized-eigenvalue statements in `𝓢'`, not Hilbert-vector norm or Born-
   probability statements. `generalizedPlaneWave_apply` fixes the positive
   Fourier sign, while the two EPR mode theorems check eigenvalues `p` and
   `-p`.
3. `positionSchwartz` and `momentumSchwartz` act on `𝓢(ℝ,ℂ)`.
   `momentum_position_commutator` is therefore a common-domain identity; it
   does not assert an equality of everywhere-defined bounded `L²` operators.

The source audit uses `h > 0`, hence
`∫ exp(2πiyp/h) dp = hδ(y)`. For an arbitrary nonzero real scale, the delta
scaling factor is `|h|`. The checked `affineLineDelta` convention has no hidden
Jacobian because it pairs a test function as `∫ f(t,t+x₀) dt`.

Three groups of obligations remain visible rather than assumed:

- prove the paper's raw oscillatory `p`-integral equals the scaled affine-line
  distribution through an explicit partial-Fourier/change-of-variables
  construction;
- prove topological support/non-`L²` representability of the affine-line
  distribution if those stronger classifications are needed beyond its
  checked pairing and multiplier/derivative relations;
- construct concrete self-adjoint position and momentum operators, their
  maximal domains and spectral PVMs, if literal continuous Born probabilities
  are required; and
- develop measurable continuous-outcome conditioning before calling any exact
  branch a `PerfectConditionalPrediction`.

Pinned mathlib has no packaged partial Fourier transform/Schwartz kernel
theorem, unbounded spectral theorem, or projection-valued-measure layer that
discharges those obligations. A Gaussian or box regularization would instead
prove finite-resolution, high-probability correlations and would require an
  additional approximate or limiting reality premise. Stage 9 therefore neither
  uses an approximant nor connects its distributions to the exact Stage 8
  reality criterion.

## Target finite-dimensional analogue

The normalized finite example fixes the ordered basis `A × B`, the Bell state
`|Φ⁺⟩ = (|00⟩ + |11⟩)/√2`, and Pauli `Z`/`X` measurements. Outcome label `0`
has value `+1`, label `1` has value `-1`, and the response map is the identity:
both settings have same-label correlations.

| Setting | A label/value | A probability | Raw relative B branch | Normalized conditional B state | Target probability/value |
| --- | --- | --- | --- | --- | --- |
| `Z` | `0 / +1` | `1/2` | `(1/2) • (zState 0).toDensity` | `(zState 0).toDensity` | `1 / +1` |
| `Z` | `1 / -1` | `1/2` | `(1/2) • (zState 1).toDensity` | `(zState 1).toDensity` | `1 / -1` |
| `X` | `0 / +1` | `1/2` | `(1/2) • (xState 0).toDensity` | `(xState 0).toDensity` | `1 / +1` |
| `X` | `1 / -1` | `1/2` | `(1/2) • (xState 1).toDensity` | `(xState 1).toDensity` | `1 / -1` |

`bellPhiPlus_z_expansion` and `bellPhiPlus_x_expansion` check the two exact
basis expansions. The uniform branch theorems check probability `1/2`, the
raw relative state, the normalized conditional state, target probability one,
opposite-outcome probability zero, and the corresponding sharp Pauli value.
`bellPhiPlusSteeringScenario` packages all four possible branches; it does not
assert that any outcome actually occurred.

## Stage 8 conditional inference

`EPR.Logic.EPR` represents the paper's compressed logical inference as the
following explicit boundary sequence:

1. `OutcomeObtained I s` says a selected source branch is actual;
   `CertainPrediction I s q v` says its target value is predictable with
   certainty. Neither predicate implies the other.
2. The supplied `RealityCriterion I` consumes actuality, certainty, and
   `NoOnticDisturbance s` to produce a context-indexed `ElementOfReality`. It
   is sufficient-only. The supplied `RealityValueBridge I` separately produces
   `PossessesValue I s.postReality s.context q v`.
3. `SamePriorReality s t` plus ontic stability in both alternative situations
   gives `SamePostReality s t` through
   `samePostReality_of_noOnticDisturbance`. This is same-reality transport, not
   yet a simultaneous-reality claim.
4. The supplied `CounterfactualStability I` combines the two context-specific
   elements and possessed values only after `AlternativeContexts s t` and
   `SamePostReality s t` are known, yielding `SimultaneouslyReal`.
5. `CompleteFor I theory r` converts each reality element only to a
   `TheoryCounterpart I theory q`. The supplied
   `CompletenessRepresentationBridge I` additionally converts simultaneous
   reality and both counterparts to `JointlyRepresents` with the exact values.
6. `epr_incompleteness` derives `¬ CompleteFor I theory s.postReality` only
   after a separate `¬ JointlyRepresents` premise is supplied.

The Bell specialization keeps these boundaries. `BellPerfectPrediction` is
the positive-source-probability, target-probability-one certificate obtained
from `bellPhiPlusSteeringScenario`; `bellCertainPrediction` exposes it as
`CertainPrediction` without asserting `OutcomeObtained`. The theorem
`bellPhiPlus_epr_incompleteness` is outcome-generic in arbitrary selected
`zOutcome` and `xOutcome`. It takes separate Z/X prior and post realities, an
explicit `SamePriorReality` hypothesis, both actuality hypotheses, and every
ontic or interpretative bridge. It consumes the bundled four-branch scenario
for certainty and uses `bellPhiPlus_noJointRepresentation_zx`, whose proof
invokes `pauliXZ_noJointSharpState`. Its conclusion concerns one supplied
density description and the supplied Z-side prior reality, with the common
prior supplied through `SamePriorReality`.

`EPR.Examples.BellEPR` imports no no-signalling module. The operational Bell
theorems remain in `EPR.Examples.BellNoSignalling`; importing both branches at
the public `EPR` root does not create an implication between operational
marginal invariance and ontic no-disturbance.

## Finite incompatibility correction

The finite incompatibility layer distinguishes three propositions. For
observables `A` and `B`, `A.Noncommutes B` is only matrix-product inequality;
`A.HasCommonEigenvector B` requires one nonzero raw ket satisfying both real
eigenvalue equations; and `A.HasJointSharpState B` requires one normalized
pure or mixed density state that is sharp for both. These notions are not
definitionally or logically identified.

`DensityState.exists_col_ne_zero` and
`DensityState.col_isEigenvector_of_sharpValue` show that a trace-one density
matrix sharp for an observable has eigenvector columns. Consequently,
`Observable.hasCommonEigenvector_of_jointlySharp` extracts a common nonzero
eigenvector from a particular jointly sharp density state, and
`Observable.not_jointlySharp_of_noCommonEigenvector` supplies its pointwise
exclusion. `Observable.hasCommonEigenvector_of_hasJointSharpState` and
`Observable.noJointSharpState_of_noCommonEigenvector` are the corresponding
existential wrappers.

For the concrete qubit pair, `pauliXZ_noncommutes` proves matrix
noncommutation, `pauliXZ_noCommonEigenvector` excludes every nonzero common
ket for arbitrary real candidate eigenvalues, and
`pauliXZ_noJointSharpState` excludes every pure or mixed jointly sharp density
state. The state-quantified theorem is `pauliXZ_not_jointlySharp`.

Bare noncommutation cannot replace that stronger result. The checked `Fin 3`
observables `fin3A` and `fin3B` are Hermitian and noncommuting, but the
normalized state `fin3SharedState` is a common eigenstate and its rank-one
density is jointly sharp for both. This is packaged by
`fin3_noncommuting_with_common_sharp_state`. Stage 6 does not prove the
paper's further instrument-dependent statement that measuring one observable
must disturb knowledge of the other, and it draws no conclusion about
simultaneous physical reality.

## Finite operational no-signalling boundary

For any finite bipartite density state `ρ` and complete projective measurement
`M` on A, `localANonselectiveState ρ M` is the outcome-forgotten local Lüders
state. Its matrix is the sum of the raw subnormalized branches
`(P_w ⊗ I) ρ (P_w ⊗ I)`, whose traces already carry their Born weights; it is
not an unweighted sum of normalized conditional states.

`OperationalNoSignallingAtoB ρ M` means exactly that the reduced B state after
this update equals `reducedB ρ`. The theorem
`localA_nonselective_noSignalling` proves that equality, while
`localA_nonselective_outcomeProbability` covers every projective statistic on
B. `localA_nonselective_reducedB_independent` and
`localA_nonselective_outcomeProbability_independent` compare any two complete
source measurements.

For the Bell/Pauli scenario, `bellPhiPlus_operationalNoSignalling` and
`bellPhiPlus_reducedB_invariant` cover either source setting, and
`bellPhiPlus_sourceSetting_independent` compares the settings directly.
`bellPhiPlus_selected_changes_with_noSignalling` separately checks that
different selected B states coexist with both outcome-forgotten measurements
satisfying the operational theorem.

This result is directional from A to B and is limited to finite complete
projective Lüders measurements. It establishes no theorem about arbitrary
channels, communication protocols, spacetime separation, absence of
interaction, physical reality, or ontic disturbance. In particular, the
paper's printed p. 779 inference from no interaction to “no real change” is
encoded in Stage 8 only as the explicit `NoOnticDisturbance` premise.

This construction is a normalized finite role analogue of the alternative-
expansion and conditional-certainty steps. It neither digitizes nor
approximates Eq. (9), does not identify Pauli `X` or `Z` with the paper's
position or momentum operators, and does not consume the generalized `-p`
mode, relative-position offset, or Schwartz commutator checked separately in
Stage 9. No theorem bridges those distributions to the finite conditional-
probability API. Stage 7 checks only the finite operational result above;
Stage 8 checks the conditional EPR inference while leaving actuality, ontic
stability, reality, value, counterfactual, and completeness-representation
claims as named premises.
