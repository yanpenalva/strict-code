# Security guide

Verifiable requirements. Every item needs a test or evidence; declared intent
without a mechanism does not count.

## Hard prohibitions (no exception without justification)

- Concatenating SQL or shell commands; `eval`; uncontrolled `unserialize` or
  over user input.
- Exposing stack traces; logging passwords, tokens, or Authorization headers.
- `$guarded = []` — declare explicit `$fillable` on every model.
- Unhashed passwords; comparing secrets/hashes with `==` (use `hash_equals`).
- `{!! !!}` with user-derived content; `v-html` without sanitization.
- Uploads without mime + size validation; floats for money (minor-unit integer
  or decimal string instead).
- `extract()`, `$$var`, `goto`.

## Logs and sensitive data

- Sanitized diagnostic context with identifiers (ids, action, outcome);
  specific messages ("Failed to sync user."), never generic ("Error.").
- Exception traces only with sensitive data scrubbed; when in doubt, do not log
  the content.
- Secrets/credentials: reference by vault name, never by value — in code,
  specs, logs, or wikis.

## Authentication and authorization

- Use the project's existing mechanisms (session/token, permission-based RBAC);
  never reinvent auth inside a task.
- Follow the route's explicit contract: middleware, policy, public route, or
  documented heartbeat. A generic checklist never vetoes a documented exception.
- Sensitive actions (password, consent, revocation): revalidate identity or
  record justification.

## Tokens and sessions

- Short expiry, explicit algorithm, working revocation (logout/block really
  invalidates).
- Tests: expired, revoked, inactive profile, cross-user isolation (A never
  reaches B's data; 401/403 on negatives).

## Input and output

- External input validated at the boundary (FormRequest/dedicated validator);
  output encoded per context; SQL only with binding.
- CORS/origin restrictions with an explicit origin matrix + negative tests;
  rate limits on credentials.
- Uploads: verified type, size, and content; nothing executable on public paths.

## Dependency hygiene

- Lockfiles committed; security audits run on every dependency change.
- Vulnerability triage deadlines come from project policy (critical = immediate).
- Provenance: prefer signed/official packages; removal criteria — unused,
  unmaintained, or duplicated capability.

## Auditing

- Sensitive mutations produce trails (who, what, when); retention and
  tamper-protection in the spec.
