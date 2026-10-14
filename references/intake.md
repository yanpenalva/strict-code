# Intake, classification, and routing

Every operational request passes this front door before specifying. It
controls which context loads before each gate — it never replaces spec,
plan, validation, review, or human approval.

## 1. Intake

Identify from outcome + impact: `Product/Feature`, `Support/Bug`,
`Support/Incident`, or `Support/Hotfix`. For tracker-originated tasks, read
the issue + sprint/version first, then derive the area (`backend`,
`frontend`, `fullstack`, `docs`) from evidence — never assume it.

## 2. Classification

Record four axes before loading detail:

| Axis | Scale |
|---|---|
| Complexity | trivial / small / medium / large |
| Impact | local / module / cross-module / production |
| Security | none / authZ-adjacent / sensitive-data / auth-critical |
| Confidence | confirmed / inferred / unknown |

Unknowns stay `NOT FOUND` until discovered; inferences are labeled as such.

## 3. Routing depth

Derive deterministically: `minimal` (docs/small fixes), `standard`
(default), `extended` (large, cross-module, sensitive, or low confidence).
Depth may only be RAISED by an explicitly recorded human decision — never
lowered silently. Load only the guides the current phase requires; keep the
rest deferred. A route is a depth contract, not permission to skip gates.

## 4. Reclassify on evidence

Re-run classification when scope, impact, security, dependencies, or rollback
risk materially change. Record the evidence and the newly promoted domains.

## 5. Questions and escalation

- Inspect discoverable facts first (repo, tracker, existing artifacts).
- Decide reversible matters locally; record allowed assumptions.
- Ask ONLY when the answer changes scope, behavior, risk, cost, or
authorization. One material question beats five curious ones.
- Destructive commands (filesystem, Git, DB, volumes) require explicit,
immediate authorization + prior registration in the spec or progress file.
Prefer dry-run, inspection, and reversible alternatives.
