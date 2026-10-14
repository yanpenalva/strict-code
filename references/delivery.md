# Delivery stages

Canonical flow for features, fixes, and HUs. Documentation-only or tiny
maintenance may use a focused review with evidence instead — functional
changes always need a versioned spec first and must not exceed its scope.

```text
Specify → Plan → Backend → Frontend → Handoff → Validate → Review → Adjust → Document → Close
```

Split large full-stack work into backend-first then frontend slices; small
coupled changes may run full-stack. Never fix findings unprompted during
validation/review — adjust only approved or requested items.

## Artifacts

- **Spec** (versioned, required): scope, contracts, decisions, and a
  `Versioned Handoff` section carrying exactly the state needed to resume on
  another machine/agent. Every later stage reads it before acting.
- **Progress** (temporary, local): step-to-step state; removed at Close.
- **Review**: verdict + `file:line` findings graded blocking/non-blocking.

## Waves

| Subtask | Owner | Inputs | Dependencies | Acceptance evidence | Wave |
|---|---|---|---|---|---|
| … | … | … | … | … | 1 |

Wave 1 starts after plan approval; later waves only after dependencies
verify. Never assign overlapping mutable files to parallel workers without
an explicit integration strategy.

## Handoffs

Between steps send only: next stage, spec, progress (or NOT APPLICABLE),
previous result, deliverable. Never resend permanent rules. Same machine:
progress carries details. Across machines/agents: run the handoff sync and
record continuity in the spec's `Versioned Handoff`.

## Closing criteria

Done if and only if: spec created; plan reviewed; implementation matches the
approved spec; progress updated during execution and removed at close;
handoff synced where applicable; review run against request + spec + diff +
checklist; validations executed; docs updated or declared unnecessary;
verdict + counted findings recorded.
