# Modern PHP (8.1+)

Use when the project's PHP version supports the feature; record the version in
project context. Each item: what + minimal example.

## Immutability

```php
final class InvoiceService
{
    public function __construct(
        private readonly InvoiceRepositoryInterface $invoices,
        private readonly Notifier $notifier,
    ) {}
}
```

`final` on every concrete class (`abstract` only with documented reason); `readonly` properties and `readonly` classes for
value-like objects; constructor promotion for all injected dependencies.

## Dispatch and domain values

```php
// match instead of elseif chains
$status = match ($code) {
    200, 201 => 'ok',
    404 => 'missing',
    default => 'error',
};

// backed enums for closed sets
enum InvoiceStatus: string { case Draft = 'draft'; case Issued = 'issued'; }

// never for methods that always throw
function actionNeverReturns(): never { throw new DomainException('...'); }
```

`#[Override]` on every override; typed constants (`private const string`) when
supported; property hooks for access logic on DTOs/value objects.

## Arguments and arrays

```php
// named arguments for 3+ params
search(status: $status, limit: 50);

// spread instead of array_merge for compatible keys
$all = [...$a, ...$b];

// array_any / array_all / array_find instead of manual loops
$hasOverdue = array_any($invoices, fn ($i) => $i->overdue);

// json_validate instead of decode + error check
if (!json_validate($payload)) { throw new ValidationException('payload'); }
```

Prefer `??`/`??=` for defaults, `data_get()`/`Arr::only()`/`Arr::except()`
for read/compose; `unset()` only when removal is the clearest intent.

## Text and encoding

`mb_*` (`mb_trim`, `mb_strlen`, `mb_strtolower`) for multibyte safety;
`sprintf()` or `"... {$var}..."` for assembly — never `.` concatenation.
