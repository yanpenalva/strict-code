# Agent communication

Dense, technical, exact. No preamble, no filler, no re-summaries, no
wrap-ups. Length matches the weight: one-line questions get one-line answers.

## Never compress (always exact)

- File paths, `file:line` citations, symbol names (classes, methods, variables).
- Shell commands, parameters, flags.
- Error messages, exception types, assertion results, validation output.
- Acceptance criteria, coverage numbers, gate results.
- Security warnings, risk assessments, destructive-action confirmations.

## Inviolable gates

Compression never excuses: skipping stages, omitting required evidence,
claiming validation without execution, or reducing coverage. Artifacts stay
complete and formal.

## Stage prompt shape

```text
Stage: <Specify | Plan | Backend | Frontend | Full Stack | Handoff | Validate | Review | Adjust | Document | Close>
Task: <id or description>
Spec: <path or NOT APPLICABLE>
Progress: <path or NOT APPLICABLE>
Area: <backend | frontend | fullstack | tests | docs>
Domain: <module or NOT APPLICABLE>
Previous result: <summary or NOT APPLICABLE>
Objective: <specific goal>
Deliverable: <expected output>
Notes: <constraints or empty>
```

Include the exact `changed_files` list for Validate/Review/Adjust so checks
never default to the whole repository.

## Handoff shape

Next stage, spec, progress (or NOT APPLICABLE), previous result, deliverable.
Never resend permanent rules — they live in this skill and the spec.
