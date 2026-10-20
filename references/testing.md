# Test strategy

The smallest set proving the changed behavior + the area's required regression.

## Layers

| Layer | Typical location | Use |
|---|---|---|
| Service | `tests/Unit/Services/` | business rules with In-Memory fakes of repository interfaces |
| Repository | `tests/Unit/Repositories/` | concrete persistence against test DB — classified as integration |
| Controller | `tests/Unit/Http/Controllers/` | delegation and response mapping |
| FormRequest | `tests/Unit/Http/Requests/` | rules through the real validator (local stub for injection) |
| Model | `tests/Unit/Models/` | relations, casts, fillable, soft-delete |
| Feature HTTP | `tests/Feature/` | routes, middleware, authZ, serialization |
| Feature console | `tests/Feature/Console/` | command: output, exit code, side effects |
| Frontend | `*.spec.ts` next to source | component/composable/service with mocked HTTP |

Order is Unit then Feature: unit locks the business rule in isolation; feature locks wiring (route, middleware, authZ, serialization). No feature compensates missing unit. Test behavior, not language/framework guarantees. A use-case test with fakes is unit, never E2E; a test against a real database is integration, even when executed by PHPUnit/Pest.

## Doubles

| Need | Use |
|---|---|
| Observe state/outcome in service/use-case tests | In-Memory fake — preferred default |
| Interaction is the explicit contract (notify, publish) | Mock/spy on that interaction |
| Controlled canned answer only | Stub |
| Real persistence, queries, transactions, constraints | Integration test vs real DB — never replaced by fakes |

- Fakes implement the production interface (`tests/Fakes/` or project
  equivalent), cover only the operations the tests need with the contract's
  relevant semantics, hold isolated state per test, and stay deterministic.
  No test-only frameworks, no preventive abstractions, no production
  reshaping solely to ease testing (dependencies via constructor injection —
  see `solid.md` DIP).
- No fake when a plain value or the real object suffices. Never assert
  internals without contractual meaning (e.g. call counts nobody promised).
- Shared contract cases over both the fake and the real implementation only
  where equivalence has concrete value.

## Anatomy per layer

- **Service:** In-Memory fake of the repository interface, constructor
  injection, one behavior per test including relevant failure paths.
- **Repository:** DB refresh + factories + real persistence; assert result and state.
- **Controller:** double of the service (fake or stub), local FormRequest stub,
  assert mapping.
- **FormRequest:** real request, `rules()` through the validator: valid,
  missing, wrong type, nullable.
- **Feature HTTP:** through the route when middleware/permission/status/
  serialization are the contract; auth and authZ asserted separately.

## Conventions

- Test names = behavior + scenario; specific assertions (`assertSame`,
  `assertCount`, `assertDatabaseHas`, HTTP status asserts).
- One behavior per test; shared behavior via data providers with explicit
  data — no conditionals inside tests. Cover success, auth/validation
  failures, and risk-relevant edges; never test private class/method
  directly — exercise through the public contract.
- One layer owns each behavior; other layers cover only their own wiring —
  no scenario duplication without concrete benefit.
- Factories and states over hand-built models; never mock Eloquent when
  behavior depends on persistence.
- Test-only fakes stay outside `src/`; In-Memory in production only as a real
  requirement. No universal layout — follow the project convention.
  Language-agnostic rules; framework examples (PHPUnit/Pest) are illustrative.
- Assert observable behavior (result + persisted state), not SQL internals.
- Front: mocked HTTP, no real endpoints, no arbitrary sleeps, no
  timing-dependent asserts.
- Driver-specific queries: cover on the production driver or a meaningful
  equivalent path — never weaken a test to make an incompatible query pass.

## Determinism (anti-flaky)

- Deterministic by default: seeded randomness, controlled clocks, isolated
  parallel state; no real time, network, or shared mutable fixtures.
- Quarantine is proportional and temporary: named owner + expiry + tracking
  issue; retries reported with cause, never silent.

## What not to test by default

- Language/type-system guarantees (param assignment, pass-through getter/setter, trivial constructor): breaks loudly alone, no test.
- Empty or pass-through classes with no branch: no test, add coverage-ignore (`@codeCoverageIgnore`, `istanbul ignore`, `coverage: exclude`) instead of fake tests.
- Private class/method in isolation: cover only via public entry points; privates are refactor-free detail.
- Framework behavior, config outside scope, the whole suite for a localized change.
- Exception: test trivial-looking code only on silent-failure risk (wrong default, bad mapping/normalization, swallowed error); when a route, config, or integration IS the changed contract or the likely regression boundary.
- Cut heuristic: if removing the test lets the bug pass silently (wrong data/charge/access), keep; if it would explode at boot/typecheck, discard.

## Completion record

Focused tests first; expand to integration/regression with technical
justification. Gates live in `quality-gates.md`. Every final report states:
focused + regression tests run; static analysis/format/typecheck/lint run;
environment/container; pass/fail with asserts/coverage; pre-existing or
pending failures.
