# Review checklist

Mandatory before opening a PR or calling a task done. Mark each item.
`[BLOCKING]` fails the review; `[TARGET]` guides it.

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

- [ ] No changed production file contains `else`, `elseif`, `v-else`, `v-else-if`?
- [ ] Directly-relevant pre-existing branches in touched code refactored preserving order and side effects; wider cleanup split into its own task?

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
- [ ] `#[Override]` on overrides; property hooks or dedicated methods for get/set?
- [ ] Array search via `array_find/any/all` (PHP ≥8.4 or project-version equivalent); JSON via `json_validate()` (PHP ≥8.3)?
- [ ] Sparse comments (non-obvious decisions only); PHPDoc for typing/analysis?

## 7. SOLID / Clean `[BLOCKING]`

- [ ] Single responsibility — clear reason to change?
- [ ] Dependency injection — no `new` in services?
- [ ] Abstraction level — controller orchestrates, service rules, repository
  queries; `final class` by default?
- [ ] No method above its ceiling without same-task decomposition?

## 8. Static analysis `[BLOCKING]`

- [ ] PHPStan/linters pass with no errors on the changed scope?
- [ ] No unused variable/import, excess returns, or over-ceiling complexity?
- [ ] HTTP responses use `HTTP_*` constants, never magic numbers?

## 9. Tests `[BLOCKING]`

- [ ] Unit tests cover changed service/controller methods?
- [ ] Authorization tests (401/403) included?
- [ ] Feature tests cover new endpoints?
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
