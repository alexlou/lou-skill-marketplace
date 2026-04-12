# Celebrity Distiller Skill — Design Spec

**Date:** 2026-04-12
**Status:** Approved

---

## Purpose

A Claude Code skill that distills any source about a person (name, bio, or book excerpts) into a comprehensive decision-making profile and actionable playbook. Primarily for personal reference — to extract and internalize how influential people think and decide.

---

## Skill Identity

- **Name:** `celebrity-distiller`
- **Description:** "Distill a person's biography, book content, or name into a comprehensive decision-making profile and actionable playbook. Extracts core values, mental models, principles, and situational rules from any source — biography, autobiography, or book excerpts."

---

## Approach

Accept any input (name, bio text, or book excerpts), perform a structured extraction into a comprehensive profile + playbook, then enter a refinement loop where the user can add excerpts, correct errors, or focus on a domain. Output the final consolidated profile when the user is done.

---

## Output Structure

Target length: a profile readable in 10 minutes. Aim for depth over breadth — 3-5 strong, well-evidenced principles are better than 10 thin ones.

### Part 1 — Comprehensive Profile

```
## [Name] — Profile

### Core Values
3-5 deeply held beliefs that drove their decisions

### Mental Models
How they thought about problems (e.g., first principles, long-term vs short-term)

### Decision-Making Principles
Rules they applied consistently across contexts

### Signature Behaviors
Patterns others observed — how they ran meetings, hired, handled failure, etc.

### Key Quotes (as evidence)
Direct quotes anchoring each principle to the source material,
each tagged with a source confidence marker
```

### Part 2 — Actionable Playbook

```
## [Name] — Playbook

### When facing a difficult decision...
### When dealing with failure...
### When evaluating people/talent...
### When setting priorities...
### When under pressure...
[+ person-specific situations derived from their story, replacing generic headers when a different framing better fits the subject]
```

Playbook items should be concrete rules ("would cut the feature, not the timeline") not vague abstractions. Each item carries a source confidence marker.

The five default situational headers are starting scaffolding — for subjects where those frames don't fit (e.g., a musician or scientist), replace them with more relevant situations derived from the source material.

---

## Input Handling

Claude's built-in knowledge is the only permitted source when no material is provided; no tool calls or web access are used.

| Input Type | Behavior |
|---|---|
| Name only (well-known) | Produce a full draft profile + playbook from general knowledge, tag everything `[general knowledge]`, then prompt for book excerpts to strengthen it |
| Name only (obscure/uncertain) | If confidence is too low to produce meaningful output, state this clearly and ask the user to paste source material before proceeding |
| Bio/Wikipedia text | Extract directly from provided text |
| Book excerpts | Primary source — quote directly, ground all principles in passages |
| Mixed / multi-round | Merge new content into existing profile, don't restart |

**Minimum confidence rule:** If Claude cannot produce at least 3 distinct, grounded principles with reasonable confidence, it should not guess — instead, say so and request source material.

### Source Confidence Markers
- `[from source]` — directly stated in the provided material
- `[inferred]` — reasonably derived from patterns in the provided material
- `[general knowledge]` — from training data, not the provided text
- `[conflicting sources]` — new material contradicts an existing point; both versions are presented

These markers are retained in the final output.

---

## Refinement Loop

After initial output, the skill prompts:

```
"Want to refine this? You can:
  1. Paste more excerpts from the book
  2. Correct something that feels off
  3. Add a specific domain (e.g., 'focus on how they managed teams')
  4. Type 'done' to finish"
```

Each round:
- Adds new principles/behaviors if new material surfaces them
- Strengthens existing points with better quotes or examples
- Corrects mischaracterizations flagged by the user
- Deepens a specific domain on request
- Surfaces contradictions explicitly rather than silently overwriting: if new material conflicts with an existing point, flag it as `[conflicting sources]` and present both

After each refinement round, Claude reprints the affected subsections (e.g., the full "Mental Models" section if it changed) with `[updated]` or `[added]` markers. Full-document reprinting is acceptable for readability — the markers are best-effort, not guaranteed diffs.

When the user types `done`, the full consolidated profile (both Part 1 and Part 2) is reprinted in its entirety, with all source confidence markers retained.

---

## Non-Goals

- Not a writing/voice style capture tool
- Not a team/leadership framework generator
- No web search or external data fetching
