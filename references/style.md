# Style guide

Writing rules in detail: pattern, anti-pattern, and why.

## KISS / YAGNI

- Implement only approved behavior; speculative abstraction for a single hypothetical case waits for the second real case. Structural seams required by layering (service/repository interfaces) are architecture, not speculation.
- Delete dead code in the task that reveals it; nothing "for the future".
- Extract an abstraction only for real repetition of one-owned rules — never to
  lower a metric; no trivial wrappers or fragmented files to dodge ceilings.

## No `else` / `elseif`

Linear flow with early exits. Applies to every language in scope and to any
alternate-branch syntax: `else`, `else if`, `elseif`, `elif`, `v-else`,
`v-else-if`. Bring an existing conditional into compliance when this diff
changes its condition or a branch's behavior, preserving evaluation order and
side effects; unrelated legacy conditionals stay out of scope and get their own
task.

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

Never nest calls inside conditions: assign to a named variable first, then branch.

```php
// WRONG — nested call inside the condition
if ($this->repository->find($id)->isActive()) {
    ...
}

// RIGHT — named variable, then branch
$model = $this->repository->find($id);
if ($model->isActive()) {
    ...
}
```

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

Exception messages, logs, translation keys, array keys: interpolation. Where the
language has no interpolation, or explicit formatting is required, use its
standard formatter (`sprintf`, `format!`) — never `.`/`+` chains. URLs: use the
framework's URL builder, or encode each dynamic component for its position;
never paste raw input into a path. SQL: always parameter binding —
interpolating a value into SQL is a security failure, not a style one.

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
- Every concrete PHP class is `final`; inheritance only via `abstract` base with documented reason — non-final concrete fails review.

## Language

Default is en-US for everything the engineer or agent writes: identifiers, file
and directory names, branches, comments, test names, log and internal error
text, configuration keys, and technical documentation. Code serving a pt-BR
product is still en-US; only the surfaces below carry another locale.

Client-visible text — API messages returned to the user, UI strings,
validation messages rendered in the interface, notification and e-mail copy —
is a project decision, never an assumption. Decide the locale at intake, or in
the approved spec when an external workflow owner exists, before the first line
of the feature, and record it in the project profile
(`project-profile.md`): en-US, pt-BR, or another. When a client-visible surface
has no recorded decision, ask before implementing; the conversation language is
not the decision.

Holds for every locale:
- One locale per surface; never mix languages in the same response, screen, or
  message set. Product copy and technical text (logs, internal errors) are
  different surfaces.
- Client-visible strings live in translation resources, never hardcoded in
  domain logic, services, or components.
- Translation keys: `<domain>.<context>.<element>`, lowercase dotted
  (`invoice.list.empty_state`), en-US even when the copy is pt-BR; a key is a
  stable contract, renamed only together with its resource in the same change.
- Identifiers the project controls are ASCII and unaccented, including
  Portuguese domain terms (`certidao`, not `certidão`); externally imposed names
  keep their spelling and get an ASCII local alias.
- Commit description language follows `conventions.md`; type and scope stay
  en-US.

## Naming

| Layer | Standard | Example |
|---|---|---|
| Classes, components | PascalCase | `InvoiceService`, `UserCard` |
| Methods, vars, functions | camelCase | `issueInvoice`, `dueDate` |
| Constants | SCREAMING_SNAKE_CASE, typed | `MAX_ITEMS` |
| Enum cases | PascalCase; backed value snake_case | `InvoiceStatus::Issued = 'issued'` |
| Files (code, docs) | kebab-case | `invoice-service.ts`, `release-checklist` |
| Vue components | PascalCase file, name matches | `UserCard.vue` |
| Branches | `type/kebab-slug` | `feat/invoice-issue` |
| Database, payloads | snake_case | `due_date`, `customer_id` |

Names reveal intent (`activeLoans`, not `data2`/`$x`/`get()`); domain terms use
the business's vocabulary, technical terms stay en-US. New-reader test: a
reader seeing only the name must assign the right domain meaning without
opening the body or needing a comment; banned generic names (`$data`, `$x`,
`$tmp`, `$res`, `get()`, `process()`) fail automatically.

Apply the casing table to names the project controls. Preserve exact spelling
for names imposed by the language, framework protocol, vendor schema, or an
existing public contract — adapt with a local alias, and rename a public field
only through the compatibility process in `api-contracts.md`.

Acronyms keep one spelling per identifier: `Id`, `Url`, `Api` inside camelCase
and PascalCase (`userId`, `UserId`, `ApiClient`); SCREAMING_SNAKE constants may
use `ID`, `URL`, `API`. Do not invent abbreviations (`inv`, `amt`, `qty`); the
standard short forms (`id`, `url`, `http`, `api`, `db`, `ui`) are allowed.

Booleans read as predicates (`isActive`, `hasAccess`, `canRetry`) — `active`
names a state, not a boolean. Collections are plural (`invoices`,
`activeLoans`). Units belong to the name when the type does not carry them:
`timeoutMs`, `sizeBytes`, `amountCents` (money is an integer in minor units).
Timestamps end in `At` and are UTC (`createdAt`, `dueAt`); dates without a time
end in `On` (`issuedOn`). A duration is never a bare `timeout` or `time`.

## Size limits

Full table, counting rules, and enforcement in `quality-gates.md`. Summary:
500 lines/file, 15 declared methods/functions, 150 lines/method, 3 returns —
blocking. Target <30 lines; extraction candidate >50.

## Comments

- Production: no narrative comments — code must read without them; a needed
  explanation means the name or structure failed, rename first.
- Only type-level annotations (PHPDoc generics/collections/complex arrays)
  where the language cannot express the type. AI narration removed before merge.
