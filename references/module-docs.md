# Module documentation standard

One document per business domain with fixed sections, in this order:

1. Overview — purpose, key rules, main flows.
2. Models/tables — entities, columns, relations.
3. Controllers — endpoints, contracts, delegation.
4. Services — rules owned, collaborators.
5. Repositories — queries owned, persistence notes.
6. Routes/middlewares — paths, auth, permissions.
7. State machine — states, transitions, actions (when applicable).
8. Frontend — screens, components, state sources.
9. Permissions/policies — who may do what, exceptions.

Update the owning module doc on every behavior/contract change; new
constants, events, and configs are documented or the task is not closed.
No named owner per module is itself a finding — assign one.
