# EPR 1935 Paper Map

This is the living map from *Can Quantum-Mechanical Description of Physical
Reality Be Considered Complete?* to the Lean library. Source-line anchors refer
to `einstein-1935/einstein-1935.md`. The disposition column makes literal
checks, modern analogues, explicit premises, corrections, unresolved work, and
out-of-scope claims visibly different.

| Paper locus and transcription anchor | Source claim or construction | Formal treatment | Current status | Disposition |
| --- | --- | --- | --- | --- |
| Printed p. 777, opening scope; lines 20–22 | Objective reality is theory-independent; theoretical concepts picture it. Correctness is empirical agreement, whereas the paper studies completeness. | `EPRInterpretation` keeps `Reality` and `TheoryDescription` as separate type parameters. The library reconstructs the completeness argument but contains no experiment-agreement or empirical-correctness semantics. | Vocabulary separation checked; correctness is intentionally outside the formal objective. | Source scope—partly represented, partly out of scope |
| Printed p. 777, completeness condition; line 24 | Every element of physical reality must have a counterpart in a complete physical theory. | `CompleteFor I theory r` yields only `TheoryCounterpart I theory q` for each context-indexed `ElementOfReality I r c q`. Definite-value joint representation is the further premise `CompletenessRepresentationBridge`. | `theoryCounterpart_of_complete` and `joint_representation_of_complete` check the factored conditional reading. | Explicit interpretative premise and bridge factoring |
| Printed pp. 777–778, reality criterion; line 26 | Prediction with certainty—probability one—without disturbance is a sufficient, not necessary, condition for an element of reality. | `OutcomeObtained`, `CertainPrediction`, and `NoOnticDisturbance` are separate antecedents of the supplied `RealityCriterion`; it concludes `ElementOfReality`. The separately supplied `RealityValueBridge` concludes `PossessesValue`. | Conditional interface checked; no criterion, actuality, ontic, or value premise is asserted as nature. | Explicit interpretative premise |
| Printed p. 778, state/operator setup and Eq. (1); lines 28–37 | A wave function represents the state; observables are operators; an eigenfunction with value `a` gives certainty and, via the criterion, an element of reality. | The reusable finite analogue is `PureState`, `DensityState`, `Observable`, `PureState.IsEigenstate`, and `PureState.toDensity_sharpValue`; `outcomeProbability_eq_one_of_support` supplies projective probability one. The reality conclusion still requires `RealityCriterion`. A continuum operator equation alone is not normalized Born certainty. | Finite eigenstate/sharpness bridge checked; the paper's unrestricted wave-function ontology is not adopted. | Checked finite modern analogue plus explicit premise |
| Printed p. 778, Eqs. (2)–(4); lines 39–58 | The positive-phase plane wave has momentum value `p₀` under `P = h/(2πi) d/dx`. | `planeWave_not_memLp_two` and `planeWave_not_integrable` reject normalized-state use. With `h ≠ 0`, `eprMomentumMode_eigenrelation` checks the coefficient-`p₀` equation in tempered distributions. | Generalized operator equation and nonnormalizability checked; distribution nonzeroness and Born certainty are not claimed. | Corrected source claim—checked generalized relation |
| Printed p. 778, Eq. (5) and coordinate-reality paragraph; lines 60–66 and 76 | The plane wave is not a position eigenfunction; failure of Eq. (1) is used to deny a particular value and the usual reading denies coordinate reality. Direct position measurement is said to disturb the state. | No Lean theorem currently proves Eq. (5) for `planeWave`, and the sufficient-only `RealityCriterion` cannot infer `¬ ElementOfReality` from failure of certainty. A universal measurement-disturbance theorem would require a specified instrument/domain and is not formalized. | Exact equation and disturbance claim are documented, justified unresolved items; the negative ontic inference is rejected as invalid from a sufficient criterion alone. | Corrected source claim and justified unresolved item |
| Printed p. 778, Eq. (6); lines 67–74 | Integrating the plane wave's unit modulus over `[a,b]` gives `b-a`, described as relative probability with all positions equally probable. | `unnormalizedIntervalWeight_eq` checks `b-a` only as oriented Lebesgue interval weight; `eq6_can_exceed_one` checks value two on `[0,2]`. | Calculation and normalization obstruction checked; deliberately not encoded as probability. | Corrected source claim—checked obstruction |
| Printed p. 778, noncommutation/disturbance/disjunction; lines 78–82 | Noncommutation is said to preclude simultaneous precise knowledge and force: incomplete wave-function description or no simultaneous reality. | Matrix noncommutation, common-eigenvector exclusion, and absence of a jointly sharp density state are distinct. The final finite contradiction uses `NoJointSharpState`; the instrument-dependent universal disturbance claim remains unproved. | Pauli no-joint-sharp theorem and a `Fin 3` counterexample to the bare-noncommutation inference are checked. | Strengthened finite correction plus explicit logical alternative |
| Printed p. 779, interaction and reduction setup; line 86 | Schrödinger evolution determines the joint post-interaction wave function, but the paper says neither subsystem state is calculable without a later measurement/reduction. | No time, Hamiltonian, interaction, separation, or preparation dynamics is modeled; a bipartite state is supplied. From a known joint density state, `reducedA` and `reducedB` are calculable unconditioned marginals. Only a selected conditional state needs an outcome and positive branch evidence. | Partial traces and conditioning distinction checked; dynamics is out of scope and the historical subsystem-state claim is corrected. | Corrected source claim plus out-of-scope dynamics |
| Printed p. 779, Eqs. (7)–(8); lines 88–104 | Alternative eigenbasis expansions on I select different coefficient wave functions for II after an outcome. | The project gives a finite density/PVM/Lüders role analogue: raw subnormalized relative branches, positive-probability normalization, and explicit degeneracy. `bellPhiPlus_z_expansion` and `bellPhiPlus_x_expansion` check the concrete two-basis vector identities; no generic infinite eigenbasis expansion theorem is claimed. | Generic finite conditioning and all four Bell branches checked; actuality remains separate. | Checked finite modern analogue |
| Modern finite operational result, not a paper claim | Discarding a complete projective Lüders outcome on A leaves B's unconditioned reduced density and every projective Born statistic unchanged. | Sum raw weighted local branches and prove directional A-to-B marginal equality, distinct from every selected conditional state. | Generic theorem in `EPR.Quantum.NoSignalling`; both Bell settings and selected-state contrasts checked. | Modern addition |
| Printed p. 779, no-interaction/no-real-change sentence; line 106 | Because I and II no longer interact, an operation on I is said to cause no real change in II. | `NoOnticDisturbance s` represents only the claimed ontic consequence as prior/post reality equality. The antecedent that interaction has ceased is not modeled, and neither it nor operational no-signalling proves this premise. | Predicate and operational/ontic non-implication sentinel checked; premise not asserted. | Explicit interpretative premise; antecedent out of scope |
| Printed p. 779, “two different wave functions … same reality”; line 106 | Two alternative conditional wave functions are assigned to the same underlying reality of II. | `SamePriorReality`, with ontic stability in both alternatives, transports them to `SamePostReality`; this is distinct from counterfactual aggregation. | `samePostReality_of_noOnticDisturbance` checked with all equality premises explicit. | Explicit interpretative premise and bridge factoring |
| Printed p. 779, Eq. (9); lines 108–113 | The oscillatory momentum integral is intended as a two-particle object with exact relative-position and opposite-momentum correlations. | For physical `h > 0`, the audited target is `h δ(x₁-x₂+x₀)`, not an `L²(ℝ²)` wave function. `affineLineDelta` pairs tests as `∫f(t,t+x₀)dt`; the scaled correlation satisfies both algebraic equations. | Pairing, scaling definition, `(Q₂-Q₁)Ψ=x₀Ψ`, and `(P₁+P₂)Ψ=0` checked. The raw oscillatory-integral equality and stronger classification remain open. | Tempered-distribution replacement; partly checked |
| Printed pp. 779–780, Eqs. (10)–(13); lines 115–143 | Continuous momentum modes on I select an opposite-momentum coefficient mode on II. | Both ordinary signs are non-`L²`. The `+p` and shifted `-p` operator equations are checked with `h ≠ 0` in tempered distributions. Eq. (11) is distributional, not a Bochner `L²` expansion. | Signs/equations and ordinary-function nonnormalizability checked; generalized-mode nonzeroness, coefficient extraction, and spectral conditioning remain open. | Corrected source claim—partly checked generalized treatment |
| Printed p. 780, Eqs. (14)–(17); lines 143–175 | Dirac position modes yield the selected coefficient `hδ(x-x₂+x₀)` with value `x+x₀` for `Q₂`. | `delta_position_eigenrelation` checks a generic delta multiplier relation, and `affineLineDelta_apply` checks the joint pairing convention. No declaration proves Eq. (15)'s coefficient expansion or Eq. (16)'s translated/scaled integral, coefficient extraction, and eigenvalue as one chain. | Generic delta and affine-line relations checked; Eqs. (15)–(16), support/non-`L²` classification, and continuous selected-state semantics remain open. | Tempered-distribution replacement plus justified unresolved items |
| Printed p. 780, Eq. (18); lines 177–182 | `PQ-QP = h/(2πi)`. | `positionSchwartz` and `momentumSchwartz` act on the common invariant domain `𝒮(ℝ,ℂ)`; `momentum_position_commutator` proves the source sign there. | Checked only on Schwartz space; no bounded-`L²`, closure, self-adjointness, or maximal-domain claim. | Source equation—checked with explicit domain correction |
| Printed p. 780, first final paragraph; line 184 | Either remote choice permits certainty and hence a context-specific reality element; both alternatives concern one reality. | Checked `CertainPrediction` plus supplied actuality, ontic stability, and `RealityCriterion` produce each element; `RealityValueBridge` produces values; `CounterfactualStability` alone aggregates them. | `simultaneous_reality_of_alternative_predictions` checks the complete conditional chain. | Explicit interpretative premises and bridge factoring |
| Printed p. 780, incompleteness paragraph; line 186 | Assuming completeness and simultaneous reality conflicts with the wave-function description. | `CompleteFor` supplies counterparts; `CompletenessRepresentationBridge` supplies joint exact representation; a separate no-joint fact yields the reductio. | Abstract `epr_incompleteness` and finite `bellPhiPlus_epr_incompleteness` checked. | Conditional theorem with strengthened finite quantum input |
| Printed p. 780, objection; line 188 | The paper rejects making simultaneous reality depend on the remote measurement chosen. | The disputed move is `CounterfactualStability`, not a consequence of certainty or same-reality transport. | Independently accepted and rejected in proposition-valued diagnostic models. | Explicitly rejectable interpretative premise |
| Printed p. 780, final paragraph; line 190 | A complete replacement theory might exist. | The conclusion is only `¬ CompleteFor I theory r` for the supplied description and reality. | Abstract and Bell theorem signatures preserve this relative conclusion. | Source limitation—checked literally |

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
mathlib's tempered-distribution infrastructure. The `EPR` umbrella re-exports
it, but it remains deliberately absent from the finite quantum, Bell,
operational no-signalling, and logical dependency chains. Its declarations
divide the source calculations into three types:

1. `planeWave` is an ordinary complex function used only for pointwise norm
   and integration facts. `planeWave_not_memLp_two` and
   `planeWave_not_integrable` rule out normalized real-line state semantics;
   `unnormalizedIntervalWeight_eq` preserves Eq. (6)'s algebra without calling
   it probability.
2. `generalizedPlaneWave`, `eprMomentumMode`, deltas, `affineLineDelta`, and
   `eprCorrelation` are tempered distributions. Their theorems are equality or
   generalized eigen-equations in `𝓢'`, not Hilbert-vector norm or Born-
   probability statements. `generalizedPlaneWave_apply` fixes the positive
   Fourier sign, while the two EPR mode theorems check coefficients `p` and
   `-p` in the corresponding operator equations.
3. `positionSchwartz` and `momentumSchwartz` act on `𝓢(ℝ,ℂ)`.
   `momentum_position_commutator` is therefore a common-domain identity; it
   does not assert an equality of everywhere-defined bounded `L²` operators.

The source audit uses `h > 0`, hence
`∫ exp(2πiyp/h) dp = hδ(y)`. For an arbitrary nonzero real scale, the delta
scaling factor is `|h|`. The checked `affineLineDelta` convention has no hidden
Jacobian because it pairs a test function as `∫ f(t,t+x₀) dt`.

Four groups of obligations remain visible rather than assumed:

- prove the paper's raw oscillatory `p`-integral equals the scaled affine-line
  distribution through an explicit partial-Fourier/change-of-variables
  construction;
- prove nonzeroness, topological support, and non-`L²` representability of the
  affine-line distribution if those stronger classifications are needed beyond
  its checked pairing and multiplier/derivative relations;
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
marginal invariance and ontic no-disturbance. The same umbrella also re-exports
the independent continuum leaf without connecting its generalized objects to
finite conditional or interpretative APIs.

## Stage 10 public surface and trust boundary

The stable umbrella import is `EPR`. `EPR.Audit.PublicAPI` imports only that
module and checks representative declarations from foundations, finite states,
bipartite reduction, conditioning, steering, incompatibility, no-signalling,
the Bell examples, the conditional EPR result, and the continuum leaf. No
public source imports an `EPR.Audit` module; audits remain opt-in diagnostics.

The eight stage-specific axiom leaves print 132 of the 203 theorem declarations
in the 14 public source files. `EPR.Audit.PublicTheoremAxioms` prints the
complementary 71 plus three interface declarations (`Setting`,
`PerfectConditionalPrediction`, and `SteeringScenario`), and
`EPR.Audit.FinalAxioms` aggregates those audits together with the non-axiom API
and concrete-state probes. Every printed result has only the standard
Lean/mathlib trusted footprint, never a project-specific axiom.

`allInterpretiveBridges_satisfiable` gives a proposition-valued positive model,
while the existing diagnostics independently reject actuality, the reality
criterion, the value bridge, counterfactual aggregation, and the completeness
representation bridge. `toy_epr_incompleteness_via_explicit_premises` invokes
`epr_incompleteness` with every premise supplied. These examples establish
logical consistency or rejectability, not physical truth. The unresolved
continuous obligations in the main table—especially Eqs. (5), (9), (15)–(16),
spectral realization, and exact continuous conditioning—remain unresolved.

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
