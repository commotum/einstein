# EPR 1935 Paper Map

This is the living map from *Can Quantum-Mechanical Description of Physical
Reality Be Considered Complete?* to the Lean library. The status column
distinguishes checked declarations from later obligations.

| Paper locus | Source claim or construction | Formal treatment | Current status |
| --- | --- | --- | --- |
| Section 1, completeness condition | Every element of physical reality has a counterpart in a complete theory. | A relative `CompleteFor` predicate plus a separately named theory-counterpart/readout bridge. | Planned for `8-EPR-LOGIC`. |
| Section 1, reality criterion | Certainty of prediction without disturbance is sufficient for an element of reality. | Separate `PerfectlyPredicts`, `NoOnticDisturbance`, and `ElementOfReality` predicates; criterion supplied as a hypothesis. | Planned for `8-EPR-LOGIC`. |
| Eqs. (1)–(6) | Eigenstate reasoning illustrated by a momentum plane wave and a uniform position distribution. | Finite-dimensional sharpness first; continuous example audited separately because the plane wave is not normalized in `L²(ℝ)`. | Finite normalized-state, eigenstate, Born-probability, and sharpness vocabulary completed in `EPR.Quantum.Core`; the plane-wave correction remains a `9-CONTINUUM` obligation. |
| General claim after Eq. (6) | Noncommuting quantities cannot have simultaneous precise values. | Define noncommutation and no-common-sharp-state separately; prove the stronger property for Pauli `X` and `Z`. | Planned for `6-INCOMPATIBILITY`. |
| Eqs. (7)–(8) | Alternative measurements on system I select different relative states of system II. | Represent the selected coefficient by a raw subnormalized relative branch, then normalize only for positive probability. Keep this selective state distinct from the unconditioned marginal and from a full nonselective measurement. | The generic finite Lüders branch, checked normalization, and A→B/B→A conditional marginals are complete in `EPR.Quantum.Conditional`. Concrete alternative Bell/Pauli settings and every branch calculation remain a `5-STEERING` obligation. |
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
they are not presented as measurement rules derived from its text.

## Target finite-dimensional analogue

The first verified example will use a two-qubit Bell state, provisionally
`|Φ⁺⟩`, and Pauli `Z`/`X` measurements. The exact state and sign conventions
remain subject to compile-checked calculations. The finite example replaces
the source's invalid ordinary-Hilbert-vector idealization; it does not purport
to formalize Eqs. (9)–(18) literally.
