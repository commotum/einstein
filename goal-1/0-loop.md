# EPR-FORMAL Execution Loop

Use this protocol to execute `goal-1/0-plan.md` one stage at a time. The present
scaffold does not authorize starting a stage; wait for explicit instructions.

## Repeatable Loop

1. Sync current state with actual files and tests. Read the local paper, current
   plan, prior stage evidence, Lean sources, dependency versions, and git diff;
   do not trust stale summaries.
2. Update `goal-1/0-plan.md` with current facts before starting the next stage,
   especially corrections to the paper audit, mathlib availability, and any
   changed assumptions.
3. Select the first incomplete stage.
4. Create or refresh `goal-1/[INDEX]-[SHORTHAND].md` from the stage template
   below. Never overwrite unmerged evidence without preserving it.
5. Implement only that stage. Keep mathematical implementation,
   philosophical interfaces, diagnostics, and fallback experiments in their
   planned dependency layers.
6. Add verification and no-cheating checks that directly cover the stage's
   completion requirements.
7. Run focused tests, the smallest sufficient adjacent builds, any required
   full verification, source/axiom scans, and whitespace/diff checks appropriate
   to the repository.
8. Record exact commands, results, failures, corrections, and learned facts in
   the stage file.
9. Fold the results back into `goal-1/0-plan.md`, updating paper mappings,
   assumptions, unresolved issues, representation decisions, and later stages.
10. Continue toward the original objective. If stopping for the session, leave
    the goal in a resumable state with current evidence, the next experiment or
    proof obligation, concrete unblock actions, and assumptions still to
    challenge.

## Invariants

- Do not narrow the user's objective without saying so.
- Do not mark a stage complete without evidence.
- Do not use tests or green checks as evidence unless they cover the
  requirement.
- Prefer small, low-complexity stages that narrow uncertainty.
- Convert blockers into work items: decompose them, route around them, or turn
  them into proof and verification tasks.
- Preserve the distinction between implementation, verifier, diagnostic, and
  fallback paths.
- Preserve the distinction between mathematical theorem, operational fact,
  philosophical premise, and interpretation.
- Never turn EPR's reality criterion, completeness condition, locality premise,
  or counterfactual aggregation step into an unconditional physical theorem.
- Never use operational no-signalling as a proof of ontic no-disturbance.
- Never replace “no common sharp state” with bare noncommutativity unless a
  theorem with sufficient hypotheses has actually been proved.
- Never encode the paper's plane waves, delta functions, or Eq. (9) as ordinary
  normalized `L²` vectors.
- Keep normalization, nonzero conditioning probability, degeneracy, and
  unbounded-operator domains explicit.
- Do not accept `sorry`, `admit`, fabricated declarations, or unexplained
  project-specific `axiom` declarations as completion evidence.
- Do not let a finite-dimensional success erase the outstanding status of the
  original continuous-variable example; document the relationship accurately.
- Do not let the continuous-variable extension block or become a dependency of
  the finite-dimensional core.
- When the source is ambiguous, record the strongest correct reconstruction,
  the difference from the paper, and any residual uncertainty.

## Verification Protocol

At each stage, choose commands that match the files and pinned project layout
actually established in Stage 1. Record substitutions rather than blindly
copying placeholders.

Minimum checks after Lean setup normally include:

```text
lake build <touched.module>
lake build <adjacent.consumer.modules>
lake build
rg -n "sorry|admit|axiom" <Lean-source-roots> goal-1
git diff --check
```

Interpret scan hits rather than merely counting them. Documentation may mention
forbidden words as guardrails; completed Lean modules may not contain proof
holes or unexplained project-specific axioms. For main theorems, add checked
audit commands such as:

```text
#print axioms EPR.<main-mathematical-theorem>
#print axioms EPR.<main-conditional-logic-theorem>
```

Stage-specific checks must also inspect theorem signatures and dependency
direction. In particular:

- steering checks must cover every relevant outcome and convention;
- incompatibility checks must establish no common sharp state;
- no-signalling checks must use the unconditioned marginal;
- EPR logic checks must show all interpretative premises in hypotheses or
  explicit assumption structures;
- continuum checks must reject false normalization and expose domains;
- final checks must map every material paper claim to code, premise,
  correction, or unresolved obligation.

Before calling the whole goal complete, run the full pinned build from the
documented clean setup, all focused regression checks, proof-hole and
project-axiom scans, main theorem axiom audits, public dependency/API checks,
and `git diff --check`. A green build alone is not sufficient.

## Stage File Template

```markdown
# [INDEX]-[SHORTHAND]

## Current Facts

- Facts from current code, tests, docs, and previous stage results.

## Updated Assumptions

- Assumptions that still look valid.
- Assumptions that changed.
- Assumptions that need tests before being trusted.

## Big Picture Objective

- Restate the stage objective, adjusted for current facts.

## Detailed Implementation Plan

- Concrete code/doc/test changes for this stage.
- Files expected to change.
- New tests or commands required.

## No-Cheating Checks

- Explicit checks proving the implementation does not route through forbidden fallback paths.

## Completion Requirements

- Requirement-by-requirement checks.
- Required test commands.
- Documentation updates required.

## Stage Results

- Fill in at the end of the stage.
- Include tests run and outcomes.
- Include what was learned.
- Include what should change in `0-plan.md` before the next stage.
```

## Session Stop Condition

When pausing, do not claim progress beyond recorded evidence. State the first
incomplete stage, the exact next action, known blockers, and the assumptions
most likely to change. Completion means the original EPR formalization
objective has actually been achieved under `goal-1/0-plan.md`; open issues must
be carried forward explicitly rather than hidden behind a smaller result.
