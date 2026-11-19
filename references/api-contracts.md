# API contracts

## Response envelope `[BLOCKING]`

Every response with a JSON body follows one envelope; `204` has no body.

```json
{"status":"success","message":"Invoice created.","data":{"invoice_id":123},"errors":null}
{"status":"error","message":"Invoice not found.","data":null,"errors":{"code":"invoice_not_found"}}
```

- `status` mirrors success/error. On success, `data` carries the endpoint
  payload (object, array, or `null` — never wrapped twice) and `errors` is
  `null`; on error, `data` is `null` and `errors` follows the documented error
  schema.
- `message` is client-visible copy in the locale recorded for the project
  (`style.md`), never a raw exception message.

## Status semantics `[BLOCKING]`

| Code | Meaning |
|---|---|
| 200 | success with a body |
| 201 | resource created |
| 204 | success without a body (DELETE) |
| 400 | malformed request — the boundary cannot parse it |
| 401 | unauthenticated |
| 403 | forbidden |
| 404 | not found |
| 422 | well-formed request failing field or domain validation |
| 500 | internal error — never exposes a stack trace |

Use `HTTP_*` constants; validate codes against a whitelist in the shared
exception handler. A status outside the whitelist maps to 500 — never passed
through.

## Error codes `[BLOCKING]`

`errors.code` is a stable snake_case key (`invoice_not_found`), one per failure
the client can act on, documented per endpoint, never renumbered and never
reused with another meaning. Clients branch on `code`, never on `message`;
`message` stays human copy in the project locale.

## Exception → HTTP mapping `[BLOCKING]`

HttpException → its code when whitelisted; NotFound → 404; Validation → 422;
Authorization → 403; default → 500. Log with context first, preserve the cause,
return only the envelope — traces are logged, never returned.

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
