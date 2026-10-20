# Project instantiation profile

This skill is language-agnostic at its core (flow control, typing, ceilings,
security, process). Each adopting project records ONE instantiation file so
agents stop guessing stack facts. Discover by inspection; `NOT FOUND` where
absent; no work item is created by onboarding.

## Required fields

- Stack: languages + versions, frameworks, package managers.
- Layout: repo shape, backend/frontend boundaries, owner paths.
- Quality: format/lint/analysis/test commands per area + thresholds owned here
  (coverage target, complexity caps) or `NOT FOUND`.
- Conventions: naming deltas, commit hooks, migration rules, HTTP envelope.
- Security: auth model, permission contract, secrets store, data classification.
- Experience budgets: accessibility baseline + latency/bundle/memory/query caps (or NOT FOUND).
- Operations: environments, deploy path, smoke check, observation signals,
  rollback trigger, human approvers.
- Stack guides: which `references/*` apply verbatim, which need a per-project
  counterpart (e.g. a Python or Go equivalent of the PHP rules).
- Local rules: authentic project instruction, domain, architecture, and ADR
  paths, indexed by scope; never copy or treat an unvetted file as authority.
- Engineering source: `<path | URL | opaque id | NOT FOUND>`; owner:
  <engineering-standard owner>; revision: <version/revision or NOT FOUND>.
  Pointer only — no install command, config key, or package identity implied.

## Rules

- Placeholders are filled once; work items reference the profile instead of
  copying it into every prompt.
- Unknowns explicit; re-onboard (update, don't fork) when the stack changes.
- Project conventions may specify idioms and tools but MUST NOT silently weaken
a core MUST — weakening needs an approved, scoped, expiring exception.
- Starter kits and other distributions link to the official engineering source
  and keep local configuration authoritative; never fork the policy body or
  present a maintained copy as an official installation.
