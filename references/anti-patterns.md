# Anti-patterns catalog

Each entry: smell → rule → fix. Flag in review with `file:line`.

## 1. Queries outside repositories `[BLOCKING]`

Raw queries or `DB::` calls in controllers, services, or helpers. Rule: ALL
persistence lives in repositories; services call repositories. Fix: move the
query behind a repository interface method. Controllers call services only — never direct queries.

## 2. God service `[BLOCKING]`

Service past its ceilings doing orchestration + validation + history +
export. Fix by splitting along verbs: `<Domain>Service` (orchestration),
`<Domain>Validator` (rules), `<Domain>HistoryRecorder` (trail),
`<Domain>Exporter` (files) — each under the ceilings, each tested.

## 3. Duplicated permission checks `[TARGET]`

Same admin/owner check pasted across methods. Fix: one shared predicate — a
focused trait, base method, or policy — called everywhere, tested once.

## 4. Repeated unauthenticated handling `[TARGET]`

Identical 401 throws in dozens of methods. Fix: single `requireUser()` guard
(trust the middleware first; the guard covers service-entry misuse).

## 5. Fat traits `[TARGET]`

Traits carrying complex business logic. Boundary: a trait is stateless, holds
at most 3 small methods, owns no domain rule, performs no I/O. Anything past
that boundary is a service or collaborator. Rule: traits hold small reusable
mechanics only; business logic lives in services.

## 6. Missing relationships `[TARGET]`

FK without its Eloquent relation. Rule: every FK declares the relation —
enables eager loading and documents the graph.

## 7. Service without interface `[BLOCKING]`

Public service with no interface. Rule: every public service has one —
enables constructor injection of abstractions and test doubles (DIP).
