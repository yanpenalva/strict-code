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
| Complexity | low / medium / high (rubrics in `classification.md`) |
| Impact | local / module / cross-module / system |
| Security | none / relevant / sensitive (activations in `classification.md`) |
| Risk | low / medium / high / critical |
| Confidence | low / medium / high (rates the classification itself) |

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

## 5. Context budgets

Budgets cap REQUIRED domains per route (bootstrap + front-door contracts sit
outside the cap; unused capacity never justifies loading more):

| Route | Max required domains | Use |
|---|---|---|
| `minimal` | 3 | docs or local reversible change |
| `standard` | 5 | normal implementation or bugfix |
| `extended` | 7 | cross-module, sensitive, production, high-risk |

Invariants: required and deferred stay disjoint; a domain is required only
when promoted by phase, trigger, classification, or explicit human request;
`testing` promotes before validation, `security` for sensitive changes,
`architecture` for cross-module/system or persistence impact. A mandatory
policy never needs its full document in every phase.

## 6. Derived vs effective routing

`derived` routing is computed deterministically — evaluate in order, stop at
first match:

```text
0. confidence = low → floor at standard: never derive minimal on low confidence; gather evidence and re-derive
1. complexity = high OR risk in {high, critical}
   OR impact in {cross-module, system} OR security = sensitive → extended
2. complexity = low AND risk = low AND impact = local
   AND security = none → minimal
3. otherwise → standard
```

`effective` equals `derived` unless a human explicitly overrides UPWARD
(minimal→standard→extended); downgrades are rejected — depth drops only via
legitimate reclassification on new evidence. Record both + authority + reason.
Routing selects depth inside existing gates; it never removes a gate or
weakens a MUST, and assigning a stronger agent never upgrades a route.

Depth contracts: `minimal` = single-subtask plan, concise artifacts;
`standard` = waves + independent reviewer when practical (default);
`extended` = deep plan (alternatives, migration, rollback), per-wave evidence,
security review when relevant, independent review, human-gated release,
observation to close.

## 7. Questions and escalation

- Inspect discoverable facts first (repo, tracker, existing artifacts).
- Decide reversible matters locally; record allowed assumptions.
- Ask ONLY when the answer changes scope, behavior, risk, cost, or
authorization. One material question beats five curious ones.
- Destructive commands (filesystem, Git, DB, volumes) require explicit,
immediate authorization + prior registration in the spec or progress file.
Prefer dry-run, inspection, and reversible alternatives.
