# Multi-agent orchestration

Answers "who does what" without duplicating workflow policy.

| Assignment | Meaning |
|---|---|
| orchestrator | starts, asks missing questions, creates the work item, coordinates waves |
| planner | specification, plan, dependency graph |
| executor | bounded implementation and tests |
| reviewer | independent scope/quality/security/evidence check |
| security_reviewer | activates on sensitive/security/AI-impacting work |
| release_approver | ALWAYS human — production and irreversible actions |

## Rules

- Least privilege per worker: work item + relevant files + assigned subtask +
  stop condition. A subtask that finds unclear scope/contract/authorization
  stops and returns a finding.
- Wave order, ownership, dependencies, and the recombination rule live in the
  plan; later waves run only after dependencies verify.
- Reviewers never built the slice they review; builders never open/merge PRs —
  the orchestrator owns PR creation after the verdict.
- Verify delivery through the forge (branches, commits, diff, CI state), never
  through agent prose.
- Pull requests: `never` (push-only), `manual` (agent drafts, human opens), or
  `automatic` (project-owned open-only command after green push). Merge, force,
  and administration stay human — opening a PR never approves it.
- Git finalization: `confirm_each` (separate approval per commit and push;
  unresolved mode authorizes nothing) or `automatic` (only the validated commit
  + push for the recorded item/branch/remote; any scope/branch/risk change
  invalidates it). Force push, hard reset, and destructive clean are forbidden.
