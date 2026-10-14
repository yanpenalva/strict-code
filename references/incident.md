# Incident and hotfix operation

Select the support track for reproducible defects, active degradation, or
urgent production correction. Ask whether impact is ACTIVE before choosing
bug vs incident vs hotfix.

| Type | Meaning | First action |
|---|---|---|
| Bug | reproducible defect, no active service impact | triage + reproduce |
| Incident | active degradation, outage, user impact | contain + communicate |
| Hotfix | urgent production change for active/critical impact | minimal spec, rollback, targeted validation |

## Bug

Triage + reproduction artifacts before planning the fix. Preserve original
evidence; separate observed behavior from hypothesis.

## Incident

Open the incident record immediately: commander, impact, severity (sev1–sev4),
timeline, containment action, communication channel, escalation path. Code
change optional; when needed, attach the standard delivery artifacts.

## Hotfix

Expedited but never gutted: minimal spec, risk decision, targeted test,
reviewer, production approval, rollback plan, post-deploy observation — all
mandatory. Full incident record + postmortem before closure.

## Postmortem

Systemic cause, contributing conditions, detection gaps, owned preventive
actions. Never a blame document.
