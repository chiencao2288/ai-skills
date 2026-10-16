---
name: agent-notes
description: Use when recording, updating, auditing, pruning, or reviewing an Agent Note — a durable RFC/ADR decision record under .agents/notes/<project-name>/ for monorepo microservices. Covers project scoping, the flat lifecycle (proposed/active/rejected), prefix-based classification (feat, arch, fix, sec, infra), mandatory skeletons, alternatives mandate, and supersession rules.
---

# Agent Notes for Monorepo & Microservices

An **Agent Note** records a technical decision or proposal that affects a specific microservice or the shared platform in this monorepo — the *why* and *what trade-offs were made*, the rationale code and commit messages cannot convey.

Agent Notes are durable RFCs/ADRs written by agents: rationale, alternatives, consequences, and verification requirements that survive refactors and engineer handovers.

---

## 1. Directory Structure (Project Namespaces)

Notes are organized by microservice/project namespace under `.agents/notes/`. A special `_global` namespace is reserved for cross-cutting monorepo decisions (shared protocols, message broker standards, root CI/CD, gateway routing).

```
.agents/notes/
├── _global/                     # Monorepo-wide & shared platform decisions
│   ├── proposed/
│   ├── deferred/                # Approved, but postponed for future releases/milestones
│   ├── active/
│   └── rejected/
├── <project-a>/                 # Microservice A (e.g. auth-services)
│   ├── proposed/
│   ├── deferred/
│   ├── active/
│   └── rejected/
└── <project-b>/                 # Microservice B (e.g. channel-rpc-rust)
    ├── proposed/
    ├── deferred/
    ├── active/
    └── rejected/
```

### Determining the Target Project
Before creating or updating a note, identify its scope:
- **Service-specific**: If the decision affects only one microservice (e.g. internal database schema, business logic, framework choice inside that service), place it under `.agents/notes/<service-folder-name>/`.
- **Cross-cutting / Global**: If the decision affects inter-service communication (gRPC, message broker schemas), shared libraries, deployment topology, or monorepo build tools, place it under `.agents/notes/_global/`.

---

## 2. Flat Lifecycle: "The Location is the Status"

Each project directory contains at most four flat lifecycle folders. Never nest class folders inside them.

| Folder | Status | Meaning |
| :--- | :--- | :--- |
| `proposed/` | `Status: proposed` | RFC/Proposal under discussion or draft. Not yet approved or built. |
| `deferred/` | `Status: deferred — <target/blocker>` | **Approved in principle**, but postponed for a future milestone (v2.0, Q2...) or blocked by external dependencies. |
| `active/` | `Status: active` | The decision is finalized, built, and currently governs production code (formerly `implemented`). |
| `rejected/` | `Status: rejected — <reason>` | Evaluated and declined. Kept to prevent re-litigating bad ideas in future sessions. |
When a proposal is implemented, move it via `git mv`:
```bash
git mv .agents/notes/<project>/proposed/<file>.md .agents/notes/<project>/active/<file>.md
```
Update line 3 (`Status: active`) and rewrite the body to present-tense reality in the same commit.

---

## 3. Filename Convention: Prefix + Date + Topic

Files inside lifecycle folders follow a flat, self-sorting naming scheme:

```
{prefix}_{yyyy-mm-dd}_{topic-kebab-case}.md
```

### Standard Prefixes
* **`arch_`** (*Architecture*): Structural decisions, database selection, module depth, boundary/seam design, API protocols.
* **`feat_`** (*Feature*): New capabilities, business logic flows, user-facing behavior specifications.
* **`fix_`** (*Bug Fix / Postmortem*): Durable records of critical defect fixes and root-cause solutions.
* **`sec_`** (*Security*): Authentication schemes, encryption standards, token lifecycle, authorization/RBAC policies.
* **`infra_`** (*Infrastructure*): Docker/K8s configurations, CI/CD pipelines, message queues, caching layers.
* **`rfc_`** (*Request for Comments*): Open design discussions or cross-team proposals.

### Examples
- `.agents/notes/auth-services/active/sec_2026-10-08_jwt-rs256-revocation.md`
- `.agents/notes/auth-services/proposed/feat_2026-10-10_telegram-otp-login.md`
- `.agents/notes/_global/active/arch_2026-10-09_grpc-channel-protocol.md`

---

## 4. File Skeletons

### Mandatory Header (First 5 lines)
Every note must open with:
```markdown
# Agent Note: <Title>

Project: <project-name-or-_global>
Type: <prefix-without-underscore> (e.g. arch, feat, sec, fix, infra)
Status: <status>

```

The `Status:` line must match the containing folder:
- In `proposed/`: `Status: proposed`
- In `deferred/`: `Status: deferred — <target release or prerequisite blocker>`
- In `active/`: `Status: active`
- In `rejected/`: `Status: rejected — <one-line reason why it lost>`

---

### Body Skeleton: `proposed/`
```markdown
# Agent Note: Telegram OTP Login

Project: auth-services
Type: feat
Status: proposed

## Problem
Describe the motivation and requirement. Must stand independently without assuming the solution.

## Proposal
Detailed design, data flow, API signatures, migration steps (future tense permitted).

## Acceptance Criteria
Observable conditions that prove the work is complete.

## Risks & Trade-offs
Potential edge cases, security hazards, and what this design gives up.

## Alternatives Considered
(Mandatory) Each alternative explored and why it was rejected.
```

---

### Body Skeleton: `deferred/`
```markdown
# Agent Note: <Title>

Project: <project-name-or-_global>
Type: <prefix-without-underscore>
Status: deferred — Target: v2.0 (Blocked by: <prerequisite>)

## Problem
The motivation and requirement.

## Proposal
The agreed-upon design, data models, and specifications.

## Acceptance Criteria
Observable conditions that will define done when implemented.

## Deferral Reason & Prerequisites
Why this is not built in the current release (e.g. out of scope for MVP, awaiting another service/dependency) and the exact condition that triggers moving it to active.

## Alternatives Considered
(Mandatory) Each alternative explored and why it was rejected.
```
---

### Body Skeleton: `active/`
```markdown
# Agent Note: JWT RS256 & Token Revocation

Project: auth-services
Type: sec
Status: active

## Problem
The motivation that led to this decision.

## Decision
Describe shipped reality in the present tense. Paths, env vars, token lifetimes, and interfaces must reflect actual code.

## Consequences
What this decision bought and what it cost (operational complexity, performance trade-offs).

## Alternatives Considered
(Mandatory) Each considered alternative and why it was not selected.
```

---

### Body Skeleton: `rejected/`
Keeps the proposal-time text intact. The rejection reason is prominently stated in line 4 (`Status: rejected — <reason>`), followed by a brief summary of why the proposal lost.

---

## 5. Alternatives Considered (Mandatory Rule)

A decision recorded without the alternatives it beat invites future AI sessions to re-litigate the same idea. 
Every note **MUST** include `## Alternatives Considered` with:
- The alternative option considered.
- The concrete technical or business reason why it was not chosen.

---

## 6. Cross-Service Linking

When notes reference decisions in other services or `_global`, use relative markdown links:
```markdown
- Standardized gRPC envelope: [Global gRPC Protocol](../../_global/active/arch_2026-10-09_grpc-channel-protocol.md)
- Token validation contract: [Auth Service JWT Spec](../../auth-services/active/sec_2026-10-08_jwt-rs256-revocation.md)
```

Relative links survive moves and can be mechanically validated.

---

## 7. Keeping Notes Small & Relevant (Inventory, Not Museum)

1. **Delete trivial notes**: Do not write notes for minor UI changes, localized refactors, or mechanical dependency bumps. Git commits and PRs handle those.
2. **Supersession**: When a new decision supersedes an older one:
   - If **fully superseded**: Update the new note with any retained rationale, repair inbound links, and remove the obsolete file.
   - If **partially superseded**: Cross-link both notes and update stale facts in the older note.
