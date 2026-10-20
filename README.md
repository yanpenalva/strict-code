# 🎯 strict-code

[![links](https://github.com/yanpenalva/strict-code/actions/workflows/links.yml/badge.svg)](https://github.com/yanpenalva/strict-code/actions/workflows/links.yml)
[![license](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![release](https://img.shields.io/github/v/release/yanpenalva/strict-code)](https://github.com/yanpenalva/strict-code/releases)

**strict-code** is a strict, AI-learnable system of code writing and review
standards: an agnostic core (flow control, typing, structural ceilings,
security, review criteria) plus dedicated stack guides for **PHP/Laravel** and
**TypeScript/Vue**. It is consumed as an agent skill (`SKILL.md` +
`references/`), audited twice, and versioned with SemVer. All contents in
en-US.

**Criteria, not a workflow.** With an external workflow owner, consume its
classification, approved spec, architecture, plan, and check evidence; never
reclassify, own discovery, or approve product scope or production.

---

## 📑 Table of Contents

1. [Philosophy](#-philosophy)
2. [Quick Start](#-quick-start)
3. [What's Inside](#-whats-inside)
4. [Core Rules at a Glance](#-core-rules-at-a-glance)
5. [Quality Gates](#-quality-gates)
6. [Working With the Skill](#-working-with-the-skill)
7. [Versioning](#-versioning)
8. [Contributing](#-contributing)
9. [License](#-license)
10. [Author](#-author)

---

## 🧠 Philosophy

- **Smallest working solution** (KISS/YAGNI). No speculative abstraction, no
  dead code, no behavior outside the approved scope.
- **Measurable over tasteful.** Every blocking rule carries a number, a
  counting method, and a `file:line`-grade citation format. Subjective claims
  ship with operational tests (see `references/`).
- **Ceilings block, targets guide.** A file at 500 lines ships; above 500 it
  doesn't. No metric-gaming: trivial wrappers and fragmented files are
  forbidden evasions.
- **Evidence or it didn't happen.** No validation claim without running the
  command; unknowns recorded as `NOT FOUND`, never invented.

---

## 📥 Quick Start

### Option 1 — Hermes Agent (native)

```bash
# clone next to your other skills and reference it by name
git clone https://github.com/yanpenalva/strict-code.git
# then load it in-session: skill_view(name='strict-code')
```

### Option 2 — Any coding agent (generic)

Point your harness instructions at this repo's `SKILL.md`:

```text
Follow the coding standards in <path-to-strict-code>/SKILL.md.
Load only the referenced guides the current phase needs.
Cite file:line per finding; close reviews with a counted verdict.
```

### Option 3 — Vendor into your repo

```bash
git submodule add https://github.com/yanpenalva/strict-code.git docs/strict-code
```

Then instantiate `references/project-profile.md` for your stack (commands,
thresholds, owners) — the core stays untouched.

### Updating

```bash
# One-time install of the CLI (requires ~/.local/bin on your PATH)
git clone https://github.com/yanpenalva/strict-code.git ~/.local/share/strict-code
ln -s ~/.local/share/strict-code/bin/strict-code ~/.local/bin/strict-code

# Update any copy to the latest stable tag
strict-code update [path-to-copy]
```

Manual fallback (clone or submodule):

```bash
cd <path-to-copy> && git fetch --tags && git checkout <latest-tag>  # see the Releases page
```

Official installation is this repository (clone, submodule, or the CLI above);
a policy copy inside another project's kit is that project's maintained
artifact, not an installation — upgrade it through that project's update path.

---

## 🗂️ What's Inside

`SKILL.md` holds the core rules, the canonical guide index, and verification.
Details live in `references/`:

| Area | Guides |
|---|---|
| Code | style, solid, modern-php, laravel, anti-patterns, patterns, frontend |
| Quality | quality-gates, review-checklist, testing, api-contracts |
| Conventions | conventions, security, module-docs, architecture-decisions |
| Process (standalone only) | intake, classification, domains, delivery, workflow, discovery |
| Operation | profiles, orchestration, governance, interaction, release, incident |
| Meta | project-profile, artifact-templates, agent-comms |

30 reference guides, zero duplication of ownership (each rule has exactly one
canonical file).

---

## ⚡ Core Rules at a Glance

- No `else` / `elseif` / `v-else`: guard clauses, early returns, `match`.
- No nested calls inside conditions — assign to a named variable first.
- Strings via interpolation; SQL only with parameter binding.
- `strict_types = 1`, full typing, enums for closed sets, named constants.
- Thin controllers, rules in services, queries in repositories.
- Sanitized logs; authorization follows the route's explicit contract.
- Every behavior change ships a focused test (80% target on new code).
- Conventional Commits; merge/PR only with explicit human approval.

```php
// WRONG
if ($this->repository->find($id)->isActive()) { ... }

// RIGHT
$model = $this->repository->find($id);
if ($model->isActive()) { ... }
```

---

## 🚦 Quality Gates

| Metric | Ceiling (blocking) | Target |
|---|---|---|
| Lines per file | 500 | — |
| Declared methods/functions | 15 | — |
| Lines per method | 150 | <30; extraction candidate >50 |
| Returns per method | 3 | — |
| Parameters per method | 7 (then DTO) | — |
| Cyclomatic / cognitive complexity | 10 / 15 | — |
| New-code coverage | — | ≥80% |
| Duplicated lines | — | <3% |

Counting rules, enforcement procedure, and the duplicated-literal formula live
in `references/quality-gates.md`. Reviews close with severity
(`[BLOCKING]`/`[TARGET]`) plus a counted verdict.

---

## 🔁 Working With the Skill (standalone only)

```text
Intake → Specify → Plan → Preflight → Execute → Verify → Review → Release → Observe → Close
```

Classify every request (complexity/impact/security/risk), derive routing depth
(`minimal`/`standard`/`extended`), load minimum-sufficient context, and work
under one primary profile (`references/profiles.md`). Multi-agent setups use
named assignments with least privilege; production stays human-approved
(`references/orchestration.md`, `references/governance.md`).

---

## 🏷️ Versioning

SemVer. `CHANGELOG.md` records every release; `v1.0.0` is the first stable
release (dual-audited: executor + independent reviewer).

Cut a release with one command (clean tree + changelog entry required):

```bash
strict-code release 1.2.0
```

The command bumps `SKILL.md`, commits, tags, pushes, opens the GitHub
release, then verifies the local checkout.

---

## 🤝 Contributing

1. Open an issue describing the rule change with evidence (audits, incidents,
   or measured pain).
2. Keep one owner per rule — update the canonical file, link from elsewhere.
3. All contents in en-US; examples must compile conceptually (RIGHT/WRONG).
4. PRs need a changelog entry. Merge requires maintainer approval.

---

## 📄 License

MIT — see [LICENSE](LICENSE).

---

## ✍️ Author

**Yan Penalva** — Senior Software Engineer.
Portfolio: [penalva.me](https://www.penalva.me) · GitHub:
[yanpenalva](https://github.com/yanpenalva)
