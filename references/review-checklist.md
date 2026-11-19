# Review checklist

Mandatory before opening a PR or calling a task done. Mark each item `PASS`,
`FAIL`, `NOT RUN`, or `N/A` — `PASS` needs evidence, `N/A` needs a reason.
`[BLOCKING]` fails the review; `[TARGET]` guides it. Approve only when every
applicable blocking item passes or carries an approved, scoped exception;
otherwise the verdict is `CHANGES`. Command evidence names the command,
environment, reviewed revision/diff, scope, and result, and counts only when it
covers that same revision and scope.

## Severity

- `blocking` — violates a blocking rule, or breaks behavior, data, or security;
  no approval until fixed.
- `major` — material defect or risk outside the blocking set; fixed before
  release.
- `minor` — contained improvement; next cycle.
- `nit` — preference; never blocks and is never recorded as debt.

A finding carries rule, `file:line`, evidence, impact, and severity. The verdict
counts blocking and non-blocking findings separately.

## 1. Guard clauses `[BLOCKING]`

```php
// RIGHT — edge cases on top, happy path last
public function history(int $id): array
{
    if ($id <= 0) {
        throw new HttpException(Response::HTTP_UNPROCESSABLE_ENTITY, 'Invalid ID.');
    }
    $model = $this->repository->findOrFail($id);
    $this->authorize('view', $model);
    return $this->repository->history($id);
}
```

- [ ] Every method starts with guard clauses for edge cases?
- [ ] Happy path is the last `return`, with no `else`?

## 2. Functional queries `[TARGET]`

```php
// RIGHT — chaining without if/else
$query
    ->when($filters['status'] ?? null, fn ($q, $v) => $q->where('status', $v))
    ->when($filters['from'] ?? null, fn ($q, $v) => $q->whereDate('created_at', '>=', $v));
```

- [ ] Query/collection conditionals use `when()` instead of `if`?
- [ ] Text search uses the driver's case-insensitive operator when supported?

## 3. No `else` `[BLOCKING]`

- [ ] No new alternate branch in any syntax (`else`, `else if`, `elseif`, `elif`, `v-else`, `v-else-if`)?
- [ ] Conditionals whose condition or branch behavior this diff changes brought into compliance, preserving order and side effects; unrelated legacy left for its own task?

## 4. Performance and composition `[TARGET]`

- [ ] Performance evidenced, not asserted: query counts within profile budget, listing endpoints paginated, N+1 covered by a failing-without-eager test, repeated/heavy reads cached or justified uncached?
- [ ] `unset()` avoided where safe accessors/slicing/mapping resolve without
  needless mutation?
- [ ] `Collection` only where the pipeline reads better; `foreach` elsewhere?
- [ ] `??`/`??=` for simple defaults without hiding business rules?

## 5. Names `[BLOCKING]`

- [ ] Names self-document (`$activeAnalysts`, not `$data`/`$x`/`$tmp`)?
- [ ] Methods reveal intent (`getHistoryById`, not `get`/`process`)?
- [ ] No explanatory comment where the name already communicates?

## 6. Strict typing `[BLOCKING]`

- [ ] `declare(strict_types = 1)` on top of PHP files?
- [ ] Every parameter, return, and property typed; `readonly` where immutable?
- [ ] `#[Override]` where the project's minimum supported PHP provides it; property hooks only where supported and access logic exists, dedicated methods otherwise?
- [ ] Array search via `array_find/any/all` (PHP ≥8.4 or project-version equivalent); `json_validate()` only when validating without decoding (PHP ≥8.3)?
- [ ] Zero narrative comments; PHPDoc only where the type is inexpressible?

## 7. SOLID / Clean `[BLOCKING]`

- [ ] Single responsibility — clear reason to change?
- [ ] Dependency injection — no `new` in services?
- [ ] Abstraction level — controller orchestrates, service rules, repository
  queries; every concrete PHP class `final` (`abstract` only with documented reason)?
- [ ] No method above its ceiling without same-task decomposition?

## 8. Static analysis `[BLOCKING]`

- [ ] PHPStan/linters pass with no errors on the changed scope?
- [ ] No unused variable/import, excess returns, or over-ceiling complexity?
- [ ] HTTP responses use `HTTP_*` constants, never magic numbers?

## 9. Tests `[BLOCKING]`

- [ ] Every changed behavior has a focused test at the lowest layer that proves its contract — routed feature test for HTTP wiring/middleware, real-database integration for persistence?
- [ ] Authorization tests (401/403) included?
- [ ] Feature tests cover new endpoints?
- [ ] No duplicated unit test for behavior an existing route/integration test already proves; no new test for a behavior-preserving edit without recording why?
- [ ] Focused tests pass; broader regression justified when run?

## 10. Vue frontend `[BLOCKING]`

- [ ] `defineProps`/`defineEmits` typed; `ref`/`reactive` used correctly?
- [ ] No `v-html` with user data; loading/error states handled in template?
- [ ] `<script setup lang="ts">` standard; no direct prop mutation?

## 11. Security `[BLOCKING]`

- [ ] Routes carry auth + permission per contract, including documented exceptions?
- [ ] Validation via FormRequest; queries bound; sensitive data masked?
- [ ] Input, authorization, and output paths reviewed in changed files?

## 12. Compatibility `[BLOCKING]`

- [ ] Contract changes break no existing implementation?
- [ ] New parameters have defaults; migrations backward compatible
  (nullable/default)?
- [ ] New/altered columns carry `comment` (purpose + domain + rule)?
- [ ] New routes conflict with none existing?

## 13. Documentation `[TARGET]`

- [ ] Owning module/domain updated (endpoints, rules, events, configs)?
- [ ] Official docs consulted for non-trivial types/functions?

## 14. Structural navigation `[TARGET]`

- [ ] Impact analysis via structural navigation (call graph/index) before
  broad text search?
- [ ] Findings cite structural evidence, not grep absence?
