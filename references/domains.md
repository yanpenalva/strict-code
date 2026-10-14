# Context domains and triggers

Load minimum-sufficient context per decision. The bootstrap (this skill +
project profile + front-door contracts) is not a domain and sits outside all
budgets.

## Domain catalog

| Domain | Purpose | Typically promoted by |
|---|---|---|
| core | governance, precedence, judgment, questioning rules | policy/precedence questions, any gate needing interpretation |
| project | stack, conventions, local architecture facts | implementation, repo-specific decisions |
| testing | quality standards, tools, validation and evidence rules | code work, validation planning, verify, test evidence |
| architecture | boundaries, cross-module design, persistence/dependencies | cross-module/system impact, persistence, extended planning |
| security | auth, secrets, privacy, sensitive data | relevant/sensitive signal, auth or data boundary found |
| release | deploy, gates, rollback, observability | production/release action |
| incident | incident/hotfix/containment procedures | incident, hotfix, active degradation |

An entry names purpose and sources; it never inlines their content.

## Promotion triggers

The only runtime path from deferred to required (besides phase needs and
explicit human request). Each promotion is recorded and auditable.

| Signal | Promotes |
|---|---|
| security signal != none | security |
| auth/secret/personal-data boundary discovered | security |
| persistence/migration/data-integrity work discovered | architecture |
| impact in {cross-module, system} | architecture |
| external integration or public contract change | architecture |
| production action or release gate approaching | release |
| incident/hotfix type or active degradation | incident |
| entering verify with security-relevant diff | security |
| planning/executing under extended routing | architecture |
| project-specific behavior or conventions work | project |
| code work, validation planning, verify, test evidence | testing |
| governance/precedence question during a gate | core |
| explicit human request | requested domain |

## Rules

- One trigger promotes exactly its domain — never fellow travelers.
- Promotion is one-directional (deferred → required); return only via
  legitimate reclassification that removes the signal.
- No trigger for "might be useful"; classifying-time discovery is not promotion.
- Budgets (`intake.md` §5) still cap required domains per route.
