# AI Skills Collection 🚀

A curated collection of agent skills for AI coding assistants (Claude Code, Cursor, Cline, Roo Code, OpenCode, omp, etc.).

Each skill is modular and self-contained following the Agent Skill specification (`SKILL.md`), allowing you to download and use individual skills without pulling the entire repository.

---

## ⚡ Quick Install (One-Liner)

Install any single skill, install all skills, or list available skills using a single command:

```bash
# 1. List all available skills
curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s list

# 2. Install a single skill to global agent directory (~/.agents/skills/<skill-name>)
curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s pdf

# 3. Install a single skill into current project repository (.agents/skills/<skill-name>)
curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s pdf .agents/skills

# 4. Install ALL skills at once
curl -fsSL https://raw.githubusercontent.com/chiencao2288/ai-skills/main/install.sh | bash -s all
```

> **How it works under the hood**: It streams the GitHub tarball directly into `tar` to extract *only* the requested skill directory. No temporary clone, zero git history overhead, and instantaneous.

---

## 📦 Available Skills (21)

| Skill | Description |
| :--- | :--- |
| [`agent-browser`](skills/agent-browser/) | Fast browser automation CLI for AI agents (Chrome/Chromium via CDP, accessibility-tree, screenshot, testing). |
| [`agent-notes`](skills/agent-notes/) | Use when recording, updating, auditing, pruning, or reviewing an Agent Note (durable RFC/ADR decision record). |
| [`brainstorming`](skills/brainstorming/) | Explore ideas, create feature specifications, visual companions, and design reviews. |
| [`codebase-design`](skills/codebase-design/) | Design deep modules, clean seams, and improve interface testability. |
| [`docx`](skills/docx/) | Create, read, edit, or manipulate Word documents (`.docx`, `.dotx`). |
| [`frontend-design`](skills/frontend-design/) | Distinctive UI design, aesthetic direction, typography, and purposeful layouts. |
| [`grilling`](skills/grilling/) | Stress-test decisions, ideas, and architecture through targeted counter-arguments & relentless interviews (includes `grill-me`). |
| [`guarding-agent-work`](skills/guarding-agent-work/) | Pre-flight and guardrail checks before and during non-trivial code/test changes. |
| [`improve-codebase-architecture`](skills/improve-codebase-architecture/) | Scan codebases for deepening opportunities and visual HTML architectural reports. |
| [`orca-cli`](skills/orca-cli/) | Operate Orca-managed worktrees, folder contexts, terminals, and automations. |
| [`orca-per-workspace-env`](skills/orca-per-workspace-env/) | Set up, debug, or validate on-demand per-workspace container runtimes. |
| [`orchestration`](skills/orchestration/) | Coordinate supervised Orca workers: message dispatch, barriers, and multi-agent flow. |
| [`pdf`](skills/pdf/) | Extract, OCR, merge, split, fill forms, or generate PDF files. |
| [`pptx`](skills/pptx/) | Create, inspect, edit, or manipulate PowerPoint presentations (`.pptx`, `.potx`). |
| [`self-improving-agent`](skills/self-improving-agent/) | Continuous learning, error logging, and post-mortem reflection across sessions (`.learnings/`). |
| [`skill-creator`](skills/skill-creator/) | Create new skills, benchmark evals, and optimize descriptions. |
| [`systematic-debugging`](skills/systematic-debugging/) | Methodical root-cause investigation for bugs and test failures before proposing fixes. |
| [`taste-skill`](skills/taste-skill/) | Anti-slop frontend art direction, high-taste visual layout, and browser critique. |
| [`test-driven-development`](skills/test-driven-development/) | TDD workflow: write failing tests first, make them pass, then refactor cleanly. |
| [`use-this-skills`](skills/use-this-skills/) | Transparently report and link skills consulted during execution. |
| [`xlsx`](skills/xlsx/) | Create, edit, recalculate, and analyze Excel spreadsheets (`.xlsx`, `.xlsm`). |

---

## 🛠️ Environment & Prerequisites

Some skills include optional Python or Node scripts for advanced tasks (e.g. document validation, form filling, formula recalculation, or taste inspections).

### Python Dependencies
For skills dealing with documents (`docx`, `pptx`, `xlsx`, `pdf`, `skill-creator`):
```bash
pip install -r requirements.txt
```

### System Tools (Optional)
- **LibreOffice (`soffice`)**: Required for recalculating Excel formulas (`xlsx`) and validating OpenXML documents (`docx`, `pptx`).
- **Poppler Utilities (`pdftoppm`)**: Required for converting PDF pages to images (`pdf`).
- **Node.js 22+ & Chrome/Chromium**: Required for `taste-skill` and `agent-browser`.

---

## 📁 Repository Layout

```text
ai-skills/
├── README.md               # Catalog of skills and usage instructions
├── install.sh              # One-liner single/all skill installer & lister
├── requirements.txt        # Python dependencies for office and PDF scripts
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
