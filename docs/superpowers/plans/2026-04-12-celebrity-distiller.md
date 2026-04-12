# Celebrity Distiller Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Create a `celebrity-distiller` skill that distills any person source (name, bio, or book excerpts) into a structured decision-making profile and actionable playbook with a refinement loop.

**Architecture:** A single `SKILL.md` file containing YAML frontmatter and markdown instructions for Claude. No code — the skill is purely prompt-based instructions. The skill file is registered in `marketplace.json` so it can be discovered and installed via the lou-skill-marketplace plugin.

**Tech Stack:** Markdown, YAML frontmatter, Claude Code skill system

**Spec:** `docs/superpowers/specs/2026-04-12-celebrity-distiller-design.md`

---

## File Structure

| File | Action | Responsibility |
|------|--------|----------------|
| `skills/celebrity-distiller/SKILL.md` | Create | All skill instructions — input handling, output templates, refinement loop |
| `marketplace.json` | Modify | Register the skill in the plugin catalog |

---

### Task 1: Create the skill directory and SKILL.md skeleton

**Files:**
- Create: `skills/celebrity-distiller/SKILL.md`

- [ ] **Step 1: Create the directory**

```bash
mkdir -p skills/celebrity-distiller
```

- [ ] **Step 2: Create SKILL.md with frontmatter only**

Create `skills/celebrity-distiller/SKILL.md` with this content:

```markdown
---
name: celebrity-distiller
description: "Distill a person's biography, book content, or name into a comprehensive decision-making profile and actionable playbook. Extracts core values, mental models, principles, and situational rules from any source — biography, autobiography, or book excerpts."
license: MIT
---

# Celebrity Distiller

(body to follow)
```

- [ ] **Step 3: Verify frontmatter is valid**

Check that:
- `name` matches the directory name exactly (`celebrity-distiller`)
- `description` is under 1024 characters
- No consecutive hyphens in the name

- [ ] **Step 4: Commit the skeleton**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "feat: scaffold celebrity-distiller skill"
```

---

### Task 2: Write the input handling section

**Files:**
- Modify: `skills/celebrity-distiller/SKILL.md`

This section tells Claude how to interpret what the user provides before generating any output.

- [ ] **Step 1: Replace the placeholder body with the input handling section**

Replace `(body to follow)` with:

````markdown
# Celebrity Distiller

Given any source about a person — their name, a biographical paragraph, or excerpts from a book — produce a comprehensive decision-making profile and actionable playbook. Use the source to understand how they think, what they value, and how they decide.

## Input Handling

Determine the input type and behave accordingly. Do NOT use web search or external tools — only what the user provides or your training knowledge.

**Name only (well-known person):**
Produce a full draft profile and playbook from your training knowledge. Tag every item `[general knowledge]`. After outputting, prompt the user to paste book excerpts to strengthen the profile.

**Name only (obscure or uncertain):**
If you cannot produce at least 3 distinct, grounded principles with reasonable confidence, do not guess. Say so clearly and ask the user to paste source material before proceeding.

**Bio or Wikipedia text:**
Extract directly from the provided text. Ground every principle in what was stated.

**Book excerpts (primary use case):**
Treat excerpts as primary source material. Quote directly. Ground all principles in specific passages.

**Mixed or multi-round input:**
Merge new content into the existing profile. Do not restart from scratch.

### Source Confidence Markers

Tag every principle, behavior, and playbook item with one of:
- `[from source]` — directly stated in the provided material
- `[inferred]` — reasonably derived from patterns in the material
- `[general knowledge]` — from training data, not the provided text
- `[conflicting sources]` — new material contradicts an existing point; present both versions

Retain all markers in the final consolidated output.
````

- [ ] **Step 2: Verify the section reads clearly**

Read it back and confirm:
- Each input type has a distinct, unambiguous behavior
- The minimum confidence rule (3 distinct principles) is present
- All 4 markers are defined
- No tool use or web access is mentioned as permitted

- [ ] **Step 3: Commit**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "feat: add input handling section to celebrity-distiller"
```

---

### Task 3: Write the profile output template

**Files:**
- Modify: `skills/celebrity-distiller/SKILL.md`

This section defines the exact structure Claude must produce for Part 1.

- [ ] **Step 1: Append the profile output section after input handling**

Add to `skills/celebrity-distiller/SKILL.md`:

````markdown
## Part 1 — Comprehensive Profile

After determining input type and gathering enough material, produce the following structure. Target a profile readable in 10 minutes. Aim for depth over breadth — 3-5 strong, well-evidenced principles are better than 10 thin ones.

```
## [Name] — Profile

### Core Values
3-5 deeply held beliefs that drove their decisions. Each value:
- stated as a short label (e.g., "Perfectionism over shipping speed")
- followed by 1-2 sentences of explanation
- tagged with a source confidence marker

### Mental Models
How they thought about problems. Examples: first principles reasoning, long-term vs short-term framing, systems thinking, etc. Each model:
- named and briefly explained
- grounded in a specific decision or behavior from the source
- tagged with a source confidence marker

### Decision-Making Principles
Rules they applied consistently across contexts. Each principle:
- stated as a concrete rule (not an abstraction)
- illustrated with an example from their life or work
- tagged with a source confidence marker

### Signature Behaviors
Patterns others observed — how they ran meetings, hired people, handled failure, responded to criticism, etc. Each behavior:
- described specifically (not "he was detail-oriented" but "he reviewed every line of ad copy before it ran")
- tagged with a source confidence marker

### Key Quotes
Direct quotes from the source material anchoring the principles above.
Format: "[Quote]" — [context of when/where it was said] [source confidence marker]
If input was name-only, paraphrase known quotes and tag [general knowledge].
```
````

- [ ] **Step 2: Verify the template is complete**

Confirm each subsection has:
- A clear purpose
- Format instructions (not just a label)
- Confidence marker requirement

- [ ] **Step 3: Commit**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "feat: add profile output template to celebrity-distiller"
```

---

### Task 4: Write the playbook output template

**Files:**
- Modify: `skills/celebrity-distiller/SKILL.md`

Part 2 — the actionable, situation-based rules derived from the profile.

- [ ] **Step 1: Append the playbook section**

Add to `skills/celebrity-distiller/SKILL.md`:

````markdown
## Part 2 — Actionable Playbook

Immediately after Part 1, produce the playbook. Derive it from the profile — do not introduce new principles here.

Playbook items must be concrete rules, not vague abstractions.
- Good: "Would cut the feature scope, not the timeline."
- Bad: "Prioritized quality."

Each item carries a source confidence marker.

The five default situational headers below are starting scaffolding. For subjects where these frames don't fit (e.g., a musician, scientist, or athlete), replace them with more relevant situations derived from the source material.

```
## [Name] — Playbook

### When facing a difficult decision...
[1-3 concrete rules]

### When dealing with failure...
[1-3 concrete rules]

### When evaluating people or talent...
[1-3 concrete rules]

### When setting priorities...
[1-3 concrete rules]

### When under pressure...
[1-3 concrete rules]

[Add person-specific sections as warranted by the source material]
```
````

- [ ] **Step 2: Verify playbook section**

Confirm:
- Concrete rule requirement is stated with good/bad examples
- Default headers are marked as scaffolding, not mandatory
- Confidence markers required per item
- Explicitly derived from profile, not standalone

- [ ] **Step 3: Commit**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "feat: add playbook output template to celebrity-distiller"
```

---

### Task 5: Write the refinement loop section

**Files:**
- Modify: `skills/celebrity-distiller/SKILL.md`

The interactive loop that lets the user improve the profile over multiple rounds.

- [ ] **Step 1: Append the refinement loop section**

Add to `skills/celebrity-distiller/SKILL.md`:

````markdown
## Refinement Loop

After outputting Part 1 and Part 2, prompt the user:

```
Want to refine this? You can:
  1. Paste more excerpts from the book
  2. Correct something that feels off
  3. Add a specific domain (e.g., "focus on how they managed teams")
  4. Type 'done' to finish
```

For each refinement round:
- **New excerpts:** Extract new principles or behaviors and merge them into the existing profile. Do not restart.
- **Corrections:** Update the flagged item and note what changed.
- **Domain focus:** Deepen the relevant subsection(s) with more specificity.
- **Contradictions:** If new material conflicts with an existing point, flag it `[conflicting sources]` and present both versions side by side.

After each round, reprint the affected subsections with `[updated]` or `[added]` markers. Full reprinting is acceptable — the markers are best-effort annotations, not guaranteed minimal diffs.

When the user types `done`:
Reprint the complete, consolidated profile — both Part 1 and Part 2 in full — with all source confidence markers retained. This is the final reference document.
````

- [ ] **Step 2: Verify the refinement loop**

Confirm:
- All 4 user actions from the prompt are handled (excerpts, corrections, domain focus, done)
- Contradiction handling (`[conflicting sources]`) is described
- `done` behavior is unambiguous: full reprint of both parts with markers retained
- Merge behavior (not restart) is explicit

- [ ] **Step 3: Smoke test the full SKILL.md**

Read `skills/celebrity-distiller/SKILL.md` top to bottom and verify:
- Frontmatter is valid YAML
- Sections flow logically: input handling → Part 1 → Part 2 → refinement loop
- No section references another that hasn't been defined yet
- Total body length is under 500 lines / 5000 tokens (count if uncertain)

- [ ] **Step 4: Commit**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "feat: add refinement loop to celebrity-distiller"
```

---

### Task 6: Register the skill in marketplace.json

**Files:**
- Modify: `marketplace.json`

- [ ] **Step 1: Append the skill entry to the plugins array**

Read the current `marketplace.json`, then add the following object to the existing `plugins` array (do not replace the file wholesale — other entries may exist):

```json
{
  "name": "celebrity-distiller",
  "source": "./skills/celebrity-distiller",
  "description": "Distill a person's biography, book content, or name into a comprehensive decision-making profile and actionable playbook.",
  "version": "1.0.0",
  "category": "productivity",
  "tags": ["biography", "decision-making", "mental-models", "learning"]
}
```

- [ ] **Step 2: Verify the entry**

Check that:
- `name` matches `skills/celebrity-distiller/` directory name exactly
- `source` path is `./skills/celebrity-distiller`
- `category` is one of: `development`, `productivity`, `data`, `security`, `domain-specific`, `creative`
- JSON is valid (no trailing commas, balanced braces)

- [ ] **Step 3: Commit**

```bash
git add marketplace.json
git commit -m "feat: register celebrity-distiller in marketplace"
```

---

### Task 7: Manual smoke test

No automated tests exist for prompt-based skills. Verify correctness by running the skill.

- [ ] **Step 1: Invoke the skill with a name-only input**

In a Claude Code session, first register the marketplace source (if not already done):
```
/plugin marketplace add github:alexlou/lou-skill-marketplace
/plugin install celebrity-distiller@lou-skill-marketplace
```
Then trigger the skill with: `Distill Steve Jobs`

Verify:
- Output contains Part 1 (Profile with all 5 subsections) and Part 2 (Playbook)
- Every item is tagged `[general knowledge]`
- Refinement prompt appears after output

- [ ] **Step 2: Test refinement with a book excerpt**

Paste a short paragraph (3-5 sentences) from a real biography. Verify:
- New items appear tagged `[from source]`
- Existing `[general knowledge]` items are either strengthened or left unchanged
- `[updated]` or `[added]` markers appear on changed subsections
- Profile does not restart from scratch

- [ ] **Step 3: Test the done command**

Type `done`. Verify:
- Full profile (Part 1 + Part 2) is reprinted
- All confidence markers are present
- No sections are missing

- [ ] **Step 4: Test low-confidence name**

Invoke with an obscure name (e.g., a local figure with no Wikipedia presence). Verify:
- Skill declines to produce a profile
- Asks for source material instead
- Does not hallucinate confident-sounding principles

- [ ] **Step 5: Commit any fixes found during smoke test**

```bash
git add skills/celebrity-distiller/SKILL.md
git commit -m "fix: address issues found in smoke test"
```
(Skip this step if no issues found.)
