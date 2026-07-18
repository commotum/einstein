# EPR 1935 Paper Map

This is the living map from *Can Quantum-Mechanical Description of Physical
Reality Be Considered Complete?* to the Lean library. The status column
distinguishes checked declarations from later obligations.

| Paper locus | Source claim or construction | Formal treatment | Current status |
| --- | --- | --- | --- |
| Section 1, completeness condition | Every element of physical reality has a counterpart in a complete theory. | A relative `CompleteFor` predicate plus a separately named theory-counterpart/readout bridge. | Planned for `8-EPR-LOGIC`. |
| Section 1, reality criterion | Certainty of prediction without disturbance is sufficient for an element of reality. | Separate `PerfectlyPredicts`, `NoOnticDisturbance`, and `ElementOfReality` predicates; criterion supplied as a hypothesis. | Planned for `8-EPR-LOGIC`. |
| Eqs. (1)–(6) | Eigenstate reasoning illustrated by a momentum plane wave and a uniform position distribution. | Finite-dimensional sharpness first; continuous example audited separately because the plane wave is not normalized in `L²(ℝ)`. | Finite normalized-state, eigenstate, Born-probability, and sharpness vocabulary completed in `EPR.Quantum.Core`; the plane-wave correction remains a `9-CONTINUUM` obligation. |
| General claim after Eq. (6) | Noncommuting quantities cannot have simultaneous precise values. | Separate matrix noncommutation, existence of a common nonzero eigenvector, and existence of a jointly sharp density state. Use the last property for the quantum-state exclusion, not bare noncommutation. | `EPR.Quantum.Incompatibility` provides the generic distinctions and mixed-state bridge; `EPR.Examples.PauliIncompatibility` proves all three Pauli `X`/`Z` results. `EPR.Audit.Incompatibility` checks a noncommuting Hermitian `Fin 3` pair that nevertheless has a common eigenvector and jointly sharp state. |
| Eqs. (7)–(8) | Alternative measurements on system I select different relative states of system II. | Represent the selected coefficient by a raw subnormalized relative branch, then normalize only for positive probability. Keep this selective state distinct from the unconditioned marginal and from a full nonselective measurement. | The generic finite conditioning API is complete in `EPR.Quantum.Conditional`; `EPR.Quantum.Steering` packages nonvacuous conditional certainty, and `EPR.Examples.BellSteering` checks both Pauli settings and all four `bellPhiPlus` branches. |
| Modern finite operational result, not a separate paper claim | Discarding the outcome of a complete projective Lüders measurement on A leaves B's unconditioned reduced density and every projective Born statistic unchanged. | Sum the raw weighted local branches, prove directional A-to-B reduced-state equality, and keep this outcome-forgotten state distinct from every selected conditional state. | `EPR.Quantum.NoSignalling` proves the generic finite result; `EPR.Examples.BellNoSignalling` checks both Bell/Pauli source settings and their selected-state contrast. |
| Paragraph after Eq. (8) | No real change occurs in II after an operation on separated I. | Explicit ontic premise, not a mathematical consequence of absent interaction or no-signalling. | Planned for `8-EPR-LOGIC`. |
| “two different wave functions … same reality” | Different conditional wave functions may describe the same underlying reality of II. | Explicit context/world indexing and counterfactual-stability bridge. | Planned for `8-EPR-LOGIC`. |
| Eqs. (9)–(18) | Ideal perfect position/momentum correlations using plane waves and deltas. | Distributional/rigged-Hilbert-space treatment or normalized approximants, never ordinary normalized vectors. | Audited extension in `9-CONTINUUM`. |
| Final argument | Alternative perfect predictions establish simultaneous reality; completeness then conflicts with quantum mechanics. | Conditional theorem consuming verified steering and incompatibility facts plus named philosophical premises. | Planned for `8-EPR-LOGIC`. |
| Final sentence | A complete replacement theory might exist. | Historical/interpretative statement only; no existence theorem without a construction. | Documentation only. |

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
B. The two independence theorems compare any two complete source
measurements.

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
paper's page-779 inference from no interaction to “no real change” remains an
explicit Stage 8 premise.

This construction is a normalized finite role analogue of the alternative-
expansion and conditional-certainty steps. It neither digitizes nor
approximates Eq. (9), does not identify Pauli `X` or `Z` with the paper's
position or momentum operators, and does not reproduce the `-p` momentum
relation, the `x + x₀` position offset, or the unbounded-operator commutator in
Eq. (18). Those analytic claims remain Stage 9 obligations. Stage 7 checks
only the finite operational result above; locality, same-reality,
counterfactual, and completeness claims remain Stage 8.
