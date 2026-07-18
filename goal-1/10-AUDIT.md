# 10-AUDIT

## Current Facts

- Stage 10 is the first incomplete and final indexed stage in
  `goal-1/0-plan.md`. Stages 1--9 and their evidence records are preserved.
- The Stage 10 start worktree is clean at autosave commit `6fb4051`; there are
  no uncommitted changes to preserve.
- Lean is pinned to `v4.31.0`, and mathlib is pinned to
  `fabf563a7c95a166b8d7b6efca11c8b4dc9d911f` in both Lake configuration and
  manifest.
- The complete local transcription of printed pages 777--780 has been
  reinspected. The existing paper map covers the completeness condition,
  sufficient reality criterion, Eqs. (2)--(18), alternative conditional wave
  functions, the no-real-change/same-reality premise, the simultaneous-reality
  aggregation, the final reductio, the objection, and the open possibility of
  another complete theory. Final row-by-row declaration verification is still
  required.
- Baseline warning-as-error `lake build EPR EPR.Continuum.Idealized` succeeds
  with 3614 jobs. Default `lake build` succeeds with 3210 jobs because
  `defaultTargets = ["EPR"]` and the current root does not import continuum.
- `EPR.lean` currently imports only `EPR.Examples.BellNoSignalling` and
  `EPR.Examples.BellEPR`; it has no module documentation. Every public leaf
  inspected has a module docstring, and no public module imports `EPR.Audit`.
- The README remains a setup-era document: it says the project is being
  developed and the main incompleteness result is eventual, and it does not
  inventory the completed API, limitations, or final audit command.
- Eight stage-specific axiom leaves contain 245 `#check` commands and 283
  `#print axioms` commands in total. Their recorded outputs use no project-
  specific axioms, but there is no aggregate whole-library audit target or
  public-root surface sentinel.
- `EPR.Audit.EPRLogic` provides checked rejection models for each major
  interpretative bridge and an operational-no-signalling/ontic-change model.
  It does not yet give one consolidated positive model witnessing that the
  premise interfaces can also be instantiated coherently.
- Initial scans find no `sorry`, `admit`, `sorryAx`, project `axiom`, `opaque`,
  `unsafe`, `partial def`, `implemented_by`, or public audit import. Git diff
  and whitespace checks are clean.

## Updated Assumptions

- Stage 10 is an API, traceability, and trust audit. It must not strengthen the
  mathematical or philosophical conclusions merely to make the final surface
  look more complete.
- The stable generalized-state continuum leaf should be reachable from the
  public root so the default target covers every completed public branch. This
  umbrella import must not make any finite module depend on continuum or any
  continuum module depend on finite/interpretative code.
- Diagnostics remain opt-in `EPR.Audit.*` modules. A public-root surface probe
  may import only `EPR`, while a separate final axiom target may aggregate all
  private stage audit leaves.
- Existing rejectability sentinels are genuine examples of declining premises.
  A small positive proposition-valued model can demonstrate instantiation
  without asserting that the premises describe nature.
- The raw Eq. (9) oscillatory-integral identity, affine-distribution
  nonzeroness/support/non-`L²` classification, self-adjoint spectral
  realizations, and continuous conditioning remain future analytic
  obligations. Final documentation must not relabel them as completed.

## Big Picture Objective

- Finish the reusable public surface, source-to-declaration traceability,
  correction/limitation record, premise-choice examples, and whole-library
  trust audit so every success metric in `goal-1/0-plan.md` has direct current
  evidence.

## Detailed Implementation Plan

- Give `EPR.lean` a concise library overview and re-export the independent
  `EPR.Continuum.Idealized` leaf alongside the finite no-signalling and
  conditional-EPR branches.
- Add a private public-surface audit importing only `EPR` and checking
  representative reusable definitions and main theorems from every completed
  layer, including continuum.
- Add a private final axiom leaf that aggregates every existing stage-specific
  axiom leaf and prints the axioms of the principal mathematical, operational,
  logical, diagnostic-boundary, and continuum results.
- Extend `EPR.Audit.EPRLogic` with a proposition-valued model in which the
  interpretative bridges are all satisfiable; retain and audit the existing
  independent rejection models.
- Replace the setup-era README with the completed library surface, exact pinned
  build/audit commands, a clear conditional-theorem statement, examples for
  accepting or declining premises, and the continuum limitations.
- Audit and update `docs/PaperMap.md`, `docs/Corrections.md`, and
  `docs/Dependencies.md` so every material source claim, modern addition,
  correction, idealization, trust boundary, and unresolved obligation has an
  exact status and declaration path.
- Fold exact final evidence into this record and the master plan only after all
  completion checks pass.

## No-Cheating Checks

- Confirm no `EPR.Audit` import is reachable from `EPR.lean` or any public
  runtime/example/logic/continuum module.
- Confirm the public-surface audit imports only `EPR`; declarations that pass
  only because it imports internal or audit modules do not count.
- Confirm finite modules still contain no continuum imports and the continuum
  leaf still contains no finite quantum, example, logic, or reality API.
- Inspect the abstract and Bell incompleteness theorem signatures and bodies:
  all actuality, ontic, reality/value, counterfactual, completeness, and
  no-joint-representation inputs must remain explicit and consumed.
- Confirm no no-signalling declaration occurs in the abstract/Bell EPR proof
  path, and no bare Pauli noncommutation theorem replaces the no-joint-sharp
  result.
- Confirm the premise-choice examples are proposition-valued models, not
  global physical axioms or unconditional claims about nature.
- Confirm continuum objects never inhabit finite state/probability/reality
  APIs and all remaining analytic obligations stay explicit.
- Check every PaperMap row against a current declaration, explicit premise,
  correction, or named unresolved item; verify all code-formatted declaration
  names exist.
- Run proof-hole, project-axiom, forbidden-declaration, public-import,
  dependency-direction, theorem-body, stale-name/status, Markdown-table,
  whitespace, pin, manifest, and Git diff/history scans.

## Completion Requirements

- The public `EPR` root documents and exports every stable completed branch,
  while all diagnostic scaffolding remains opt-in and outside that import
  chain.
- Every main paper claim is mapped to a checked declaration, explicit premise,
  correction, modern finite analogue, or precisely stated unresolved analytic
  obligation.
- The README and living docs state the exact conditional scope, operational/
  ontic distinction, noncommutation correction, continuum representation, and
  remaining limits.
- Checked examples demonstrate both coherent premise instantiation and
  independent rejection without asserting either interpretation as nature.
- A public-root-only surface audit and aggregate axiom audit compile with
  warnings as errors; every principal result has an explained trusted-axiom
  footprint and no project-specific axiom.
- Focused changed-module builds, the public/default full build, every
  stage-specific audit through the aggregate target, proof-hole and forbidden-
  shortcut scans, dependency/API checks, exact declaration-name checks,
  `git diff --check`, and clean autosave-managed status all pass with exact
  evidence recorded.
- The master plan's final success metrics are audited requirement by
  requirement before Stage 10 or the whole goal is marked complete.

## Stage Results

- Pending implementation and final evidence.
