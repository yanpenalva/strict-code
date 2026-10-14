# Artifact templates

Shapes for the delivery artifacts in `delivery.md`. Copy the shape, fill every
field; `NOT APPLICABLE` is an explicit answer, never a blank.

## Spec (versioned, required)

- Original request: id, tracker sprint/version, area, domain, requester, date.
- Objective (functional result), Scope, Out of Scope.
- Context and evidence: docs consulted (only relevant ones), codebase
  consulted; `NOT FOUND` for absent files/classes/routes/permissions/migrations.
- Intake record: track/type + classification axes + routing depth.
- Decisions and change log with dates; `Versioned Handoff` with exactly the
  state needed to resume elsewhere.

## Review

- Entries: original order, spec, progress, diff, checklist used.
- Handoff check: spec alone suffices to continue elsewhere?
- Correct / Problems / Risks / Recommended settings (bullets with `file:line`).
- Mandatory checks: matches request? follows spec? no out-of-scope diff? every
  referenced file/endpoint/migration/permission exists? architecture and
  existing validations/permissions preserved?
- Verdict: `APPROVED` or `CHANGES` + counted findings.

## Progress (temporary, removed at Close)

Current stage, what is done, what is next, blockers, uncommitted files.
Never the sole continuity source across machines — that is the spec's handoff.

## Change record

Date, author, what changed, why, affected files, migration/rollback notes.

## Context manifest

Machine-readable: task id, track/type, classification, routing depth,
`required` vs `deferred` domains (disjoint), phase. Rebuild when reclassifying.

## Work-item fields

`id`, `title`, `track` (product/support), `type` (feature/bug/incident/hotfix),
`phase` (discover/triage/contain/specify/plan/preflight/execute/verify/release/
observe/learn/close), `status` (draft/ready/active/blocked/completed/cancelled),
`risk` (low/medium/high/critical), `severity` for incidents (sev1–sev4), `owner`,
`conversation_profile`, `git_finalization_mode` (confirm_each/automatic),
`classification` (complexity/impact/security/confidence), `routing` (derived +
effective + override authority/reason), `policy_exceptions`, `phase_history`.
