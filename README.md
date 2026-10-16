# AI Skills Collection 🚀

A curated collection of agent skills for AI coding assistants (Claude Code, Cursor, Cline, Roo Code, OpenCode, omp, etc.).

Each skill is modular and self-contained following the Agent Skill specification (`SKILL.md`), allowing you to download and use individual skills without pulling the entire repository.

---

## ⚡ Quick Install (One-Liner)

Install any single skill with a single command (just like `brew`, `rustup`, or `bun`):

```bash
# Install to global agent skills directory (~/.agents/skills/<skill-name>)
curl -fsSL https://raw.githubusercontent.com/chiencao/ai-skills/main/install.sh | bash -s <skill-name>

# Or install into the current project repository (.agents/skills/<skill-name>)
curl -fsSL https://raw.githubusercontent.com/chiencao/ai-skills/main/install.sh | bash -s <skill-name> .agents/skills
```

> **How it works under the hood**: It streams the GitHub tarball directly into `tar` to extract *only* the requested skill directory. No temporary clone, zero git history overhead, and instantaneous.

---

## 📦 Available Skills

| Skill | Description |
| :--- | :--- |
| [`agent-notes`](skills/agent-notes/) | Use when recording, updating, auditing, pruning, or reviewing an Agent Note (durable RFC/ADR decision record). |
| [`brainstorming`](skills/brainstorming/) | Explore ideas, create feature specifications, visual companions, and design reviews. |
| [`codebase-design`](skills/codebase-design/) | Design deep modules, clean seams, and improve interface testability. |
| [`docx`](skills/docx/) | Create, read, edit, or manipulate Word documents (`.docx`, `.dotx`). |
| [`frontend-design`](skills/frontend-design/) | Distinctive UI design, aesthetic direction, typography, and purposeful layouts. |
| [`grill-me`](skills/grill-me/) | Relentless interview process to stress-test and sharpen a plan or design. |
| [`grilling`](skills/grilling/) | Stress-test decisions, ideas, and architecture through targeted counter-arguments. |
| [`guarding-agent-work`](skills/guarding-agent-work/) | Pre-flight and guardrail checks before and during non-trivial code/test changes. |
| [`improve-codebase-architecture`](skills/improve-codebase-architecture/) | Scan codebases for deepening opportunities and visual HTML architectural reports. |
| [`orca-cli`](skills/orca-cli/) | Operate Orca-managed worktrees, folder contexts, terminals, and automations. |
| [`orca-per-workspace-env`](skills/orca-per-workspace-env/) | Set up, debug, or validate on-demand per-workspace container runtimes. |
| [`orchestration`](skills/orchestration/) | Coordinate supervised Orca workers: message dispatch, barriers, and multi-agent flow. |
| [`pdf`](skills/pdf/) | Extract, OCR, merge, split, fill forms, or generate PDF files. |
| [`pptx`](skills/pptx/) | Create, inspect, edit, or manipulate PowerPoint presentations (`.pptx`, `.potx`). |
| [`skill-creator`](skills/skill-creator/) | Create new skills, benchmark evals, and optimize descriptions. |
| [`systematic-debugging`](skills/systematic-debugging/) | Methodical root-cause investigation for bugs and test failures before proposing fixes. |
| [`test-driven-development`](skills/test-driven-development/) | TDD workflow: write failing tests first, make them pass, then refactor cleanly. |
| [`use-this-skills`](skills/use-this-skills/) | Transparently report and link skills consulted during execution. |

---

## 🛠️ Alternative Download Methods

### Option A: `npx giget` / `npx degit`
```bash
npx giget gh:chiencao/ai-skills/skills/<skill-name> ~/.agents/skills/<skill-name>
```

### Option B: Native Git Sparse-Checkout
```bash
git clone --depth 1 --filter=blob:none --sparse https://github.com/chiencao/ai-skills.git /tmp/skill-temp
cd /tmp/skill-temp
git sparse-checkout set skills/<skill-name>
mv skills/<skill-name> ~/.agents/skills/
cd ~ && rm -rf /tmp/skill-temp
```

---

## 📁 Repository Layout

```text
ai-skills/
├── README.md               # Catalog of skills and usage instructions
├── install.sh              # One-liner single-skill installer
├── .gitignore              # Ignored cache & temporary files
└── skills/                 # Skills container
    └── <skill-name>/
        ├── SKILL.md        # Required: YAML frontmatter + prompt instructions
        ├── scripts/        # Optional: Helper scripts (Python/Node/Bash)
        └── references/     # Optional: Reference documents / manuals
```

---

## 📝 Skill Specification (`SKILL.md`)

Each skill directory contains a `SKILL.md` file:
```markdown
---
name: <skill-name>
description: Clear summary of what the skill does AND exact scenarios when it should trigger.
---

# Skill Title

Step-by-step instructions and workflows for the AI agent...
```
