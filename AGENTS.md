# AGENTS.md

This file provides guidance to AI coding agents (Gemini, Codex, etc.) when working in this repository.

## Purpose

This is a personal Claude Code skill marketplace hosted on GitHub. Skills are reusable `SKILL.md` packages installable directly in Claude Code via:

```
/plugin marketplace add github:alexlou/lou-skill-marketplace
/plugin install <skill-name>@lou-skill-marketplace
```

No backend, database, or build system — this is a flat-file GitHub-native marketplace.

## Repository Structure

```
lou-skill-marketplace/
├── marketplace.json          # Marketplace catalog (required by Claude Code)
├── CLAUDE.md                 # Guidance for Claude Code agents
├── AGENTS.md                 # Guidance for other AI agents (this file)
└── skills/
    └── <skill-name>/
        ├── SKILL.md          # Required: YAML frontmatter + markdown instructions
        ├── scripts/          # Optional: executable code (Python, Bash, JS)
        ├── references/       # Optional: reference docs, REFERENCE.md
        └── assets/           # Optional: templates, data files
```

## Core Concepts

- **Skill**: A named, installable behavior package. A skill is activated when an agent reads its `description` and decides it matches the user's intent.
- **marketplace.json**: The registry catalog. Every skill must be listed here to be discoverable.
- **SKILL.md**: The skill definition file — YAML frontmatter + markdown instructions. This is what the agent reads when a skill is invoked.

---

## Development Workflow: Adding a New Skill

### Step 1 — Create the skill directory and SKILL.md

```
skills/<skill-name>/SKILL.md
```

The `SKILL.md` must have valid YAML frontmatter:

```yaml
---
name: skill-name              # max 64 chars, lowercase-kebab-case
description: "..."            # max 1024 chars — activation trigger (see below)
license: MIT                  # optional
compatibility: "..."          # optional, e.g. "Requires Python 3.11+"
---
```

Followed by the skill body in markdown (target: under 500 lines / 5000 tokens).

### Step 2 — Register in marketplace.json

Add an entry to the `plugins` array:

```json
{
  "name": "skill-name",
  "source": "./skills/skill-name",
  "description": "Short description for marketplace listings.",
  "version": "1.0.0",
  "category": "development",
  "tags": ["tag1", "tag2"]
}
```

Valid categories: `development`, `productivity`, `data`, `security`, `domain-specific`, `creative`

### Step 3 — Push to GitHub

Once pushed to `main`, the skill is immediately installable. No build step required.

---

## Development Workflow: Updating an Existing Skill

1. Edit `skills/<skill-name>/SKILL.md` — update instructions, examples, or frontmatter
2. Bump `version` in both `SKILL.md` frontmatter (if present) and `marketplace.json`
3. Keep `name` stable — renaming a skill is a breaking change for existing users
4. Push to `main`

---

## Writing Good Skills

### The `description` field is the activation trigger

The `description` in `SKILL.md` frontmatter is what agents read to decide whether to invoke the skill. It is the most important part of the skill file. Write it to:

- Describe **when** to use the skill (trigger conditions, not just what it does)
- Use natural language that matches how users request things
- Call out key verbs/scenarios: "Use when...", "Handles...", "Triggered when user asks about..."

Example of a weak description:
```
"Processes biographies."
```

Example of a strong description:
```
"Distill a person's biography, book content, or name into a comprehensive
decision-making profile and actionable playbook. Extracts core values, mental
models, principles, and situational rules from any source."
```

### Skill body guidelines

- Lead with **what the skill produces** — the output format and shape
- Describe **input handling** — what inputs are valid, how to behave for each variant
- Use concrete rules, not vague abstractions
  - Good: "If the user provides only a name, produce a draft and tag every item `[general knowledge]`"
  - Bad: "Handle names appropriately"
- Avoid redundancy with the description — the body expands on it, not restates it
- Use headers to separate logical phases (Input Handling → Processing → Output Format → Refinement Loop)

### Optional support files

Place helper scripts in `scripts/`, reference docs in `references/`, and data files in `assets/`. These are loaded on-demand only — keep the SKILL.md body self-contained enough to work without them.

---

## Naming Conventions

- Skill directory name must exactly match the `name` field in `SKILL.md` frontmatter
- Names: lowercase letters, numbers, hyphens only — no uppercase, no underscores, no consecutive hyphens
- The `name` in `marketplace.json` must also match exactly

---

## Checklist Before Pushing

- [ ] `skills/<skill-name>/SKILL.md` exists with valid YAML frontmatter
- [ ] `name` in frontmatter matches directory name
- [ ] `description` clearly states when/why to activate the skill
- [ ] `marketplace.json` has a matching entry with correct `source` path and `category`
- [ ] Version is bumped if updating an existing skill
- [ ] Skill body is under 500 lines and self-contained
