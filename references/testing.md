# Test strategy

The smallest set proving the changed behavior + the area's required regression.

## Layers

| Layer | Typical location | Use |
|---|---|---|
| Service | `tests/Unit/Services/` | business rules with interface doubles |
| Repository | `tests/Unit/Repositories/` | queries/persistence against test DB |
| Controller | `tests/Unit/Http/Controllers/` | delegation and response mapping |
| FormRequest | `tests/Unit/Http/Requests/` | rules through the real validator (local stub for injection) |
| Model | `tests/Unit/Models/` | relations, casts, fillable, soft-delete |
| Feature HTTP | `tests/Feature/` | routes, middleware, authZ, serialization |
| Feature console | `tests/Feature/Console/` | command: output, exit code, side effects |
| Frontend | `*.spec.ts` next to source | component/composable/service with mocked HTTP |

Authorization/route changes need feature tests; service rules need focused unit.

## Anatomy per layer

- **Service:** mock the repository interface, constructor injection, one
  behavior per test including failure paths.
- **Repository:** DB refresh + factories + real persistence; assert result and state.
- **Controller:** mock the service, local FormRequest stub, assert mapping.
- **FormRequest:** real request, `rules()` through the validator: valid,
  missing, wrong type, nullable.
- **Feature HTTP:** through the route when middleware/permission/status/
  serialization are the contract; auth and authZ asserted separately.

## Conventions

- Test names = behavior + scenario; specific assertions (`assertSame`,
  `assertCount`, `assertDatabaseHas`, HTTP status asserts).
- Success + auth/validation failures + relevant edges; never test private
  methods directly.
- Factories and states over hand-built models; never mock Eloquent when
  behavior depends on persistence.
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

- Framework behavior (trivial getters/setters), privates in isolation, config
  outside scope, the whole suite for a localized change.
- Exception: when a route, config, or integration IS the changed contract or
  the likely regression boundary.

## Completion record

Every final report states: focused + regression tests run; static
analysis/format/typecheck/lint run; environment/container; pass/fail with
asserts/coverage; pre-existing or pending failures.
