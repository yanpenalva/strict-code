# Interaction and uncertainty

## Epistemic states

Every claim carries one state, recorded in artifacts — never blurred:

| State | Meaning | How to record |
|---|---|---|
| `known` | observed directly (file read, command run, output captured) | fact + source |
| `inferred` | derived by reasoning | marked inference + parent evidence |
| `unknown` | not determinable yet | what is unknown + why it matters |
| `not found` | sought and absent | `NOT FOUND` |

Never promote inference to fact. Claims without a state are claims, not
evidence. `confidence` (low/medium/high) rates the classification, not the
work's importance.

## Low confidence loop (not a question trigger)

```text
confidence low → inspect more → assess materiality of the remainder
→ ask only if a human decision is required
```

Asking from low confidence alone — when the gap is discoverable or
immaterial — is a conversation defect.

## Questioning protocol

Rule: never ask because information is missing; ask when the missing piece
materially changes the correct path AND cannot be discovered by inspection.
Inspect first, in order: repository (code, tests, config, history); project
profile and policies; current work item and artifacts; approved specs/plans;
existing behavior; runtime evidence (logs, outputs, results).

Ask only `HUMAN_DECISION_REQUIRED` categories — scope, behavior, risk,
ownership, authorization, delivery — where options differ materially. Present
the decision, options with trade-offs, and a recommendation; then stop and
wait.
