---
name: strict-code
description: Use when writing or reviewing code for Yan's projects.
version: 0.8.0
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

- Write, refactor, or review code in any language (agnostic core rules); PHP/Laravel and TypeScript/Vue have dedicated stack guides.
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
  in FormRequest, shape in Resource (`patterns.md`, `laravel.md`).
- SOLID with one reason to change per class; no god services (`solid.md`,
  `anti-patterns.md`).
- Sanitized logs; authorization follows the route's explicit contract (`security.md`).
- Every behavior change gets a focused test; 80% target on new code
  (`testing.md`, `workflow.md`).
- API responses follow the standard envelope with semantic status codes
  (`api-contracts.md`).
- Conventional Commits + hooks; merge/PR only with explicit approval (`conventions.md`).
- Work enters through intake/classification/routing before specifying (`intake.md`)
  and flows through the delivery stages to a criteria-checked close (`delivery.md`).
- Reviews close with `file:line` + severity + verdict (`review-checklist.md`).
- One primary working profile per task; classification, routing, and
authorization stay separate decisions (`profiles.md`).
- Multi-agent work uses named assignments with least privilege; production
  and irreversible actions stay human (`orchestration.md`, `governance.md`).
- Claims carry epistemic state (known/inferred/unknown/not found); questions
  only for decision-changing gaps (`interaction.md`).
- Each project instantiates a profile: stack, commands, thresholds, owners
  (`project-profile.md`); releases carry approver, smoke, observation, and
  rollback (`release.md`).

## Guides

| Need | Read |
|---|---|
| Style, typing, naming | `references/style.md` |
| SOLID with examples | `references/solid.md` |
| Modern PHP features | `references/modern-php.md` |
| Laravel specifics | `references/laravel.md` |
| Anti-patterns and fixes | `references/anti-patterns.md` |
| Layer patterns, queries, exceptions, compat | `references/patterns.md` |
| Numeric gates, Sonar, hotspots | `references/quality-gates.md` |
| Commits, hooks, toolchain, migrations | `references/conventions.md` |
| Security and privacy | `references/security.md` |
| API envelope, status codes, masking | `references/api-contracts.md` |
| Test strategy and anatomy | `references/testing.md` |
| Vue frontend specifics | `references/frontend.md` |
| Intake, classification, routing | `references/intake.md` |
| Delivery stages and closing | `references/delivery.md` |
| Work process summary | `references/workflow.md` |
| Review checklist | `references/review-checklist.md` |
| Artifact templates | `references/artifact-templates.md` |
| Agent communication | `references/agent-comms.md` |
| Architecture decisions | `references/architecture-decisions.md` |
| Module documentation | `references/module-docs.md` |
| Working profiles | `references/profiles.md` |
| Multi-agent orchestration | `references/orchestration.md` |
| AI governance | `references/governance.md` |
| Interaction and uncertainty | `references/interaction.md` |
| Project instantiation | `references/project-profile.md` |
| Release and observation | `references/release.md` |
| Classification rubrics | `references/classification.md` |
| Context domains and triggers | `references/domains.md` |
| Incident and hotfix operation | `references/incident.md` |
| Product discovery | `references/discovery.md` |

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
