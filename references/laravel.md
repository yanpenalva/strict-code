# Laravel specifics

Complements `patterns.md` with framework mechanics. Business rules stay in
services; the framework stays at the edges.

## Queries: Eloquent vs Query Builder

- Eloquent for domain reads with relations + eager loading; Query Builder for
  heavy/reporting reads where hydration costs.
- Every FK declares its Eloquent relationship — enables eager loading and
  kills N+1 at the source. Lazy eager loading only as a targeted fix.
- Reusable conditions become local scopes, not copy-pasted `where` chains.
- Frequent/heavy reads: cache (tags where invalidation is per-domain).

## HTTP layer

- FormRequest for ALL HTTP input (rules + messages); Resources for ALL output
  shape; route model binding for `{model}` params.
- Policies for resource authorization; permission middleware for screen/action
  contracts; service-level checks via a helper — all three consistent per route.
- Controllers thin: validate (FormRequest) → authorize → service → Resource.
  Never `DB::` or `Model::query()` in a controller.

## Conventions

- Services behind interfaces (mocks + DIP); providers bind by domain.
- `Response::HTTP_*` constants in every response, including validation errors
  and empty results.
- Shared exception trait: specific exception → mapped status (HttpException →
  its code; NotFound → 404; Validation → 422; Authorization → 403; default →
  500), log with context first, preserve `previous`.
- Formatters/analyzers: Pint on PHP, PHPStan/Larastan for types, PHPUnit (or
  parallel runner) for tests.
