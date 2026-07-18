# 4-CONDITIONALS

## Current Facts

- Stages 1–3 are complete, and the worktree was clean at Stage 4 start.
- Lean is pinned to `v4.31.0` at commit
  `68218e876d2a38b1985b8590fff244a83c321783`; mathlib is pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.
- Baseline `lake build EPR.Quantum.Bipartite` and full `lake build` succeed
  with 2664 and 2666 jobs respectively. Baseline proof-hole and
  declaration-level project-axiom scans have no matches.
- The four-page image-only PDF facsimile was inspected directly at page 779,
  and it agrees with the local transcription. Eqs. (7)–(8) say that selecting
  an outcome on system I reduces the joint expansion to one term and assigns
  the corresponding coefficient wave function to system II. The subsequent
  claims about “no real change” and “the same reality” are interpretative and
  are not part of this stage.
- `EPR.Quantum.Core` supplies positive trace-one density states, orthogonal
  projections that may be degenerate, nonzero spectral outcomes, and the real
  Born-probability expression. It currently proves the probability-one support
  case but not general probability bounds.
- `EPR.Quantum.Bipartite` supplies explicitly tagged local projections,
  checked lifts, partial traces, and normalized unconditioned reduced states.
  It deliberately contains no selective measurement semantics.
- A fresh pinned-source search found no ready quantum measurement, instrument,
  Lüders-update, selective-state, or conditional-state abstraction. The pinned
  API does provide positivity of `B * ρ * Bᴴ`, positive trace, trace cyclicity,
  finite positive sums, and the algebra needed for a narrow project-owned
  construction.

## Updated Assumptions

- The finite projective selective branch should use the Lüders matrix `PρP`.
  Its positivity, trace/probability identity, and upper bound must be theorems,
  not caller-supplied fields.
- A project-owned `SubnormalizedState` should enforce positivity and trace at
  most one while permitting the zero matrix. Normalization should require a
  proof that its real trace weight is strictly positive.
- A conditional state should be constructed only from a positive-probability
  branch. A zero-probability outcome may remain a valid nonzero measurement
  projector but cannot produce a normalized conditional state.
- Selective conditioning, a full measurement's nonselective state, and the
  pre-measurement reduced state need distinct definitions and signatures.
- A full finite projective measurement should carry nonzero projections,
  pairwise orthogonality, and resolution of the identity. Outcome labels are
  mathematical branch labels; selecting one does not assert that an actual
  physical event occurred.
- Degenerate projectors must remain supported. The Lüders branch preserves
  coherence within the selected subspace and must not silently choose a
  rank-one vector.
- Vector-level projected-ket formulas may be used to connect pure inputs to
  density branches, but normalized conditional density states should be
  invariant under global phase.
- No separation, disturbance, reality, completeness, counterfactual, Bell,
  steering, or no-signalling claim belongs in the generic conditional module.

## Big Picture Objective

Build a reusable finite-dimensional projective-conditioning layer with checked
subnormalized branches, explicit positive-probability normalization, full
nonselective measurement states, and bipartite conditional marginals, while
keeping every API distinct from unconditioned reduction and interpretation.

## Detailed Implementation Plan

- Add `EPR.Quantum.Conditional` over `EPR.Quantum.Bipartite`.
- Define positive trace-at-most-one subnormalized states and prove their real
  trace weight, zero-weight, and positive-weight normalization laws.
- Define `ludersBranchMatrix ρ P = PρP`, package it as a subnormalized
  state, and prove positivity, trace/Born-probability equality, general
  probability bounds, and the zero-branch equivalence.
- Define normalized `conditionalState` with an explicit strict-positivity proof
  and expose its matrix and trace formulas.
- Define full finite projective measurements, outcome probabilities, their
  normalization, and a normalized `nonselectiveState` obtained by summing all
  Lüders branches.
- Define projected pure kets, prove the pure-density selective-branch formula,
  and prove global-phase invariance of pure density inputs and their
  conditional density states.
- Add `localAConditionalBState` for an A-side selected projection and the
  symmetric `localBConditionalAState`, constructed by reducing the normalized
  selected joint state rather than confusing conditioning with the original
  marginal.
- Add an executable audit with a proper degenerate projector, positive and
  zero-probability branches, a two-outcome projective measurement,
  nonselective dephasing, and a phase-invariance check. Use no Stage 5 Bell or
  Pauli definitions.
- Add a separate axiom/signature audit for the principal bounds,
  normalization, nonselective, pure-density, phase, and bipartite conditional
  declarations.

Expected files:

- `formal/EPR.lean`
- `formal/EPR/Quantum/Conditional.lean`
- `formal/EPR/Audit/Conditional.lean`
- `formal/EPR/Audit/ConditionalAxioms.lean`
- `docs/Dependencies.md`
- `docs/PaperMap.md`
- `goal-1/0-plan.md`
- `goal-1/4-CONDITIONALS.md`

## No-Cheating Checks

- Inspect `conditionalState` to confirm that normalization consumes explicit
  strict positive-probability evidence and cannot be called on the checked
  zero-probability branch.
- Confirm subnormalized branch positivity and the probability upper bound are
  derived rather than inserted as assumptions on `ludersBranch`.
- Confirm the nonselective state sums every branch and uses the measurement's
  identity resolution; it must not select one branch or reuse a conditional
  state.
- Inspect signatures and definitions to confirm `localAConditionalBState`,
  `nonselectiveState`, and `reducedB` are separate operations.
- Confirm the degenerate audit preserves two-dimensional range coherence and
  does not rely on a hidden rank-one hypothesis.
- Confirm phase invariance is proved at the density/conditional-state level,
  not asserted as literal equality of phase-different kets.
- Confirm generic definitions mention no qubit, Bell, Pauli, reference state,
  reality, locality, disturbance, completeness, no-signalling, plane wave,
  delta, or `L²` construction.
- Scan for `sorry`, `admit`, declaration-level `axiom`, `opaque`, `unsafe`,
  broad coercions, and audit imports in the public root.

## Completion Requirements

- Generic selective branches are checked subnormalized states whose weights
  equal Born probabilities in `[0, 1]`.
- Zero probability is equivalent to a zero selective branch, and normalized
  conditioning requires strict positive-probability evidence.
- `conditionalState` is positive and trace one by construction, with a proved
  normalized-matrix formula.
- A full projective measurement has normalized outcome probabilities and a
  checked positive trace-one nonselective state.
- Pure projected-ket and density-branch descriptions agree, and conditional
  density states are invariant under global phase.
- Degenerate-projector and zero-probability edge cases compile and prove the
  intended behavior without basis-specific code in the generic module.
- A-side and B-side bipartite conditional marginals compile with signatures
  distinct from unconditioned reduced states.
- `lake build EPR.Quantum.Conditional`, both Stage 4 audit modules, and the
  public `EPR` consumer succeed, followed by required full `lake build`.
- Proof-hole/project-axiom, zero-conditioning, generic-reference/shortcut,
  dependency, axiom, whitespace, and diff checks pass and are recorded below.

## Stage Results

**Status:** Complete on 2026-07-17. Stage 5 is the first incomplete stage and
was not started here.

### Implemented surface

- Added public `EPR.Quantum.Conditional` over the Stage 3 bipartite layer and
  made it the public `EPR` root's highest import. Audit modules remain outside
  that root.
- Added `SubnormalizedState`, whose matrix is positive semidefinite and whose
  real trace is at most one. Its trace weight is proved nonnegative, is zero
  exactly for the zero matrix, and can be normalized only from explicit
  evidence `0 < σ.weight`.
- Added the raw Lüders branch `ludersBranchMatrix ρ P = PρP`, its checked
  `ludersBranch`, trace/Born-probability identities, general probability bounds
  in `[0, 1]`, and zero/positive probability characterizations.
- Added `conditionalState` with a strict positive-probability proof in its
  signature. Its normalized matrix formula, selected-projector support, and
  repeated selected probability one are proved.
- Added `ProjectiveMeasurement` with nonzero projections, pairwise
  orthogonality, and identity resolution. Outcome probabilities sum to one;
  `nonselectiveState` is the positive trace-one sum of every raw Lüders branch,
  not a selected branch or an unweighted sum of normalized states.
- Added the pure-state bridge: projected kets, branch outer-product and norm
  formulas, a normalized `conditionalPureState`, agreement with density-level
  conditioning, and density/conditional-state invariance under unit global
  phase. No equality of phase-different ket representatives is asserted.
- Added symmetric A→B and B→A local outcome probabilities, subnormalized
  joint and remote relative branches, normalized selected joint states, and
  conditional remote states. Normalizing a remote relative branch is proved
  equal to reducing the normalized selected joint state. These APIs remain
  distinct from `reducedA` and `reducedB`.
- In the finite reconstruction of Eqs. (7)–(8), the selected coefficient wave
  function is generally subnormalized: its squared norm is the outcome
  probability. `localARelativeBBranch` is the corresponding density-level raw
  branch, while `localAConditionalBState` requires positive probability before
  normalization. The degenerate Lüders rule and the nonselective state are
  explicit modern modeling choices, not rules claimed to follow from EPR's
  text.

### Executable and trust audits

- `EPR.Audit.Conditional` constructs a proper rank-two projector on `Fin 3`
  and its rank-one complement as a complete measurement. A basis input proves
  that a nonzero projector can have probability and branch matrix zero, and
  that the branch is not conditionable.
- A coherent `3/5 |0⟩ + 4/5 |2⟩` input proves branch probabilities `9/25`
  and `16/25`, both normalized selected states, normalized probability sum,
  nonselective dephasing, and inequality of the nonselective and input states.
- A `3/5 |0⟩ + 4/5 |1⟩` input entirely inside the rank-two range proves
  that degenerate Lüders conditioning preserves the state and its nonzero
  off-diagonal coherence. The generic implementation therefore does not hide
  a rank-one assumption.
- Multiplication by phase `i` is proved to change the ket representative while
  leaving both its density state and normalized conditional density state
  unchanged.
- A nonmaximally correlated `3/5 |00⟩ + 4/5 |11⟩` audit proves an A-side
  outcome probability `9/25`, its conditional B state, the unconditioned B
  marginal, and their inequality. This tests the distinction without defining
  the Bell/Pauli steering scenario reserved for Stage 5.
- `EPR.Audit.ConditionalAxioms` checks the positive-evidence signatures and
  prints both directions of the remote-conditioning API. Every printed Stage
  4 declaration and executable witness depends only on `propext`,
  `Classical.choice`, and `Quot.sound`.

### Verification evidence

- Baseline before edits: `lake build EPR.Quantum.Bipartite` succeeded with
  2664 jobs; `lake build` succeeded with 2666 jobs.
- `lake build EPR.Quantum.Conditional` succeeded with 2665 jobs.
- `lake build EPR.Audit.ConditionalAxioms` succeeded with 3202 jobs and also
  rebuilt the warning-free executable audit. The standalone executable-audit
  build succeeded with 3201 jobs.
- `lake build EPR` succeeded with 2667 jobs, and the required final
  `lake build` succeeded with 2667 jobs.
- An independent warning-as-error consumer build of `EPR`, the conditional
  module, and both Stage 4 audit modules succeeded with 3204 jobs.
- `#check` output confirms that `SubnormalizedState.normalize`,
  `conditionalState`, `conditionalPureState`, and both local conditional-state
  functions require strict positive-weight/probability proofs. There is no
  total zero-probability normalization path.
- Scans over public/completed Lean sources found no `sorry`, `admit`,
  declaration-level `axiom`, `opaque`, or `unsafe`; the generic conditional
  module has no broad coercion and no `Fin 2`/`Fin 3`, qubit, Bell, Pauli,
  steering, perfect-prediction, interpretative, or continuum shortcut.
  Boundary-language matches are only the module documentation's explicit
  negative disclaimer about actual occurrence, no-signalling, and ontic
  no-disturbance.
- Import inspection confirms `EPR -> EPR.Quantum.Conditional ->
  EPR.Quantum.Bipartite`; neither Stage 4 audit is imported publicly.
  Relevant trailing-whitespace scans and `git diff --check` pass.
- The final toolchain recheck reports Lean `4.31.0`, commit
  `68218e876d2a38b1985b8590fff244a83c321783`; the manifest and Lake file still
  pin mathlib `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f`.

All final commands below were run from `formal/`:

```bash
lake build EPR.Quantum.Conditional
lake build EPR.Audit.Conditional
lake build EPR.Audit.ConditionalAxioms
lake build EPR
lake build
lake build -KwarningAsError=true EPR EPR.Quantum.Conditional EPR.Audit.Conditional EPR.Audit.ConditionalAxioms
lake env lean --version
rg -n '\b(sorry|admit)\b' EPR EPR.lean
rg -n '^[[:space:]]*(axiom|opaque|unsafe)[[:space:]]' EPR EPR.lean
rg -n '(instance.*Coe|CoeTC|CoeFun|\bcoe\b)' EPR/Quantum/Conditional.lean
rg -ni 'Fin[[:space:]]+[23]|qubit|bell|pauli|steer|perfect.?predict|ElementOfReality|NoOnticDisturbance|CompleteFor|SimultaneouslyReal|plane[ -]wave|Dirac|delta|L²' EPR/Quantum/Conditional.lean
rg -ni 'no-signalling|ontic|reality|disturbance|separation|actual.*outcome|outcome.*occurred' EPR/Quantum/Conditional.lean
rg -n '^(public )?import ' EPR.lean EPR/Quantum/Conditional.lean EPR/Quantum/Bipartite.lean EPR/Audit/Conditional.lean EPR/Audit/ConditionalAxioms.lean
rg -n '[[:blank:]]+$' EPR.lean EPR/Quantum/Conditional.lean EPR/Audit/Conditional.lean EPR/Audit/ConditionalAxioms.lean ../goal-1/0-plan.md ../goal-1/4-CONDITIONALS.md ../docs/Dependencies.md ../docs/PaperMap.md
rg -n --glob '!4-CONDITIONALS.md' '4-CONDITIONALS.*[Ii]n progress|No conditional state|selective reduction remains|remains a `4-CONDITIONALS`|selectiveBranchMatrix|conditionalBState|conditionalAState' ../goal-1 ../docs
rg --files ../goal-1 | sort
rg -n 'fabf563a7c95a166b8d7b6efca11c8b4dc9d911f|leanprover/lean4:v4.31.0' lake-manifest.json lakefile.toml lean-toolchain
git diff --check
```

The five ordinary build invocations succeeded with the job counts recorded
above; the combined warning-as-error build succeeded with 3204 jobs. The Lean
version and pin search returned exactly the recorded toolchain and mathlib
commits. The hole, declaration, coercion, generic-shortcut, trailing-whitespace,
and stale-text scans returned exit status 1 with no matches. The boundary scan
returned only lines 16, 18, and 19 of `Conditional.lean`, all within its
negative module disclaimer. The import scan returned only the intended public
chain plus the two diagnostic-leaf imports. The stage-file listing ended at
`4-CONDITIONALS.md`, confirming no Stage 5 record was created. `git diff
--check` returned status 0 with no output.

### Failures encountered and what changed

- The first support proof did not close by simplification because matrix
  multiplication needed explicit reassociation around `P * P`; the final
  proof exposes those algebraic steps and uses projection idempotence.
- The pure/density bridge initially rewrote in an unstable order and lacked
  explicit nonzero facts needed for inverse algebra. Rewriting to the projected
  outer-product form first and deriving nonzero probability/square-root facts
  from strict positivity produced a checked proof.
- Early local conditional formulas left aliases and partial-trace scalar
  transport unresolved. The final proof uses Stage 3's existing
  `traceOutA/BLinear` maps to show that normalization commutes with reduction
  through `map_smul`.
- Initial concrete `Fin 3` calculations were brittle under equality proofs and
  rational simplification. Value-indexed diagonal matrices and exhaustive
  finite cases removed proof-irrelevance artifacts. The redundant `Fin.ext`
  fallback in the rank-two conditional-matrix proof was removed after the
  linter showed that `norm_num` had already closed every case; the fallbacks
  that remain in other exhaustive proofs are exercised.
- Proving that phase multiplication changes the ket could not be discharged by
  numeral simplification alone; comparing `Complex.im` separates `i * 3/5`
  from `3/5` while the density-level equality remains phase invariant.
- Several dependent local-branch lemmas initially carried unused
  `DecidableEq` instances. Scoped `omit` declarations removed those accidental
  dependencies and made the compiled signatures match the actual proofs.

### What was learned

- Positivity of the Lüders sandwich plus positivity of the complementary
  projection is enough to derive all projective Born probabilities in
  `[0, 1]`; no probability-bound field is needed in the core definition.
- A subnormalized remote branch accurately retains the coefficient weight in
  the finite form of Eqs. (7)–(8). Linearity of the Stage 3 partial traces then
  proves that normalization and remote reduction agree when probability is
  positive.
- A proper degenerate projection and an input with within-range coherence are
  necessary diagnostics: rank-one-only examples would not expose an update
  that silently collapses too far.
- Global phase belongs at the ket-representative level, while physical
  invariance is equality of density and conditional density states, not
  literal equality of phase-different kets.
- A selected remote conditional state can differ from the original
  unconditioned marginal. That distinction is the substrate for later
  steering, but it is not yet an operational no-signalling statement and says
  nothing about ontic disturbance.

### Plan update

The density-first Lüders design is now checked rather than provisional. The
stage deliberately stops at reusable conditioning: it proves no Bell/Pauli
branch calculation, perfect prediction, steering scenario, operational
no-signalling theorem, or interpretative claim. Those remain in their indexed
later stages, with `5-STEERING` next.
