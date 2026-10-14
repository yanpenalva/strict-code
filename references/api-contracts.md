# API contracts

## Response envelope `[BLOCKING]`

Every JSON response follows one envelope:

```json
{ "status": "success|error", "message": "string", "data": { }, "errors": { } }
```

## Status semantics `[BLOCKING]`

| Code | Meaning |
|---|---|
| 200 | GET success |
| 201 | POST creation |
| 204 | DELETE success |
| 400 | business validation error |
| 401 | unauthenticated |
| 403 | forbidden |
| 404 | not found |
| 422 | invalid data |
| 500 | internal error — never exposes a stack trace |

Use `HTTP_*` constants; validate codes against a whitelist in the shared
exception handler.

## Exception → HTTP mapping `[BLOCKING]`

HttpException → its code; NotFound → 404; Validation → 422; Authorization →
403; default → 500. Log with context first, preserve the cause, return only
the envelope — traces are logged, never returned.

## Per-profile masking `[BLOCKING]`

Unrelated viewers receive allowlisted fields only (ids, public labels, status
windows — never documents, emails, addresses, phones). Allowlist mappers per
profile; snapshots/audit payloads immutable once created and served only via
an authenticated, authorized endpoint — never in lists.

## Evolution

- Version public contracts; deprecate with windows + migration guides.
- Consumer-contract tests and schema compatibility checks run on every
  breaking-shaped change; removal only after the window closes.

## Uploads and transport

- Upload rules: `file|mimes:<allowlist>|max:<kilobytes>` (frameworks such as Laravel count file sizes in kilobytes — never assume bytes) + service-side recheck;
  files stored with context + reference id, never executable on public paths.
- Stateless APIs (token): no session cookies, CSRF N/A; CORS allowlists known
  origins only.
