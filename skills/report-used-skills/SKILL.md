---
name: report-used-skills
description: Report and list all skills used, consulted, or referenced during this turn. Use whenever any skill is applied, when completing a task, or when the user asks about skill usage, to append a clear, transparent "Skills Used" footer at the end of the response.
---

# Skill Usage Reporter (`report-used-skills`)

Use this skill to provide transparency by reporting which skills were consulted, executed, or referenced during the conversation turn.

## When to Use

- Whenever one or more skills from `<skills>` were read, consulted, or applied during the current turn.
- Whenever the user explicitly asks about which skills are active, used, or available.
- At the end of completing tasks where specialized runbooks or domain skills (e.g. debugging, TDD, design, docx, etc.) were utilized.

## Reporting Format

Place a concise footer at the very end of your response, preceded by a horizontal separator (`---`):

### When skills were used:
```markdown
---
> [!NOTE]
> **Skills used in this response:**
> - [`<skill-name>`](file:///home/chiencao/.gemini/config/skills/<skill-name>/SKILL.md): Brief 1-sentence note on how it was applied.
```

### When no skills were used (or direct answer):
```markdown
---
> [!NOTE]
> **Skills used:** None (handled directly without specialized skills).
```

## Guidelines

1. **Accuracy & Honesty**: Only report skills that were actually consulted (via `view_file` of their `SKILL.md`) or followed during the turn. Do not hallucinate skill usage.
2. **Proper Links**: Link each skill to its `SKILL.md` file using GitHub-style markdown links with the `file://` scheme.
3. **Conciseness**: Keep the footer brief and unobtrusive so it does not distract from the main answer.
