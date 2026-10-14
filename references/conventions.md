# Conventions

## Naming

Naming follows `style.md` (PascalCase classes/components, camelCase members, SCREAMING_SNAKE_CASE constants, snake_case data). Database additions: plural snake_case tables; property casing follows mapping (camelCase internal, snake_case DB).

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

## Modern PHP (full catalog in `modern-php.md`; project version gates every feature)

Kept here (not duplicated elsewhere):
- `extract()`, `$$var`, `goto`, `&$var` references without justification: forbidden.
- Always `===`/`!==`; money never as float (minor-unit integer or decimal string).

## JS/TS/Vue (full rules in `frontend.md` and `style.md`; not duplicated here)

## Migrations

- Backward compatible; `change()` redeclares the full definition + `comment`.
- `->comment()`: purpose + domain/values + nullability/rule.

## Official documentation

- Unknown type/function/feature: consult official docs (via Context7 when
  available) before implementing; if stale, complement with current official
  docs in the browser. Packages: repository/packagist.
