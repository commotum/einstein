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

The current core proves the probability-one case needed for sharpness.  A
general theorem that every projective Born probability lies in `[0, 1]` is not
silently built into the definition and remains available as a later API
strengthening when the measurement layer needs it.

## Provisional representation choice

- Use generic finite basis index types `ι`, `κ` with `[Fintype]` and
  `[DecidableEq]` only where operations require them.
- Represent raw kets as `ι → ℂ` and raw operators as `Matrix ι ι ℂ`.
- Represent bipartite basis indices as the ordered product `ι × κ` and local
  operator products with `Matrix.kronecker`.
- Introduce normalized pure states and positive trace-one density states as
  distinct invariant-carrying structures in Stage 2.
- Define finite partial trace explicitly as an indexed finite sum in Stage 3,
  then prove its normalization and product laws.
- Begin with projective measurements. General POVMs/instruments are optional
  extensions unless later proof obligations require them.
- Use subnormalized selective branches internally; normalize only with explicit
  nonzero outcome-probability evidence.

This basis-level choice is intentional for the finite core. It keeps Bell-state
calculations executable and aligns subsystem order with matrix Kronecker
indices. Abstract Hilbert tensor products remain available for later bridges,
but are not required for the first verified example.

## Planned module layering

```text
EPR.Foundations
  -> EPR.Quantum.Core
  -> EPR.Quantum.Bipartite
  -> EPR.Quantum.Conditional
  -> EPR.Examples.BellSteering
  -> EPR.Quantum.Incompatibility
  -> EPR.Quantum.NoSignalling

EPR.Interpretation.Core
  -> EPR.Logic.Incompleteness

verified quantum example + interpretative hypotheses
  -> EPR.Theorems.EPR

EPR.Continuum.* and EPR.Audit.* remain diagnostic leaves.
```

Interpretative modules should depend only on lightweight logical vocabulary.
They must not import operational no-signalling as though it established ontic
locality.
