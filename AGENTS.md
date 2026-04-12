# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose

This is a personal Claude Code skill marketplace hosted on GitHub. It contains reusable `SKILL.md` packages installable directly in Claude Code via:

```
/plugin marketplace add github:alexlou/lou-skill-marketplace
/plugin install <skill-name>@lou-skill-marketplace
```

Or using `npx skill`:

```bash
npx skill install github:alexlou/lou-skill-marketplace/<skill-name>
```

No backend, database, or build system — this is a flat-file GitHub-native marketplace.

## Repository Structure

```
lou-skill-marketplace/
├── marketplace.json          # Marketplace catalog (required by Claude Code)
└── skills/
    └── <skill-name>/
        ├── SKILL.md          # Required: YAML frontmatter + markdown instructions
        ├── scripts/          # Optional: executable code (Python, Bash, JS)
        ├── references/       # Optional: reference docs, REFERENCE.md
        └── assets/           # Optional: templates, data files
```

## SKILL.md Specification

Every skill must have a `SKILL.md` with YAML frontmatter:

```yaml
---
name: skill-name              # max 64 chars, lowercase-kebab-case, must match directory name
description: "..."            # max 1024 chars — this is the activation trigger agents read
license: MIT                  # optional
compatibility: "..."          # optional, e.g. "Requires Python 3.11+"
---
```

Body (markdown instructions) should be under 500 lines / 5000 tokens. Scripts, references, and assets are loaded on-demand only.

## marketplace.json Format

```json
{
  "name": "lou-skill-marketplace",
  "owner": { "name": "Alex Lou" },
  "metadata": {
    "description": "Personal Claude Code skill collection",
    "version": "1.0.0",
    "pluginRoot": "./skills"
  },
  "plugins": [
    {
      "name": "skill-name",
      "source": "./skills/skill-name",
      "description": "...",
      "version": "1.0.0",
      "category": "development",
      "tags": ["tag1", "tag2"]
    }
  ]
}
```

## Adding a New Skill

1. Create `skills/<skill-name>/SKILL.md` with valid frontmatter
2. Add an entry to `marketplace.json` under `plugins`
3. Push to GitHub — immediately available to install

## Naming Conventions

- Skill directory name must exactly match the `name` field in `SKILL.md` frontmatter
- Names: lowercase letters, numbers, hyphens only — no consecutive hyphens
- Categories to use: `development`, `productivity`, `data`, `security`, `domain-specific`, `creative`
