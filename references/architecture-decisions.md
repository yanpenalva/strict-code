# Architecture decisions

## When to record an ADR

A choice that constrains future work: stack, layering, auth model, data
strategy, cross-cutting tooling, integration foundations. One file per
decision: context → decision → impact → status + date. Keep a numbered index
(id, title, date, status); superseded ADRs stay readable, never deleted.

## Stack decision checklist

A project should have explicit, dated answers for each — `NOT FOUND` where
absent, never assumed:

1. Layout: monorepo vs split repos; frontend/backend boundaries.
2. Backend framework + language version floor.
3. Frontend stack: framework, bundler, UI kit, language strictness.
4. Complex workflows: declarative state machines vs ad-hoc status flags.
5. Persistence access: repository + interfaces vs direct ORM in services.
6. Business logic home: service layer + DI vs fat controllers/models.
7. Input validation: dedicated request objects vs inline rules.
8. Authorization model: RBAC roles/permissions, middleware, policies, admin path.
9. Authentication: token type, expiry, revocation, activity validation.
10. Database engine + driver-parity strategy for tests.
11. Audit trail: what is recorded, retention, tamper-protection.
12. Delete default: soft-delete vs hard-delete, recovery path.
13. Static analysis: tool, level, baseline policy for existing debt.
14. Commit gates: hooks, message lint, staged autofix.
15. Test runners back/front + coverage target ownership.
16. Async/mail: queue driver, dispatch rules, local capture tool.
17. External integrations: foundation, versioning, failure modes.
18. Domain docs: one doc per domain with the `module-docs.md` sections.
