# Architecture and design patterns

Boundaries and patterns for Laravel/PHP backends and Vue/TS frontends.

## Layer boundaries (backend)

- Controller: takes validated input, authorizes, calls one service, maps the
  response. No business rules, no queries, no inline validation.
- Service: owns rules and orchestrates repositories/transactions/collaborators.
  Constructor dependencies (`private readonly`), one clear responsibility.
- Repository: owns query composition and persistence details, exposed via interface.
- FormRequest: owns HTTP validation (rules + messages); injected into the controller.
- Resource: owns response shape; persistence models never leak into serialization.
- Never introduce a new pattern without a concrete need recorded in the spec.

## Finite state machines

- Entities with lifecycles (status + transitions + actions) use declarative
  workflow configuration + a domain service that computes available actions,
  applies transitions, and records history.
- Frontends render from API-provided available actions; never hardcode valid
  transitions in templates.

## Authorization

- Permission middleware + policies + service checks must agree on the same
  route contract; exceptions (public route, heartbeat) are documented in the
  contract — a generic checklist never vetoes a documented exception.

## Auditing and soft-deletes

- Sensitive models: soft-delete + audit trail (who, what, when). Retention and
  immutability defined in the spec.

## Exceptions

- Catch specific types; never a broad catch without rethrowing/wrapping with
  the preserved cause (`previous`). No empty catches, no `@`, no swallowing
  failures with `return false` without justification.
- Consistency failures with domain meaning become typed domain exceptions +
  unit tests, not generic runtime exceptions.

## Queries and persistence

- No N+1, no queries in loops, no `select *`: eager loading, explicit selects,
  `chunk`/`cursor`/`lazy` for volume.
- Related writes in transactions; every listing endpoint paginates — never
  unbounded result sets; cache repeated/heavy reads.
- Backward-compatible migrations (nullable or default); new/altered columns
  carry `comment` (purpose + domain/values + nullability/rule).

## Collections and nulls

- Collection for transformation pipelines; `foreach` for plain iteration,
  critical performance, or focused mutation. No `map/filter/reduce` chains
  where one loop suffices.
- Nulls in order: `??`, `??=`, `?->`, framework safe access; no `isset` chains
  or giant `$o && $o->x` guards. Missing required data never becomes a silent
  valid-looking fallback.

## Frontend

- Components present and orchestrate (props, emits, loading, error); reusable
  rules and state live in services, composables, or domain types.
- Reuse an existing component before creating one; readable templates with
  `computed`, no extensive inline logic.

## Compatibility

- Contract changes break no existing implementation: new parameters defaulted,
  compatible migrations, conflict-free new routes.
- Booleans switching a whole method behavior are forbidden: split operations
  or use a closed typed variant.
