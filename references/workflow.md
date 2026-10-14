# Work process

## Task order

1. Approved spec/plan before any execution.
2. Backend first when a contract exists; frontend consumes the recorded contract.
3. Dependency-ordered waves; small slices with green gates.
4. Review (`review-checklist.md`) → fix only approved/requested items → document
   what changed → close with a proposed commit message.

## Verification scope

- `changed_files` = added, copied, modified, or renamed source; empty = error.
- Lint, format, and policy ONLY on those files; broader suites/typecheck/
  analysis only when the tool needs context — record reason and scope.
- Commands run in the environment owning the code (project container/service).

## Commits and Git

- Conventional Commits + hooks (lint/autofix on commit, gates on push).
- Unresolved finalization = confirm each action; never force-push nor infer
  past approval. Merge/PR only with explicit approval, green CI, clean branch.

## Task documentation

- Behavior/contract changes update the owning module doc: responsibility,
  inputs/outputs/errors, invariants, side effects, auth/privacy, config, and
  examples. No duplicated facts without a canonical owner.
- Final report: commands, environments, pass/fail, asserts/coverage,
  pre-existing or pending failures — with `file:line` per finding and a
  counted verdict.
