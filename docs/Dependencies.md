# Representation and Dependency Decisions

## Pinned toolchain

- Lean: `leanprover/lean4:v4.31.0`
- mathlib revision: `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`
  (the `v4.31.0` mathlib tag)
- Project root: `formal/`

The exact mathlib commit is in `formal/lakefile.toml`; transitive dependency
commits are recorded by `formal/lake-manifest.json` after `lake update`.

## Stage 1 checked surface

`EPR.Audit.ApiProbe` compile-checks the following mathlib facilities:

- complex basis-indexed vectors and matrices;
- `Matrix.IsHermitian` and `Matrix.PosSemidef`;
- matrix trace;
- matrix Kronecker product, its multiplication law, trace law, and conjugate
  transpose law;
- positive semidefiniteness of rank-one outer products;
- algebraic tensor products and mapped linear transformations.

A source search of mathlib at the pinned revision found no project-ready
definitions named for density matrices, quantum states/measurements, POVMs,
Kraus maps, or partial trace. Absence is a search result, not a mathematical
theorem; later stages must recheck before adding infrastructure.

## Stage 2 checked core

`EPR.Quantum.Core` now provides project-owned, invariant-carrying structures
for normalized pure states, positive trace-one density states, Hermitian
observables, orthogonal projections, and nonzero spectral outcomes.  It also
provides Born weights/probabilities, projector support, pure eigenstates,
density-state sharp values, and joint sharpness.

The following facts are compile-checked rather than postulated:

- normalized pure states and trace-one density states have nonzero data;
- a normalized pure state produces a positive trace-one rank-one density
  state;
- Born weights of orthogonal projections in density states are real;
- projector support implies outcome probability one;
- a pure eigenstate produces a sharp rank-one density state;
- support in a spectral outcome produces the corresponding sharp value; and
- a density state cannot have two distinct sharp values for one observable.

`EPR.Audit.QuantumCore` checks these declarations on two distinct qubit basis
states and a full-space identity outcome.  Because both states lie in the same
outcome projector, this also checks that the API does not assume rank-one or
nondegenerate outcomes. `EPR.Audit.QuantumCoreAxioms` records that the main
Stage 2 declarations depend only on `propext`, `Classical.choice`, and
`Quot.sound`, the standard Lean/mathlib footprint.

The core proves the probability-one case needed for sharpness. General
projective Born-probability bounds are not silently built into that definition;
the Stage 4 measurement layer now derives them from positivity and projection
complementation.

## Stage 3 checked bipartite layer

`EPR.Quantum.Bipartite` uses the ordered product index `A × B` and provides:

- `BipartitePureState` and `BipartiteState` aliases over the invariant-bearing
  Stage 2 state structures;
- `tensorKet`, normalized `PureState.tensor`, positive trace-one
  `DensityState.tensor`, and compatibility of tensoring with pure-to-density
  conversion;
- separately tagged `LocalOperatorA/B`, `LocalObservableA/B`, and
  `LocalProjectionA/B` types with explicit lifts and no coercion between
  subsystem tags;
- algebraic same-side multiplication, opposite-side multiplication and
  commutation, and factorwise action on tensor-product kets;
- `traceOutA` and `traceOutB`, named for the factor removed, together with
  complex-linear-map versions `traceOutALinear` and `traceOutBLinear`; and
- normalized `reducedA` and `reducedB` density states.

The project-owned partial traces are finite sums of principal submatrices. The
proof that they preserve positivity uses pinned mathlib's
`Matrix.PosSemidef.submatrix` and `Matrix.posSemidef_sum`; trace preservation
is proved separately by rearranging finite sums. Kronecker-product positivity
uses the existing `Matrix.PosSemidef.kronecker` theorem from
`Mathlib.Analysis.Matrix.Order`, exposed transitively by the core's pinned
imports. Product formulas prove
`traceOutA (A ⊗ₖ B) = trace A • B` and
`traceOutB (A ⊗ₖ B) = trace B • A`, from which both product-state marginal
identities follow.

`EPR.Audit.Bipartite` uses a heterogeneous `Fin 2 × Fin 3` system to test
subsystem order, including an off-diagonal matrix unit whose two partial
traces differ, two independent local actions, and the dimension factor in the
partial trace of identity. It also constructs a normalized rational-amplitude
two-qubit state, proves that no pair of raw kets tensor to it, and checks both
reduced matrices. The example is deliberately not the later Bell steering
scenario.

Local operators here are arbitrary algebraic matrices. Their lifts are not
claimed to be normalized state transformations, trace-preserving channels,
operational no-signalling maps, or evidence of ontic no-disturbance. Reduced
states are unconditioned marginals, not selected conditional states.

## Stage 4 checked conditional layer

`EPR.Quantum.Conditional` uses the density-first projective Lüders rule. For a
density state `ρ` and an orthogonal projection `P`, the raw selected branch is
`PρP`. This is a finite measurement-model choice, especially for a degenerate
projection; it is not attributed to the 1935 paper as its unique measurement
formalism.

The checked surface provides:

- `SubnormalizedState`, carrying positive semidefiniteness and real trace at
  most one while permitting the zero operator;
- a real trace weight, its nonnegativity and zero-matrix characterization, and
  normalization only from a proof that the weight is strictly positive;
- `ludersBranchMatrix` and `ludersBranch`, with sandwich positivity, trace/Born
  equality, outcome probabilities in `[0, 1]`, and zero/positive branch
  characterizations;
- `conditionalState`, whose signature requires positive outcome probability,
  together with its matrix, selected support, and repeat-probability-one laws;
- finite `ProjectiveMeasurement`s with nonzero projections, pairwise
  orthogonality, identity resolution, normalized outcome probabilities, and a
  positive trace-one `nonselectiveState` formed from the sum of all raw
  branches;
- projected pure kets and a normalized pure conditional state, with proofs
  that pure and density branch descriptions agree and density-level
  conditioning is invariant under global phase; and
- separately typed A→B and B→A local selected joint states, subnormalized
  remote relative branches, and normalized conditional marginals. Normalizing
  the remote branch agrees with reducing the normalized selected joint state.

Three operations are deliberately not identified:

1. `conditionalState`/`localAConditionalBState` select and normalize one
   positive-probability branch;
2. `ProjectiveMeasurement.nonselectiveState` sums every raw branch; and
3. `reducedA`/`reducedB` discard a subsystem from the unconditioned input.

`EPR.Audit.Conditional` checks a proper rank-two `Fin 3` projection and its
complement, a nonzero zero-probability outcome, normalization of both positive
branches, nonselective dephasing, preservation of coherence within the
degenerate range, global-phase invariance, and a nonmaximally correlated
bipartite conditional state distinct from its original marginal. It does not
define Stage 5's Bell/Pauli steering scenario. `EPR.Audit.ConditionalAxioms`
records only `propext`, `Classical.choice`, and `Quot.sound` for the selected
generic declarations and concrete checks.

## Stage 5 finite steering layer

`EPR.Quantum.Steering` adds two reusable operational structures over the
checked conditioning API:

- `PerfectConditionalPrediction` contains strict positivity of the selected
  A-side branch and target-projector probability one in the normalized
  conditional B state. Positivity is part of the structure, so an impossible
  zero-probability branch cannot satisfy the declaration vacuously.
- `SteeringScenario` records a bipartite density state, source and target
  observable tags, a complete source PVM, checked spectral outcomes, an
  explicit response map supporting correlation or anticorrelation conventions,
  and a perfect conditional prediction for every setting and source outcome.

`EPR.Examples.BellSteering` instantiates that layer with the ordered two-qubit
state `|Φ⁺⟩ = (|00⟩ + |11⟩)/√2`. Its fixed conventions are outcome label
`0 ↦ +1`, label `1 ↦ -1`, computational `Z` eigenstates `|0⟩` and `|1⟩`, and
`X` eigenstates `|+⟩` and `|-⟩`. The example provides:

- exact real and complex `√2/2` identities and a checked normalized Bell ket;
- checked Pauli observables, eigenstates, rank-one spectral outcomes, and
  complete binary projective measurements;
- exact computational- and X-basis expansions and a proof that the Bell ket
  has no raw tensor factorization;
- a uniform probability theorem giving `1/2` for both settings and both
  outcomes;
- raw relative B branches equal to `(1/2)` times the matching pure-state
  density, with trace weight `1/2` before normalization;
- normalized matching conditional B states, target probability one,
  opposite-outcome probability zero, and matching signed Pauli sharp values;
  and
- `bellPhiPlusSteeringScenario`, whose identity response packages the two
  same-label Pauli correlations across all four possible branches.

`EPR.Audit.BellSteering` expands the quantified results into an explicit
four-case table and checks the basis/value conventions, both Bell expansions,
raw branch weights and matrices, normalized conditionals, matching and
opposite probabilities, signed sharp values, X-minus off-diagonal signs, and
an A-lift coordinate sentinel that detects a tensor-factor swap despite the
Bell state's symmetry. `EPR.Audit.BellSteeringAxioms` is a separate diagnostic
leaf that reviews the generic and concrete signatures and prints the axioms of
the principal declarations. Neither Stage 5 audit is imported by the public
`EPR` root; `EPR.Examples.BellSteering` is re-exported through the later public
`EPR.Examples.PauliIncompatibility` and `EPR.Examples.BellNoSignalling` layers.

These are selected-branch mathematical facts. They assert no actual outcome,
common sharp state, noncommutation result, unconditioned marginal invariance,
operational no-signalling, ontic disturbance or locality, element of reality,
counterfactual aggregation, completeness, or incompleteness. They are also not
a discretization or normalized realization of the distributional state in
Eq. (9).

## Stage 6 checked incompatibility layer

`EPR.Quantum.Incompatibility` imports only the finite quantum core and defines
the generic mathematical distinctions needed by the final quantum exclusion:

- `Observable.Commutes` and `Observable.Noncommutes` concern matrix
  multiplication only;
- `Observable.IsEigenvector`, `Observable.HasCommonEigenvector`, and
  `Observable.NoCommonEigenvector` explicitly require a nonzero raw common
  eigenvector where appropriate;
- `Observable.HasJointSharpState` and `Observable.NoJointSharpState` quantify
  over normalized density states, including mixed states; and
- `Observable.hasCommonEigenvector_of_jointlySharp` extracts a common nonzero
  eigenvector from a nonzero column of a particular trace-one jointly sharp
  density matrix, while
  `Observable.not_jointlySharp_of_noCommonEigenvector` gives the pointwise
  exclusion for an arbitrary density state. The existential wrappers are
  `Observable.hasCommonEigenvector_of_hasJointSharpState` and
  `Observable.noJointSharpState_of_noCommonEigenvector`.

`EPR.Examples.PauliIncompatibility` reuses the exact Pauli observables from the
Bell example and proves the three concrete facts separately:

- `pauliXZ_noncommutes` checks matrix-product inequality;
- `pauliXZ_commonEigenvector_eq_zero` handles arbitrary raw qubit kets and
  arbitrary real candidate eigenvalues, from which
  `pauliXZ_noCommonEigenvector` follows; and
- `pauliXZ_noJointSharpState` excludes every pure or mixed density state by
  the generic column bridge, while `pauliXZ_not_jointlySharp` exposes the
  state-quantified form used by later logic.

`EPR.Audit.Incompatibility` checks the Pauli product order and arbitrary-state
exclusion, then constructs explicit Hermitian observables `fin3A` and `fin3B`.
They do not commute, yet `fin3SharedState` is a common normalized eigenstate
and its density is jointly sharp for both. The combined theorem
`fin3_noncommuting_with_common_sharp_state` prevents the public API or later
proofs from substituting bare noncommutation for the stronger state-space
obstruction. The public `EPR` root imports
`EPR.Examples.PauliIncompatibility`; both `EPR.Audit.Incompatibility` and
`EPR.Audit.IncompatibilityAxioms` remain outside the public import chain.

This layer proves no measurement-disturbance, marginal-invariance,
no-signalling, locality, physical-reality, simultaneous-reality,
counterfactual, completeness, or incompleteness claim. Its finite Pauli
product calculation is not a formalization of the unbounded position-momentum
commutator in Eq. (18).

## Stage 7 checked operational no-signalling layer

`EPR.Quantum.NoSignalling` imports only `EPR.Quantum.Conditional`. Its scope is
a finite complete projective measurement on A with the outcome discarded:

- `ProjectiveMeasurement.localAProjection` tags each source projector on A,
  and `ProjectiveMeasurement.sum_localAProjection_lift` proves that the lifted
  projectors resolve the identity on `A × B`;
- `localANonselectiveState` sums the raw Lüders branches
  `(P_w ⊗ I) ρ (P_w ⊗ I)`. Their traces already contain the outcome weights,
  so this is not an unweighted sum of normalized conditional states;
- `OperationalNoSignallingAtoB ρ M` is the directional equality
  `reducedB (localANonselectiveState ρ M) = reducedB ρ`; and
- `localA_nonselective_noSignalling` proves that equality for every input state
  and complete source PVM. `localA_nonselective_outcomeProbability` derives
  invariance of an arbitrary projective Born statistic on B, while
  `localA_nonselective_reducedB_independent` and
  `localA_nonselective_outcomeProbability_independent` compare any two source
  measurement choices.

`EPR.Examples.BellNoSignalling` imports the generic no-signalling module and
the checked Bell steering example without making either layer depend on the
other's diagnostics. It provides:

- `bellPhiPlusAfterLocalMeasurement`, the joint Bell state after an A-side
  Pauli measurement with its outcome discarded;
- `bellPhiPlus_operationalNoSignalling` and
  `bellPhiPlus_reducedB_invariant` for either source setting;
- `bellPhiPlus_sourceSetting_independent`,
  `bellPhiPlus_targetStatistic_invariant`, and
  `bellPhiPlus_targetStatistic_sourceSetting_independent` for direct
  source-choice comparisons; and
- `bellPhiPlus_selected_z_outcomes_differ`,
  `bellPhiPlus_selected_settings_differ`, and
  `bellPhiPlus_selected_changes_with_noSignalling`, which check that selected
  conditional B states can differ even though both outcome-forgotten settings
  satisfy the operational theorem.

`EPR.Audit.NoSignalling` checks that the Z nonselective joint state differs
from the input while its B marginal remains the same maximally mixed state,
checks the same B marginal after the X setting, distinguishes a selected state
from that unconditioned marginal, and uses `Fin 2 × Fin 3` to sentinel the
A-to-B direction. `EPR.Audit.NoSignallingAxioms` checks the full signature and
axiom surface. Neither audit leaf is imported by the public `EPR` root. The
root directly imports the two public example branches
`EPR.Examples.PauliIncompatibility` and
`EPR.Examples.BellNoSignalling`.

This is a directional A-to-B result for complete projective Lüders
measurements, not a theorem about arbitrary channels, communication protocols,
spacetime separation, absence of interaction, or ontic locality. It does not
assert an actual outcome and does not turn a selected conditional state into an
unconditioned marginal. The paper's page-779 claim that absence of interaction
means no real change in system II remains an explicit Stage 8 premise, not a
consequence of `OperationalNoSignallingAtoB`.

## Checked representation choice

- Use generic finite basis index types `ι`, `κ` with `[Fintype]` and
  `[DecidableEq]` only where operations require them.
- Represent raw kets as `ι → ℂ` and raw operators as `Matrix ι ι ℂ`.
- Represent bipartite basis indices as the ordered product `ι × κ` and local
  operator products with `Matrix.kronecker`.
- Introduce normalized pure states and positive trace-one density states as
  distinct invariant-carrying structures in Stage 2.
- Use the Stage 3 finite partial traces, implemented as principal-block sums
  with proved positivity, trace preservation, and product laws.
- Use projective measurements for the finite core. General POVMs/instruments are optional
  extensions unless later proof obligations require them.
- Use checked subnormalized selective branches and normalize only with explicit
  strictly positive outcome-probability evidence.
- Form a local nonselective projective update by summing every raw weighted
  branch; never sum normalized selected conditional states without their Born
  weights.
- State finite operational no-signalling directionally as equality of the
  unconditioned remote reduced state, then derive projective-statistic and
  source-setting independence as corollaries.
- Package conditional certainty with strict source-branch positivity and keep
  each correlation/anticorrelation convention in an explicit response map.
- Keep matrix noncommutation, common-eigenvector exclusion, and joint-sharp
  density-state exclusion as separate notions; use the last one in the later
  completeness bridge.

This basis-level choice is intentional for the finite core. It keeps Bell-state
calculations executable and aligns subsystem order with matrix Kronecker
indices. Abstract Hilbert tensor products remain available for later bridges,
but are not required for the first verified example.

## Current and planned module layering

```text
EPR.Foundations
  -> EPR.Quantum.Core
       -> EPR.Quantum.Bipartite
            -> EPR.Quantum.Conditional
                 -> EPR.Quantum.Steering
                      -> EPR.Examples.BellSteering

EPR.Quantum.Core
  -> EPR.Quantum.Incompatibility

EPR.Quantum.Incompatibility + EPR.Examples.BellSteering
  -> EPR.Examples.PauliIncompatibility

EPR.Quantum.Conditional
  -> EPR.Quantum.NoSignalling

EPR.Quantum.NoSignalling + EPR.Examples.BellSteering
  -> EPR.Examples.BellNoSignalling

EPR.Examples.PauliIncompatibility + EPR.Examples.BellNoSignalling
  -> EPR (public root)

EPR.Interpretation.Core
  -> EPR.Logic.Incompleteness

verified quantum example + interpretative hypotheses
  -> EPR.Theorems.EPR

EPR.Continuum.* and EPR.Audit.* remain diagnostic leaves.
```

Interpretative modules should depend only on lightweight logical vocabulary.
They must not import operational no-signalling as though it established ontic
locality.
