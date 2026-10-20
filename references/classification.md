# Classification rubrics

Score each axis from objective criteria — never from line/file counts alone,
never from urgency (urgency belongs to support type/severity), never from who
does the work.

Consumer mode: with an external workflow owner, these rubrics explain the axes
it records — do not rescore or restart classification from a direct load.
Return engineering risk findings to that owner (`intake.md`).

## Complexity (how hard to do correctly)

| Value | Meaning |
|---|---|
| low | single mechanism, one local behavior, trivially validatable and reversible |
| medium | interacting parts or one non-trivial mechanism; designed tests needed |
| high | cross-cutting behavior, architecture/concurrency/persistence semantics,
integrations, or coordinated multi-wave evidence |

Weigh: change surface (behaviors/contracts, not files), dependencies,
cross-module state, pattern-vs-local edits, concurrency, persistence,
integrations, wave count, reversibility, validation difficulty. One `high`
signal suffices; several `medium` signals mean at least `medium`.

## Impact (blast radius if wrong)

| Value | Meaning |
|---|---|
| local | one function/file/config value; bounded visible failure |
| module | one module/component + direct consumers |
| cross-module | failure propagates across boundaries |
| system | whole system, platform, external consumers, production data |

Weigh: consumers, contracts built upon (APIs/schemas/CLIs/events), shared
data observability, ops/deploy changes, rollback reach. `severity` grades an
ACTIVE incident's observed impact — related but distinct, never copied here.

## Risk + security signal

Root `risk` (low/medium/high/critical) grades consequence × uncertainty of
proceeding. Weigh: auth/authZ, sensitive data, payments, destructive or
irreversible ops, public contracts, infra/availability, data integrity,
rollback difficulty. Humans accept risk — classification never does.

Security signal (switches existing contracts, creates no new rules):

| Value | Meaning | Activates |
|---|---|---|
| none | no auth, data, secret, or trust-boundary surface | nothing |
| relevant | touches auth/sessions, trust boundaries, dependencies/supply chain |
  security analysis in spec + review |
| sensitive | personal/sensitive data, payments, secrets, protected boundaries |
  independent security review before release |

Ambiguous between two values: take the higher, record the uncertainty.

## Examples

- Label copy-edit with tests: low / local / low / none.
- New single-module endpoint with validation/tests/docs: medium / module.
- Shared auth middleware change: medium / cross-module.
- Public event schema change: high / system.
- Module split with shared persistence + contract migration: high / cross-module.
