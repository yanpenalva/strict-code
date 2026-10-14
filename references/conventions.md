# Conventions

## Naming

| Layer | Standard | Example |
|---|---|---|
| Classes, interfaces | PascalCase | `InvoiceService`, `InvoiceRepositoryInterface` |
| Methods, functions, vars | camelCase | `issueInvoice`, `dueDate` |
| Constants | SCREAMING_SNAKE_CASE, typed when possible | `MAX_ITEMS` |
| Columns and tables | snake_case (plural tables) | `due_date`, `invoice_status_histories` |
| Vue components (file + template) | PascalCase | `InvoiceList.vue` |
| Global front constants/enums | SCREAMING_SNAKE_CASE or PascalCase | `SCREENS`, `ACTIONS` |

Generic names (`$data`, `$x`, `get()`, `process()`) fail review — names
carry intent. Exception: `$q`/`$query` in `when()` closures. Class
properties: camelCase internally, snake_case for DB mapping.

## Commits

Format: `type: description` or `type(scope): description`. Types: `build`,
`chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`.
Messages validated in the `commit-msg` hook (commitlint).

## Hooks (recommended)

- `pre-commit`: lint-staged (ESLint with autofix on front, Pint on back).
- `pre-push`: changed-file quality check + front typecheck when applicable +
  focused back PHPStan/tests. Full suites only on dependency or runner changes.

## Reference toolchain

| Area | Tool | Role |
|---|---|---|
| PHP formatting | Pint (PSR-12/Laravel) | format |
| PHP analysis | PHPStan/Larastan (+ baseline for existing debt) | types/bugs |
| PHP tests | PHPUnit/ParaTest | unit/integration |
| Front lint | ESLint | style/practices |
| Front format | Prettier | formatting |
| Front tests | Vitest (+ coverage) | unit/component |

## Modern PHP (use when the project version supports it)

- `final class` by default; `private readonly` + constructor promotion;
  `match` over `elseif`; backed enums for closed sets; `#[Override]`; typed
  constants; `array_find/any/all`; `json_validate()`; `mb_*`; named arguments
  (3+ params); spread `[...$a, ...$b]` for merges; `Response::HTTP_*` instead
  of magic numbers; `when()` on queries/collections.
- `extract()`, `$$var`, `goto`, `&$var` references without justification: forbidden.
- Always `===`/`!==`; money never as float (minor-unit integer or decimal string).

## JS/TS/Vue

- `const` by default, `let` only with reassignment, never `var`; `===`, `??`, `?.`.
- TS: no `any` (precise type or `unknown`), no non-null `!`, strict null checks,
  `satisfies` to narrow literals; `async/await`, no promise hell.
- Vue: Composition API + `<script setup lang="ts">`; typed props/emits;
  `:key` on every `v-for`; no prop mutation; no `v-html` with unsanitized
  content; deep watchers only with reason.

## Migrations

- Backward compatible; `change()` redeclares the full definition + `comment`.
- `->comment()`: purpose + domain/values + nullability/rule.

## Official documentation

- Unknown type/function/feature: consult official docs (via Context7 when
  available) before implementing; if stale, complement with current official
  docs in the browser. Packages: repository/packagist.
