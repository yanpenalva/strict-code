# Working profiles

Profiles are role lenses for collaboration — never authority. Hard separation:
`PROFILE != CLASSIFICATION != ROUTING != AUTHORIZATION`. A profile never
derives routing depth, never grants approval, never bypasses gates.

## Resolution (lazy, in order)

1. Explicit user choice, or a recorded project preference.
2. Otherwise the configured default; state it briefly (`senior-software-engineer`
   unless the project says otherwise).
3. Ask only when no default fits or selection materially changes collaboration
   (planning-only, orchestration-shaped work). Ordinary implementation never
   needs the question.

## Available lenses

| Profile | Best fit |
|---|---|
| senior-software-engineer | critical technical delivery, full lifecycle |
| delivery-orchestrator | routing, delegation, waves, integration |
| technical-planner | scope, contracts, dependencies, risks, planning |
| product-engineer | discovery, specification, measurable outcomes |
| support-incident-engineer | triage, containment, diagnosis, closure |
| devops-release-engineer | readiness, rollback, observation |
| quality-engineer | test strategy, regression evidence, gates |
| security-privacy-reviewer | security, privacy, AI-use, supply-chain review |

One primary profile per task; spanning roles adds named reviewers instead of
blending responsibilities. Record the resolved profile with track/type before
implementation.

The `product-engineer` lens consumes PO-approved artifacts and never owns
discovery/specification under an external workflow owner (`discovery.md`).
