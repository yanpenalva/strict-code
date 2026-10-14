---
name: strict-code
description: Use when writing or reviewing code for Yan's projects.
version: 0.4.0
author: Yan Penalva, Hermes Agent
license: MIT
platforms: [linux, macos, windows]
metadata:
  hermes:
    tags: [Code-Quality, Security, Conventions]
    related_skills: [requesting-code-review]
---

# Code Standards

Mandatory code writing and review standards. They apply to every project
unless the work spec records an exception.

## When to Use

- Write, refactor, or review PHP/Laravel and TypeScript/JavaScript/Vue code.
- Pull requests, tests, migrations, commits, code audits.
- Do not use for: documentation without code; product decisions (humans decide).

## Principles

- KISS/YAGNI: the smallest working solution. No speculative abstraction, no
  dead code, no behavior outside the approved scope.
- Small, localized, reversible changes. No opportunistic refactoring outside scope.
- Record unknowns as `NOT FOUND`; never invent requirements, contracts, or evidence.
- Never claim validation or success without running the corresponding command.

## Core rules

- No `else`, `elseif`, `v-else`, `v-else-if`: guard clauses, early return,
  `match`, `computed`, or equivalent linear flow (`style.md`).
- Strings via interpolation; SQL only with parameter binding (`style.md`).
- Namespaced PHP imports natives with `use function <name>;` (`style.md`).
- Full typing + `strict_types = 1`; enums for closed sets (`style.md`).
- Blocking ceilings: 500 lines/file, 15 declared methods/functions, 150
  lines/method, 3 returns, 7 params, cyclomatic ≤10 / cognitive ≤15
  (`quality-gates.md`). Target: <30 lines; extraction candidate >50.
- Layers: thin controller, rules in service, queries in repository, validation
  in FormRequest, shape in Resource (`patterns.md`).
- Sanitized logs; authorization follows the route's explicit contract (`security.md`).
- Every behavior change gets a focused test; 80% target on new code
  (`testing.md`, `workflow.md`).
- Conventional Commits + hooks; merge/PR only with explicit approval (`conventions.md`).
- Reviews close with `file:line` + severity + verdict (`review-checklist.md`).

## Guides

| Need | Read |
|---|---|
| Style, typing, naming, limits | `references/style.md` |
| Layer patterns, queries, exceptions, compat | `references/patterns.md` |
| Numeric gates, Sonar, hotspots | `references/quality-gates.md` |
| Commits, hooks, toolchain, migrations | `references/conventions.md` |
| Security and privacy | `references/security.md` |
| Test strategy and anatomy | `references/testing.md` |
| Work process | `references/workflow.md` |
| Review checklist | `references/review-checklist.md` |

## Pitfalls

- A docs-only slice missing executables/CI is a slice limitation, not a
  standard failure; contradictions between present documents are real failures.
- CI `allow_failure: true` never waives a green review gate.
- Context-manifest validation never proves code quality.
- Stale spec vs manifest: synchronize the spec.
- Analyzer suppressions (`NOSONAR` or equivalent) only with a technical reason
  + work reference; review old suppressions.

## Verification

- Gates run on the changed scope, with command, result, and affected coverage.
- Deliveries cite `file:line` per finding and close with a verdict + count
  (blocking / non-blocking).
