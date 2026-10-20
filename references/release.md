# Release and observation

Applicability: technical release evidence only — compatibility, rollback,
readiness, smoke, observation design. Release progression, authorization, and
the lifecycle belong to the project's workflow owner where one exists; its
record replaces this one, and nothing here authorizes a release.

## Review proportionality

Every production-affecting change gets a review proportional to risk and
independent of implementation where practical. Review compares request, spec,
plan, diff, tests, security impact, and operational evidence — reporting
findings without silently modifying implementation.

## Compatibility and rollback analysis `[BLOCKING]`

Public interfaces, migrations, data transformations, and config changes ship
with: compatibility statement, migration path, rollback plan + trigger, and
backout evidence where feasible.

## Release record

No production release without: named human approver, target, readiness
evidence, smoke check, observation window, rollback trigger. Post-release
signals are observed and the outcome recorded. Incidents/hotfixes close only
with a postmortem.

## Git vs deploy separation

Present validation evidence + a proposed Conventional Commit message before
finalizing. Commit/push authorization is NOT deployment authorization. A
denied push leaves the local commit intact — never retry or force.
