# Style guide

Writing rules in detail: pattern, anti-pattern, and why.

## KISS / YAGNI

- Implement only approved behavior; abstraction (interface, parameter, layer)
  enters on the second real case, never before.
- Delete dead code in the task that reveals it; nothing "for the future".
- Extract an abstraction only for real repetition of one-owned rules — never to
  lower a metric; no trivial wrappers or fragmented files to dodge ceilings.

## No `else` / `elseif`

Linear flow with early exits. Applies to PHP, TS/JS, and Vue templates
(`v-else`, `v-else-if` under the same ban).

```php
// WRONG
function status(int $score): string {
    if ($score >= 7) {
        return 'approved';
    } else {
        return 'rejected';
    }
}

// RIGHT
function status(int $score): string {
    if ($score < 7) {
        return 'rejected';
    }
    return 'approved';
}
```

Finite dispatch uses `match`; complex decisions become named predicates or a
dedicated collaborator. Never swap `else` for nested ternaries or `if`
pyramids — at most 3 meaningful levels, target 1.

## Strings: interpolation, never concatenation

```php
// WRONG
$msg = 'User ' . $name . ' created at ' . $date;

// RIGHT
$msg = "User {$name} created at {$date}";
```

```ts
// WRONG
const msg = 'User ' + name + ' created';

// RIGHT
const msg = `User ${name} created`;
```

Exception messages, logs, translation keys, assembled URLs, and array keys:
interpolation. Queries: always parameter binding — interpolating a value into
SQL is a security failure, not a style one.

## Native functions and callbacks

- Namespaced PHP imports natives: `use function sprintf;`,
  `use function in_array;`, `use function count;` (global resolution +
  compiler optimization; no inline `\` prefixes).
- Never `require_once` application config from namespaced production code —
  use the framework's config mechanism.
- Local callbacks/handlers as arrow functions (`fn() =>`, `(x) =>`);
  `function` only where the language/framework requires it.
- Nested ternaries: extract into named statements; redundant parentheses around
  casts/coalescing: remove; unused parameter: remove with its callers.

## Typing

- `declare(strict_types=1);` in every PHP file; typed parameters, returns, and
  properties; `mixed` only with justification; PHPDoc only for generics,
  collections, complex arrays, and inexpressible contracts — never duplicating
  the signature.
- TS/Vue: no `any` (precise type or `unknown`), no `!`, strict null checks,
  `satisfies` for literals; types on public boundaries (props, emits, APIs).
- Closed sets: enum (backed when values exist); otherwise typed constant or
  value object. Never scattered magic numbers/strings.
- Constructor dependencies (`private readonly` + promotion), immutable where
  applicable; statics with dependencies forbidden — inject instead.
- `final class` by default; extension only with a documented reason.

## Naming

| Layer | Standard | Example |
|---|---|---|
| Classes, components | PascalCase | `InvoiceService`, `UserCard` |
| Methods, vars, functions | camelCase | `issueInvoice`, `dueDate` |
| Constants | SCREAMING_SNAKE_CASE, typed | `MAX_ITEMS` |
| Database, payloads | snake_case | `due_date`, `customer_id` |

Names reveal intent (`activeLoans`, not `data2`/`$x`/`get()`); business-domain
language for domain terms, English for technical ones.

## Size limits

Full table, counting rules, and enforcement in `quality-gates.md`. Summary:
500 lines/file, 15 declared methods/functions, 150 lines/method, 3 returns —
blocking. Target <30 lines; extraction candidate >50.

## Comments

- Production: non-obvious decisions only (the why, compatibility constraints).
- PHPDoc where typing/analysis needs it; AI narration removed before merge.
