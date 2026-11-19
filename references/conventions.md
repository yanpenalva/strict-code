# Conventions

## Naming

Naming: `style.md` is the sole owner (including generic-name bans, casing, and
language). Database: plural snake_case tables; snake_case columns; FK
`<singular>_id`; indexes `idx_<table>_<columns>`, unique `uq_<table>_<columns>`,
foreign keys `fk_<table>_<column>`, checks `ck_<table>_<rule>`; column `comment`
per migrations below.

## Commits

Conventional Commits, always: `type: description` or `type(scope): description`;
breaking commits add `!` (`type!:`, `type(scope)!:`) plus a `BREAKING CHANGE:`
footer naming the migration. Types: `build`, `chore`, `ci`, `docs`, `feat`,
`fix`, `perf`, `refactor`, `revert`, `style`, `test`. Type and scope stay en-US
and lowercase; the description follows the language rule below.

Description language: choose once per change, from the working conversation —
pt-BR only when that conversation is clearly pt-BR, otherwise en-US. With no
usable conversation signal (an agent working from a spec alone), follow the
repository's recent history. Keep the choice for every commit of the change;
never mix languages within one change, and never translate the type or scope.

Subject: imperative, ≤72 characters, no trailing period. Body wrapped at 72
when present.

## Hooks

- `commit-msg` (required): Conventional Commits via commitlint or an equivalent
  check. A failing message blocks the commit. Shipped reference configs:
  `templates/commitlint.config.js`, `templates/.editorconfig`,
  `templates/hooks/commit-msg`.
- `pre-commit` (recommended): lint-staged (ESLint with autofix on front, Pint on
  back).
- `pre-push` (recommended): changed-file quality check + front typecheck when
  applicable + focused back PHPStan/tests. Full suites only on dependency or
  runner changes.

Local hooks never replace a required check; CI enforces the same gates. Git
finalization and PR authority: `orchestration.md`.

## Reference toolchain

| Area | Tool | Role |
|---|---|---|
| PHP formatting | Pint (PSR-12/Laravel) | format |
| PHP analysis | PHPStan/Larastan (+ baseline for existing debt) | types/bugs |
| PHP tests | PHPUnit/ParaTest | unit/integration |
| Front lint | ESLint | style/practices |
| Front format | Prettier | formatting |
| Front tests | Vitest (+ coverage) | unit/component |

## Dependencies

- Lockfile committed; production installs from it (`npm ci`, `composer install --no-dev`), never a floating range.
- A new dependency needs one line of justification in the change: what the platform or an existing package does not provide.
- Audit before release; a known exploited vulnerability in the changed area blocks until upgraded or an approved exception records the exposure.
- Framework majors and bulk upgrades are their own change — never mixed with behavior work.

## Modern PHP (full catalog in `modern-php.md`; project version gates every feature)

Kept here (not duplicated elsewhere):
- Comparisons always `===`/`!==`. (Hard prohibitions — `extract()`, `$$var`, `goto`, float money — live in `security.md`; not repeated here.)

## JS/TS/Vue (full rules in `frontend.md` and `style.md`; not duplicated here)

## Migrations

- Backward compatible; `change()` redeclares the full definition + `comment`.
- `->comment()`: purpose + domain/values + nullability/rule.

## Official documentation

- Unknown type/function/feature: consult official docs (via Context7 when
  available) before implementing; if stale, complement with current official
  docs in the browser. Packages: repository/packagist.
