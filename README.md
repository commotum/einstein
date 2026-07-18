# EPR Lean Formalization

This repository is a pinned Lean 4/mathlib reconstruction and audit of
Einstein, Podolsky, and Rosen's 1935 completeness argument. It verifies a
finite Bell/Pauli steering model, separates the argument's operational and
interpretative steps, and gives the paper's idealized position--momentum
construction a rigorous generalized-state boundary.

The library does **not** prove unconditionally that quantum mechanics is
incomplete. Its EPR conclusion is conditional on separately supplied
actuality, ontic no-disturbance, reality/value, counterfactual-stability, and
completeness-to-representation premises.

## Checked results

- Finite normalized pure and density states, projective outcomes, Born
  probabilities, bipartite partial traces, selective Lüders branches, and
  positive-probability conditional states.
- All four branches of the two-qubit
  `|Φ⁺⟩ = (|00⟩ + |11⟩)/√2` Pauli-`Z`/Pauli-`X` steering example:
  source probability `1/2`, normalized remote conditional state, target
  probability one, opposite probability zero, and the signed sharp value.
- The stronger Pauli-`X`/Pauli-`Z` no-common-sharp-state obstruction. A checked
  `Fin 3` counterexample shows why bare noncommutation is insufficient in
  general.
- Directional operational no-signalling for complete finite projective Lüders
  measurements on subsystem A, stated as invariance of B's unconditioned
  reduced state and projective statistics. This is not ontic no-disturbance.
- A theory-neutral conditional theorem,
  `EPR.Logic.epr_incompleteness`, and its verified Bell/Pauli specialization,
  `EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness`. Every philosophical
  bridge remains an argument to the theorem.
- A separate tempered-distribution/Schwartz-space treatment of plane-wave
  nonnormalizability, generalized momentum signs, affine position/momentum
  correlations, and the paper's commutator sign on a named common domain.

The continuum leaf does not turn plane waves, deltas, or Eq. (9) into
normalized `L²` states. The raw Eq. (9) oscillatory-integral identity,
affine-distribution nonzeroness/support/non-`L²` classification, concrete
self-adjoint spectral realizations, and continuous conditioning remain
explicit extension obligations.

## Public and diagnostic surfaces

The stable library is available through one umbrella import:

```lean
import EPR

#check EPR.Examples.BellSteering.bellPhiPlusSteeringScenario
#check EPR.Examples.PauliIncompatibility.pauliXZ_noJointSharpState
#check EPR.Quantum.localA_nonselective_noSignalling
#check EPR.Examples.BellEPR.bellPhiPlus_epr_incompleteness
#check EPR.Continuum.momentum_position_commutator
```

`EPR` exports the finite operational branch, the conditional logical branch,
and the independent continuum branch. Exhaustive checks, counterexamples, and
axiom reports live under `EPR.Audit.*` and are deliberately not re-exported.

Premise choice is compile-checked rather than hidden in definitions:

- `EPR.Audit.EPRLogic.allInterpretiveBridges_satisfiable` gives a small
  proposition-valued model in which all four interpretative bridges can be
  supplied; it is not a claim about nature.
- `realityCriterion_rejectable`, `realityValueBridge_rejectable`,
  `counterfactualStability_rejectable`, and
  `completenessRepresentationBridge_rejectable` independently decline them.
- `operational_noSignalling_with_ontic_change` combines the proved Bell
  no-signalling result with denial of ontic no-disturbance in a toy ontology.

Import `EPR.Audit.EPRLogic` explicitly to inspect those diagnostic examples.

## Reproducible build and audit

The project root is `formal/`. Lean is pinned to `v4.31.0`; mathlib is pinned
to commit `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`, with all transitive
dependency revisions recorded in `formal/lake-manifest.json`.

```text
cd formal
lake update
lake exe cache get
lake build -KwarningAsError=true EPR
lake build -KwarningAsError=true EPR.Audit.PublicAPI
lake build -KwarningAsError=true EPR.Audit.FinalAxioms
lake build
```

`EPR.Audit.PublicAPI` imports only `EPR` and checks every major public layer.
`EPR.Audit.FinalAxioms` compiles every stage-specific diagnostic/axiom leaf and
prints the trusted dependencies of the principal results. The abstract logic
theorem is axiom-free; other audited results use at most the standard pinned
Lean/mathlib footprint `propext`, `Classical.choice`, and `Quot.sound`. There
are no project-specific axioms in completed modules.

## Source and design records

- [Authoritative execution plan](goal-1/0-plan.md)
- [Local paper transcription](einstein-1935/einstein-1935.md)
- [Paper-to-Lean map](docs/PaperMap.md)
- [Corrections and idealizations](docs/Corrections.md)
- [Pinned representations and dependency graph](docs/Dependencies.md)
