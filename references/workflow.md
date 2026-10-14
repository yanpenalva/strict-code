# Work process (summary)

Canonical detail lives in `delivery.md`, `orchestration.md`, `quality-gates.md`,
and `module-docs.md`. This file is the short version:

1. Approved spec/plan → dependency-ordered waves → implement → review →
   fix approved items → document → close per `delivery.md` criteria.
2. Verify `changed_files` only (empty = error); broader suites only with
   recorded reason (`quality-gates.md`).
3. Git: `confirm_each` unless resolved otherwise; merge/PR with explicit
   approval (`orchestration.md`).
4. Behavior/contract changes update the owning module doc (`module-docs.md`).
5. Final report: commands, environments, pass/fail, coverage, pending failures,
   `file:line` findings, counted verdict.
