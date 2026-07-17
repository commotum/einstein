# Continuation Prompt

```text
Work through goal-1/0-plan.md using the execution protocol in
goal-1/0-loop.md, beginning with the first incomplete stage and implementing
only one stage at a time unless I explicitly broaden the request.

The objective is to build a correct, reusable, pinned Lean 4/mathlib library
that reconstructs and audits Einstein, Podolsky, and Rosen's 1935 completeness
argument. Verify a finite-dimensional bipartite steering example first;
represent certainty, disturbance, elements of reality, simultaneous reality,
completeness, and counterfactual/locality bridges separately; and prove the EPR
incompleteness conclusion only as a conditional theorem with all interpretative
premises explicit. Keep operational no-signalling distinct from EPR's stronger
ontic no-disturbance premise. Do not infer no common sharp state from bare
noncommutativity. Never treat plane waves, Dirac deltas, or the paper's Eq. (9)
as normalized L² vectors.

At the start of each stage, inspect the actual paper, repository, current Lean
files, pinned dependencies, tests, prior stage evidence, and git diff; update
the plan with current facts; create or refresh the stage file from the loop
template; then implement only that stage. Add checks that cover its real
requirements, run focused and required full builds, scan for sorry/admit and
unexplained project axioms, audit the axioms of main results, run goal-specific
no-cheating checks and git diff --check, record exact evidence in the stage
file, and fold discoveries back into the plan.

Do not narrow the objective silently, encode philosophical claims as
unconditional theorems, fabricate analytic facts, or mark a stage complete
from irrelevant green checks. Convert blockers into checked diagnostics,
alternate formulations, explicit proof obligations, or concrete next work.
Completion means the original objective in goal-1/0-plan.md is genuinely
achieved; corrections and unresolved issues must remain explicit and be
carried forward as next work.
```
