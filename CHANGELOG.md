# Changelog

All notable changes to the `strict-code` skill. Versions below 1.0.0 are
development iterations; 1.0.0 is the first stable release.

## 1.2.1

- Loader fix: quote the `description` (unquoted `:` broke YAML frontmatter
  parsing and the skill refused to load).

## 1.2.0

- `bin/strict-code` CLI: `update [path]` pins any copy to the latest stable
  tag, `release <version>` cuts a release in one command (version bump,
  commit, tag, push, GitHub release, local verify), plus `version`;
  install via symlink, see README.

## 1.1.0

- Testing strategy: Unit-then-Feature order (unit locks the rule, feature
  locks wiring); behavior-only scope — no tests for language/framework
  guarantees; empty/pass-through classes take coverage-ignore instead of
  fake tests; privates covered only via public contract; silent-failure cut
  heuristic.
- PHP: every concrete class is `final` (`abstract` only with documented
  reason) — non-final concrete fails review.

## 1.0.0

- Stable release: 30 reference guides, en-US throughout, audited twice (sol
  medium executor + sol low reviewer); findings tracked in git history.

## 0.9.x

- 0.9.2 — Domain-first decomposition (15-method ceiling confirmed), named
  variable before branching, zero narrative comments (typers only), fat
  model/controller anti-pattern.
- 0.9.1 — N1 enforcement criteria for the 5 subjective rules (performance
  evidence, SRP test, new-reader names, trait boundary, template threshold).
- 0.9.0 — Audit fixes: 6 confirmed blockers (intake scales, KISS/seams,
  scope/cleanup, ceiling boundary, version gates, upload units), fixed
  examples, 5 quality gaps (concurrency, dependencies, anti-flaky, API
  evolution, UX budgets), dedup.

## 0.8.0

- Classification rubrics, context domains + triggers, incident operation,
  product discovery, phase contracts, work-item fields.

## 0.7.0

- Generalist turn: working profiles, orchestration, AI governance,
  interaction/uncertainty, project instantiation, release, derived/effective
  routing, preflight gate.

## 0.6.0

- Artifact templates, agent communication, architecture decisions,
  module docs, context budgets, structural navigation.

## 0.5.0

- SOLID with examples, modern PHP catalog, Laravel specifics, anti-patterns,
  Vue frontend, API contracts, intake front-door, delivery stages.

## 0.4.0

- Full en-US rewrite; strict quality gates with counting rules and
  `[BLOCKING]`/`[TARGET]` severities in the review checklist.

## 0.3.0

- Complete guide: patterns, quality gates, conventions, security, testing,
  workflow, review checklist.

## 0.2.0

- Independent rewrite (no source-package references); style/security/workflow
  guides.

## 0.1.0

- Initial internal skill.
