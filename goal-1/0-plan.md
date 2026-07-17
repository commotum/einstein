# EPR Lean Library — `EPR-FORMAL`

## Status

- Scaffold created on 2026-07-17.
- Stage `1-FOUNDATIONS` completed on 2026-07-17; its evidence is recorded in
  `goal-1/1-FOUNDATIONS.md`.
- Stage `2-QUANTUM-CORE` is the first incomplete stage and has not started.
- A pinned minimal Lean project and representation probes now exist. No
  substantive quantum definition, philosophical premise, or target proof has
  been implemented yet.
- The local primary source is
  `einstein-1935/einstein-1935.md`, transcribed from the accompanying PDF.

## Big-Picture Objective

Build a correct, reusable Lean 4 library that reconstructs the mathematical
and logical argument of Einstein, Podolsky, and Rosen's 1935 paper, *Can
Quantum-Mechanical Description of Physical Reality Be Considered Complete?*
The library must verify the quantum-mechanical calculations it formalizes and
must expose every philosophical or locality premise as an explicit definition,
structure field, or theorem hypothesis.

The first constructive target is a finite-dimensional bipartite steering
example, provisionally a two-qubit Bell state with Pauli `X` and `Z`. The EPR
reality and completeness criteria will be represented abstractly, and the
incompleteness conclusion will be a conditional theorem. The paper's original
position-momentum construction is a later analytic or distributional extension,
not an ordinary Hilbert-space-vector example.

## Non-Negotiable Constraints and No-Cheating Rules

- Keep mathematical facts, operational claims, and interpretative premises in
  visibly separate namespaces/modules and theorem hypotheses.
- Never promote the reality criterion, completeness criterion, locality, or
  counterfactual reasoning to an unconditional fact about nature.
- Prefer predicates, structures carrying assumptions, and implications over
  project-specific Lean `axiom` declarations.
- Do not infer ontic no-disturbance from operational no-signalling.
- Do not conflate probability-one prediction, an actual measurement outcome,
  a possessed value, and an element of reality.
- Do not infer simultaneous reality merely by conjoining two statements made
  in incompatible experimental contexts; name and assume the required
  context-independence or counterfactual-stability bridge.
- Do not use bare operator noncommutativity as a universal substitute for “no
  common sharp state.” Noncommuting operators can share an eigenvector in
  dimensions greater than two. Prove the needed stronger property for the
  chosen observables.
- Do not treat plane waves, Dirac delta functions, or the state in Eq. (9) as
  normalized vectors in `L²`.
- State normalization, nonzero outcome probability, degeneracy, phase, and
  operator-domain conditions wherever they matter.
- Pin Lean and mathlib versions before substantive code; record exact versions
  and build commands.
- Completed modules must compile without `sorry`, `admit`, or unexplained
  project-specific axioms. Experimental obstruction files must not leak into
  the public API.
- Do not weaken the goal to a propositional toy detached from the verified
  bipartite example, or to a quantum example detached from the explicit EPR
  logic.
- Do not claim that the formalization proves quantum mechanics is incomplete
  unconditionally. It proves a conditional implication from stated premises.
- Keep unresolved issues and corrections visible rather than fabricating a
  proof or silently changing a claim.

## Current Facts

### Repository facts

- The repository currently contains the paper as Markdown and PDF, a generic
  Lean build plan, Python project metadata, the Stage 1 source audit, and a
  Lean project rooted at `formal/`.
- Lean is pinned to `v4.31.0`; mathlib is pinned to commit
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f` (tag `v4.31.0`). The generated
  manifest pins every transitive dependency.
- `EPR.Foundations` exposes only raw basis-indexed complex ket and operator
  aliases. It does not claim normalization, positivity, measurement semantics,
  locality, or physical reality.
- `EPR.Audit.ApiProbe` compile-checks Hermitian matrices, complex positive
  semidefiniteness, trace, Kronecker identities, rank-one positivity through
  the `RCLike` API, and algebraic tensor products.
- A pinned-source declaration search found no ready-made density-matrix,
  quantum-measurement, POVM/Kraus, or partial-trace abstraction. Later stages
  must provide narrow project-owned definitions and recheck before doing so.
- Generated `.lake/` caches and dependency checkouts are ignored; the
  toolchain, Lake configuration, and manifest are the reproducible sources.

### Paper map and preliminary audit

| Paper locus | Claim or construction | Formal status and correction target |
| --- | --- | --- |
| Sec. 1, completeness condition | Every element of physical reality has a counterpart in a complete theory. | Interpretative criterion. Define a relative `CompleteFor` predicate. The extra bridge from “counterpart” to a theory state making the value available or sharp must not be smuggled in. |
| Sec. 1, reality criterion | Certainty of prediction without disturbance is sufficient for an element of reality. | Explicit premise, not a theorem of quantum mechanics. Split certainty, disturbance, and reality into separate predicates. |
| Eqs. (1)–(5) | Eigenstate-eigenvalue reasoning for momentum and position. | Plane wave in Eq. (2) is not normalized in `L²(ℝ)`. Preserve only as a generalized-state calculation or replace with finite-dimensional sharpness. |
| Eq. (6) | A plane wave gives a uniform position “probability.” | As written, the state is unnormalizable and the displayed quantity is not a normalized probability distribution on `ℝ`. Record as an idealized relative density, not an ordinary Born probability. |
| Sec. 1 after Eq. (6) | Noncommuting observables cannot both be precisely known. | Too broad for arbitrary finite-dimensional operators: noncommuting operators may share some eigenvectors. Use a pair with no common sharp state, or state the precise hypotheses under which the conclusion holds. |
| Eqs. (7)–(8) | A bipartite state has different expansions; a selected outcome leaves system II in a conditional state. | Finite-dimensional version is clean. Account for basis choice, normalization, outcome probability, degeneracy, and selective versus nonselective measurement. |
| Sec. 2 after Eq. (8) | Operations on I cause no real change in II once interaction ends. | Strong locality/ontic no-disturbance premise. It is not merely absence of a Hamiltonian interaction and is not implied by operational no-signalling. |
| “two different wave functions … same reality” | Alternative measurements on I steer II to different relative states while II's underlying reality is fixed. | Requires a framework relating operational conditional states, measurement choice, outcomes, and an underlying reality/ontic state. Treat as a conditional interpretative bridge. |
| Eqs. (9)–(18) | Perfect position/momentum correlations and noncommutation. | Eq. (9) is distributional (proportional to a delta constraint), not a normalizable bipartite `L²` vector; plane waves and deltas are generalized eigenvectors. A rigorous version needs a rigged Hilbert space, distributions/spectral measures, or normalized approximants plus limit/error bounds. |
| Final paragraphs | Alternative local choices imply simultaneous reality of `P` and `Q`; completeness conflicts with the quantum description. | Requires counterfactual aggregation/context-independence in addition to the reality and locality criteria. Formal conclusion must list all premises. The paper leaves existence of a complete replacement theory open. |

### Preliminary calculation checks

- With `ℏ = h/(2π)`, the paper's momentum operator
  `h/(2π i) ∂/∂x` is `-iℏ ∂/∂x`.
- Eq. (12) is a generalized momentum eigenfunction of particle II with
  eigenvalue `-p`, as the paper states.
- For `P = -iℏ ∂/∂x₂` and `Q` multiplication by `x₂`, the convention in the
  paper gives `[P,Q] = -iℏ = h/(2π i)`, matching Eq. (18), on a suitable common
  operator domain.
- Eq. (9) is formally proportional to
  `h δ(x₁ - x₂ + x₀)` under the paper's Fourier convention. This supports the
  intended perfect relative-position correlation but also confirms that the
  state is distributional and non-normalizable.
- These checks are documentary observations only; none has yet been encoded or
  verified in Lean.

## Explicit Assumption and Argument Outline

The formal argument must be parameterized by enough context to prevent silent
modal or counterfactual steps. Tentative ingredients are:

1. **Quantum scenario.** A bipartite preparation, two alternative local
   measurements on subsystem A, two observables `P` and `Q` on subsystem B,
   and outcome-conditioned states.
2. **Perfect prediction.** In each relevant branch, an outcome on A determines
   a value for the corresponding B observable with probability one. This is a
   mathematical/operational fact to prove for the finite example.
3. **Spacelike or post-interaction separation.** A relation specifying when
   the systems are considered separated. Separation alone must not definitionally
   imply ontic locality.
4. **No-disturbance/locality premise.** The chosen action on A does not change
   the relevant physical reality of B. This is an explicit interpretative
   hypothesis.
5. **Reality criterion.** Perfect predictability together with no disturbance
   suffices for an `ElementOfReality` for the predicted quantity and value.
6. **Counterfactual stability/aggregation.** Reality assignments inferred in
   alternative A-measurement contexts apply to the same B reality and can be
   combined as simultaneous reality. This premise carries a major part of the
   philosophical argument and must be named.
7. **Completeness criterion.** Every such element of reality has an adequate
   counterpart in the theory.
8. **Representation/readout bridge.** If the quantum state description is
   complete for that reality, simultaneous real definite values must be
   representable as simultaneous sharp values (or otherwise encoded by the
   theory in a precisely stated way). This does not follow from the bare word
   “counterpart” without a definition.
9. **Quantum exclusion.** The selected `P` and `Q` admit no common sharp state
   in the relevant quantum state space. For Pauli `X` and `Z`, prove this
   directly; do not rely on noncommutativity alone.
10. **Conditional conclusion.** Given 1–9, the quantum state description is
    not complete for the modeled reality. Logically, the formal result exposes
    which conjunction of premises is inconsistent; it does not establish the
    philosophical premises independently.

Operational no-signalling will be separately defined and proved for the
finite-dimensional quantum model as invariance of B's unconditioned marginal
under a trace-preserving local operation on A. It will neither imply nor be
identified with item 4.

## Tentative Formalization Direction

### Finite-dimensional core

- Start with a two-qubit Bell state such as `|Φ⁺⟩`.
- Measuring Pauli `Z` on A permits a probability-one prediction of Pauli `Z`
  on B; measuring Pauli `X` on A permits a probability-one prediction of Pauli
  `X` on B, with correlations/signs fixed by the selected Bell state.
- Define selective conditional/relative states and distinguish them from the
  unconditioned reduced state.
- Prove that Pauli `X` and `Z` have no common nonzero eigenvector/common sharp
  density state and separately prove that they do not commute.
- Instantiate an abstract EPR scenario with the verified steering results, then
  prove only a conditional incompleteness theorem under named philosophical
  premises.

### Candidate declarations (names provisional)

- Mathematical layer: `BipartiteState`, `LocalObservable`,
  `OutcomeProbability`, `ConditionalState`, `PerfectlyPredicts`,
  `SharpValue`, `JointlySharp`, `OperationalNoSignalling`.
- Interpretative layer: `PhysicalSituation`, `ElementOfReality`,
  `NoOnticDisturbance`, `SimultaneouslyReal`, `TheoryCounterpart`,
  `CompleteFor`, `RealityCriterion`, `CounterfactualStability`.
- Example/results layer: `bellPhiPlus`, `bell_z_perfectPrediction`,
  `bell_x_perfectPrediction`, `pauliXZ_not_commute`,
  `pauliXZ_not_jointlySharp`, `local_measurement_noSignalling`.
- Logic layer: `reality_of_perfect_prediction`,
  `simultaneous_reality_of_alternative_predictions`,
  `not_complete_of_no_joint_sharp_representation`, and a top-level
  `epr_incompleteness` theorem whose hypotheses reveal the full dependency.

Exact names and representations must follow the available mathlib APIs found
in Stage 1 rather than forcing this sketch onto unsuitable infrastructure.

### Proposed dependency direction

```text
finite linear algebra / quantum states
                 |
        bipartite + measurement
          /              \
conditional states     no-signalling
         |
Bell steering + Pauli incompatibility
         |
abstract reality/locality/completeness interfaces
         |
conditional EPR logic theorem
         |
traceability, correction log, axiom audit

continuous-variable audit/extension (separate leaf; never a dependency of core)
```

The interpretative interfaces may be algebraically lightweight and should not
import heavy analytic modules. The final bridge module may import both the
verified example and the abstract logic.

## Dependency Notes and Open Design Choices

- **Mathlib API availability:** inspect current support for complex inner
  product spaces, tensor products, finite matrices, positive operators,
  density matrices, partial trace, spectral projectors, and quantum
  measurement. Do not assume a polished quantum-information API exists.
- **Representation choice:** matrices on `Fin n`, linear maps on finite
  Hilbert spaces, or an existing density-operator API. Favor the smallest
  representation that supports reusable conditional states and partial trace
  without excessive coercion or fragile basis dependence.
- **State representation:** pure vectors simplify the Bell steering proof;
  density matrices simplify selective/nonselective measurement and
  no-signalling. A layered API may use both with an explicit conversion.
- **Tensor products:** choose between abstract Hilbert tensor products and a
  finite basis-level equivalence. The latter may reduce analytic overhead but
  should not hide subsystem structure.
- **Measurement semantics:** projective measurements are sufficient for the
  first example. General instruments/POVMs should be introduced only if they
  improve reuse without blocking the core proof.
- **Zero-probability outcomes:** conditional state must require a proof of
  positive/nonzero outcome probability or return an option/subnormalized
  state. Never divide silently by zero.
- **Sharpness:** define probability-one spectral outcome directly for the
  finite setting and relate it to eigenspaces. Avoid assuming all observables
  have a preferred nondegenerate basis.
- **Modal indexing:** determine whether worlds, preparations, measurement
  contexts, and times are explicit indices. The minimal abstraction must still
  make “same reality” and alternative choices well typed.
- **Completeness:** decide whether it is relative to a theory, physical
  situation, set of quantities, and representation relation. A global Boolean
  is likely too coarse.
- **Axiom strategy:** put philosophical premises in theorem hypotheses or
  fields of a named assumption bundle. Reserve Lean's trusted axioms for those
  already inherited from Lean/mathlib and audit with `#print axioms`.
- **Continuous variables:** later choose among Schwartz distributions, rigged
  Hilbert spaces, spectral measures, or normalized Gaussian/two-mode-squeezed
  approximants. An approximant proves high-probability rather than exact
  probability-one prediction, so it does not instantiate the unmodified EPR
  reality criterion without an additional limiting principle.
- **Constructive/classical footprint:** finite-dimensional spectral arguments
  may use classical choice or quotient soundness inherited from mathlib.
  Record, do not conceal, the axiom footprint of main declarations.

## Success Metrics and Final Verification Requirements

The original objective is achieved only when all of the following hold:

- A pinned Lean 4/mathlib project builds reproducibly from a documented command.
- Public modules provide reusable definitions for bipartite states,
  measurements, conditional states, perfect predictions, and incompatible
  observables at the chosen level of generality.
- A finite-dimensional EPR/steering example is fully proved, including outcome
  probabilities, conditional states, perfect correlations, and the stronger
  no-common-sharp-state property.
- Operational no-signalling is formalized and proved separately from an
  explicit ontic no-disturbance premise.
- Reality, simultaneous reality, completeness, and all bridges used in the EPR
  inference are explicit and documented as interpretative assumptions.
- The main incompleteness result is a conditional theorem tied to the verified
  quantum example, with no philosophical premise asserted unconditionally.
- The paper-to-Lean map identifies the declarations corresponding to the
  paper's central claims and records divergences, corrections, idealizations,
  and unresolved questions.
- The continuous-variable example is either rigorously formalized in suitable
  infrastructure or explicitly left as an audited extension with precise
  missing obligations; it is never represented falsely as a normalized `L²`
  state.
- Completed/public modules contain no `sorry`, `admit`, or unexplained
  project-specific `axiom` declarations.
- Focused builds, the full build, source scans, `git diff --check`, and
  `#print axioms` audits for the main results all pass and are recorded.

## Indexed Stages

### 1-FOUNDATIONS

**Status:** Complete on 2026-07-17. See `goal-1/1-FOUNDATIONS.md` for commands,
failures encountered, and verification evidence.

#### Big Picture Objective

Establish a minimal, pinned, validated Lean project and select representations
based on the actual mathlib surface rather than assumptions.

#### Detailed Implementation Plan

- Reinspect the repository and source documents.
- Choose and record pinned Lean/mathlib versions.
- Create the minimal Lake project and namespace/module skeleton.
- Probe relevant mathlib APIs with tiny compile-checked examples.
- Record decisions for states, observables, tensor products, measurements,
  partial traces, and module layering.
- Create a living correction log and paper-map destination within project
  documentation without claiming unverified results.

#### Completion Requirements

- `lake build` succeeds from a clean project state.
- Exact versions and setup/build commands are documented.
- Each representation decision cites a compile-checked probe or a documented
  absence/obstruction.
- No substantive theorem is postulated; scans find no `sorry`, `admit`, or
  project-specific `axiom` in completed Lean files.
- The stage file records focused and full build output plus `git diff --check`.

### 2-QUANTUM-CORE

**Status:** Not started; first incomplete stage.

#### Big Picture Objective

Define the reusable finite-dimensional state, observable, outcome, sharpness,
and subsystem vocabulary needed by later stages.

#### Detailed Implementation Plan

- Implement normalized pure states and/or density operators according to Stage
  1's checked design.
- Define observables and projective outcomes without assuming nondegeneracy.
- Define Born probability, probability-one sharpness, and joint sharpness.
- Add lemmas connecting eigenvectors, projectors, and probability-one outcomes.
- Keep basis-specific qubit constructions out of the generic core.

#### Completion Requirements

- Definitions enforce or explicitly carry normalization and positivity.
- Zero vectors and invalid states cannot silently satisfy physical state APIs.
- Generic sharpness lemmas compile and have focused tests/examples.
- Public imports remain acyclic and narrow.
- Focused build, relevant consumer build, hole/axiom scan, and diff check pass.

### 3-BIPARTITE

#### Big Picture Objective

Build the bipartite and local-operation layer with mathematically correct
subsystem typing.

#### Detailed Implementation Plan

- Define bipartite states and local observables/operations.
- Implement or wrap tensor products and reduced states/partial trace.
- Prove basic normalization and locality-of-action lemmas.
- Keep finite basis calculations isolated behind reusable statements.

#### Completion Requirements

- Subsystem A and B operations are not interchangeable by accidental coercion.
- Product-state and at least one entangled-state sanity examples compile.
- Reduced-state normalization and local-operator identities are proved.
- No use of the reference/example state is hidden inside generic definitions.
- Focused/full-required builds, scans, and diff check pass.

### 4-CONDITIONALS

#### Big Picture Objective

Formalize selective measurements and conditional/relative states while keeping
them distinct from nonselective post-measurement and reduced states.

#### Detailed Implementation Plan

- Define projective measurement outcomes and branch probabilities.
- Define subnormalized branches and normalized conditional states with explicit
  nonzero-probability evidence.
- Prove normalization and probability formulas.
- Relate vector-level and density-level descriptions if both are used.
- Document degeneracy and phase invariance.

#### Completion Requirements

- Conditioning on a zero-probability branch is impossible or explicitly
  represented as absent.
- Selective, nonselective, and reduced states have distinct APIs.
- Core conditional-state identities are proved without basis-specific hacks.
- Focused builds, edge-case tests, scans, and diff check pass.

### 5-STEERING

#### Big Picture Objective

Verify a finite-dimensional EPR steering example completely.

#### Detailed Implementation Plan

- Define Pauli `X`, Pauli `Z`, their eigenstates/projectors, and a chosen Bell
  state with explicit conventions.
- Compute all relevant outcome probabilities.
- Prove the normalized conditional B state for every relevant A outcome.
- Derive probability-one predictions, including correlation or anticorrelation
  signs.
- Package the results as a reusable steering scenario.

#### Completion Requirements

- Every claimed measurement branch has its probability and conditional state
  proved.
- Both alternative measurement settings yield verified perfect predictions.
- Sign, basis-order, tensor-order, and normalization conventions are tested and
  documented.
- No philosophical conclusion appears in this mathematical example module.
- Focused and adjacent builds, scans, and diff check pass.

### 6-INCOMPATIBILITY

#### Big Picture Objective

State and prove the precise obstruction supplied by the chosen incompatible
observables.

#### Detailed Implementation Plan

- Define commutation/noncommutation and common/joint sharpness separately.
- Prove Pauli `X` and `Z` do not commute.
- Prove they have no common nonzero eigenvector and no state sharp for both in
  the sense used by the EPR bridge.
- Add a counterexample or theorem documenting why noncommutativity alone is
  insufficient in general dimensions.

#### Completion Requirements

- The final exclusion theorem uses `not jointly sharp` or an equivalent exact
  property, not an unjustified inference from bare noncommutation.
- The relationship between the two notions is documented with checked evidence.
- Proofs cover mixed states if the main logic uses them, or the restriction to
  pure states is explicit.
- Focused builds, negative/sanity checks, scans, and diff check pass.

### 7-NO-SIGNALLING

#### Big Picture Objective

Prove the operational no-signalling fact and formally separate it from EPR's
stronger locality/no-real-change premise.

#### Detailed Implementation Plan

- Define operational no-signalling as invariance of B's unconditioned outcome
  statistics or marginal under allowed local nonselective operations on A.
- Prove it for the selected measurement scenario, and generically if the chosen
  infrastructure supports a clean theorem.
- Define ontic no-disturbance only in the interpretative layer.
- Provide explicit non-implication documentation: the operational theorem is
  not used as a proof of the ontic premise.

#### Completion Requirements

- The theorem compares unconditioned marginals, not selected conditional states.
- Conditional steering changes are demonstrated without contradicting the
  no-signalling result.
- Dependency inspection confirms that ontic locality is not derived from the
  operational theorem.
- Focused/adjacent builds, scans, and diff check pass.

### 8-EPR-LOGIC

#### Big Picture Objective

Reconstruct the EPR inference as a transparent conditional logical theorem.

#### Detailed Implementation Plan

- Define physical situations, quantities/values, elements of reality,
  simultaneous reality, theory counterparts, and relative completeness.
- Define named assumption bundles or theorem hypotheses for the reality
  criterion, ontic no-disturbance, counterfactual stability/aggregation, and
  the completeness-to-representation bridge.
- Prove small lemmas corresponding to each inference step.
- Prove the abstract incompleteness theorem, then instantiate its mathematical
  premises with the Bell steering and incompatibility results.
- Ensure alternate readings can reject individual premises without making the
  definitions inconsistent.

#### Completion Requirements

- The main theorem signature exposes every interpretative dependency.
- No reality, locality, or completeness premise is a global project axiom or an
  unconditional theorem about the physical world.
- The proof does not conflate alternative contexts without the named
  aggregation premise.
- The Bell instantiation consumes the previously verified example rather than
  duplicating its calculations.
- Focused/full builds, theorem-signature review, scans, diff check, and
  `#print axioms` pass with recorded output.

### 9-CONTINUUM

#### Big Picture Objective

Give the original position-momentum example a rigorous status and determine
the strongest feasible formal reconstruction.

#### Detailed Implementation Plan

- Map Eqs. (2), (6), and (9)–(18) to their mathematical objects and missing
  analytic conditions.
- Audit Fourier normalization, signs, distribution identities, spectra, and
  unbounded-operator domains.
- Inspect mathlib support for Schwartz functions/distributions, Fourier
  transforms, spectral measures, and unbounded operators.
- Choose one evidence-backed outcome: a rigorous generalized-state treatment,
  normalized approximants with quantified error, or a documented obstruction
  and exact future obligations.
- Keep this layer independent of the already completed finite-dimensional EPR
  theorem.

#### Completion Requirements

- No plane wave or delta distribution is declared to be a normalized `L²`
  vector.
- Every formalized equation has required domain and normalization hypotheses.
- If approximants are used, the result states approximate rather than exact
  prediction and does not invoke the exact reality criterion silently.
- If blocked, checked library gaps and a concrete next construction are
  recorded; a fake or assumed theorem is not accepted.
- Relevant builds/probes, scans, and diff check pass.

### 10-AUDIT

#### Big Picture Objective

Finish the reusable API, source traceability, correction record, and trust
audit for the whole project.

#### Detailed Implementation Plan

- Stabilize thin public API modules and module-level documentation.
- Complete a paper-to-declaration table with theorem status and corrections.
- Record all idealizations, strengthened hypotheses, ambiguities, and open
  interpretative issues.
- Add examples showing how to instantiate or decline the philosophical
  premises.
- Run complete build, proof-hole scans, forbidden-shortcut scans, dependency
  checks, and axiom audits for all main results.

#### Completion Requirements

- Every main paper claim is mapped to a Lean declaration, an explicit premise,
  a correction, or a clearly justified unresolved item.
- Public modules are reusable and do not expose diagnostic scaffolding.
- The full pinned build passes with no `sorry`, `admit`, or unexplained
  project-specific axioms in completed modules.
- `#print axioms` output for the main mathematical and EPR theorems is recorded
  and explained.
- `git diff --check` and all goal-specific validation commands pass.
- Remaining issues are explicit next work and do not undermine claims marked
  complete.

## Major Uncertainties to Resolve During the Goal

- Whether mathlib's current tensor-product and partial-trace APIs make an
  abstract finite-Hilbert-space treatment economical, or whether matrices on
  fixed finite indices should underpin the initial reusable layer.
- Whether the main example should be pure-state-first or density-matrix-first.
- The weakest precise formal definitions of completeness and theory
  counterpart that recover EPR's inference without building predictability
  into completeness by fiat.
- The correct modal/context indexing for alternative measurements and “the
  same reality.”
- How much general measurement theory belongs in the stable core versus a
  projective-measurement specialization.
- Whether a rigorous continuous-variable extension is proportionate to
  available mathlib infrastructure; this cannot be decided before checked API
  probes.
- Whether exact probability-one premises are physically robust enough for an
  approximant treatment, or need an explicitly different approximate reality
  criterion.

These are planned proof/design obligations, not licenses to silently choose the
easiest formulation.
