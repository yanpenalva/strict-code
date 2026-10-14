# Quality gates

How an AI reader must use this document: ceilings BLOCK, targets GUIDE.
Every finding cites metric + measured value + `file:line`.
Example: `[BLOCKING] method 172 lines (ceiling 150) — auth/LoginService.php:40`.

## Structural ceilings (production code)

| Metric | Ceiling | Target |
|---|---|---|
| Lines per file | 500 | — |
| Declared methods/functions per file | 15 | — |
| Lines per method/function | 150 | <30; extraction candidate >50 |
| `return` statements per method | 3 | — |
| Parameters per method | 7 (above: cohesive immutable DTO/param object) | — |
| Cyclomatic complexity | 10 | — |
| Cognitive complexity | 15 | — |
| Meaningful nesting levels | 3 | 1 |

## Counting rules (apply identically every time)

1. File lines: total lines of the file (`wc -l`); a file at 500 splits by
   responsibility before the task closes.
2. Declared methods: every named declaration including private methods and the
   constructor. Anonymous callbacks/closures do NOT count here — they count
   toward the enclosing function's size and complexity instead.
3. Method lines: lines of the declaration body, excluding blank lines. Helpers
   are not exemptions: each new file obeys the same ceilings and exposes one
   focused, tested public seam.
4. Returns: every `return` statement counts, including guard-clause returns.
   `throw` is not a return. Needing more than 3 means extracting a validation
   or decision helper — never adding `else` or nesting to dodge the count.
5. Parameters: named + promoted constructor properties. Boolean flags that
   switch the whole behavior are forbidden regardless of count — split the
   operation or use a closed typed variant.
6. Complexity: from the configured analyzer when available; otherwise reviewer
   judgment, recorded as `NOT MEASURED`, never as a passing value.
7. Nesting: control-flow levels only; more than one level of indentation must
   justify itself, more than three is a failure.

## Enforcement procedure

1. Measure changed production files only (`changed_files`; empty list = error).
2. IF any ceiling is exceeded THEN decompose in the same task: split into
   validation, lookup, transformation, persistence, and response construction
   (cohesive private methods or dedicated collaborators).
3. IF decomposition would create greater risk THEN record an approved, scoped
   exception (reason + expiry) — the only way to ship above a ceiling.
4. NEVER evade a ceiling with trivial wrappers, fragmented files, or metric-only
   splits; NEVER extract just to reduce lines without reducing complexity.
5. Report every measurement (metric, value, ceiling, file:line) in the delivery.

## Duplicated literals

A literal is significant when `len >= 5` AND it contains `:`, `.`, `*`, `/`,
OR `len >= 20`. It fails when the SAME significant literal occurs `>= 3x` in
one production file (Vue counts `<script>` content). Short API keywords
(`string`, `nullable`, `integer`, `array`, `required`) are ignored; rule params
(`max:255`), field paths (`items.*.type`), and long messages are covered.
Fix: named typed constant, enum, or value object — one owner per value.

## New-code targets (Sonar)

- Coverage ≥80%; duplicated lines <3%; zero open vulnerabilities; zero
  unreviewed security hotspots; zero new blocking code smells; zero new bugs.
- A threshold described as "configured" must be cited from the active Sonar
  server profile; without that evidence it is a recommendation or `NOT FOUND`.

## Suppressions and hotspots

- No `NOSONAR` or equivalent without a technical reason + work reference;
  review and remove stale suppressions.
- Before merge, check: Bugs, Vulnerabilities, Security Hotspots, Code Smells,
  Coverage, Duplications, Maintainability/Reliability/Security ratings.

## Local execution

- Checks (lint, format, policy) run on explicit changed files, read-only by
  default; autofix only through an authorized path (pre-commit hook or an
  explicit fix command with the same file list).
- A CI job with `allow_failure: true` is informative — it never replaces the
  review gate.
