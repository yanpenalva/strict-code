# Changelog

All notable changes to the `strict-code` skill. Versions below 1.0.0 are
development iterations; 1.0.0 is the first stable release.

## 1.5.0

Standardization and mechanization pass.

- Naming completed: enum cases, file names (kebab-case), Vue component files,
  branch names (`type/kebab-slug`), acronym spelling (`Id`/`Url`), abbreviation
  bans, booleans as predicates, plural collections, unit suffixes, `At`
  timestamps in UTC, `On` dates.
- Database naming: plural snake_case tables, `<singular>_id` foreign keys, and
  `idx_`/`uq_`/`fk_`/`ck_` object prefixes (`conventions.md`).
- Translation keys (`<domain>.<context>.<element>`) and stable snake_case
  client error codes (`errors.code`), documented per endpoint, never renumbered
  or reused (`api-contracts.md`).
- Severity scale `blocking`/`major`/`minor`/`nit` with closure criteria; the
  delivery review record grades findings by it.
- Test names state behavior + scenario, no ticket numbers.
- Dependencies: committed lockfile, installs from the lock, one-line
  justification for new packages, audit gate before release, upgrades as their
  own change.
- Mechanization: `bin/strict-code check` plus a CI workflow validate that
  references resolve, every guide is reachable from `SKILL.md`, the frontmatter
  version matches the changelog, JSON examples parse, and RIGHT examples
  contain no banned branch.
- Shipped reference configs: `templates/commitlint.config.js`,
  `templates/.editorconfig`, `templates/hooks/commit-msg`.

## 1.4.0

Language rule made normative, plus ambiguity hardening.

- Language: en-US for every artifact (identifiers, files, branches, comments,
  tests, logs, config keys, technical docs). Client-visible text — API
  messages, UI strings, validation messages, notification/e-mail copy — is a
  project decision taken at intake and recorded in the project profile; when no
  decision exists, ask before implementing. One locale per surface, strings in
  translation resources, ASCII identifiers. `style.md` owns the rule.
- Commits: Conventional Commits always, required `commit-msg`; type and scope
  stay en-US, description language follows the working conversation (en-US
  default, pt-BR when that is the working language), never mixed within one
  change. Subject/body/breaking-change shape defined in `conventions.md`.
- Review: items recorded `PASS`/`FAIL`/`NOT RUN`/`N/A` with evidence, approval
  only when every applicable blocking item passes; command evidence must cover
  the reviewed revision and scope.
- Closed verdict ambiguities: alternate-branch syntax and legacy scope;
  formatter vs interpolation and URL encoding; envelope body rules, 400 vs 422,
  whitelist miss → 500; ceiling counting (only above the ceiling fails,
  promoted/variadic parameters, callback returns); measurement scope with
  deletions and consumers; blocking vs advisory new-code targets; security
  waiver process and cross-tenant proof; validate-and-review on the final diff,
  re-review after adjust, Release/Observe N/A; derived-depth changes and risk
  thresholds; core-vs-stack rule scope; automatic PR approval.
- De-duplicated the 15-method ceiling out of `patterns.md`.
- 1.3.0 and 1.3.1 were released without changelog entries; their content is in
  git history (`git log v1.3.1`).

## 1.2.2

Consumer-mode boundary patch; `SKILL.md` keeps `1.2.1` until
`bin/strict-code release 1.2.2`.

- Scope narrowed to engineering criteria; the skill consumes an external
  workflow owner's classification, approved spec, architecture, plan, and check
  evidence instead of reclassifying or restating them.
- Lifecycle guides labelled standalone-only or consumer-mode; external specs
  and engineering sources are path/URL/id pointers with owner and revision;
  ai-memory is continuity-only in `references/delivery.md`.
- Preserved: all guides, MUSTs, axes, routing, gates, standalone behavior; no new file, no tag.

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
