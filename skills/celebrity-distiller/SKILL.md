---
name: celebrity-distiller
description: "Distill a person's biography, book content, or name into a comprehensive decision-making profile and actionable playbook. Extracts core values, mental models, principles, and situational rules from any source — biography, autobiography, or book excerpts."
license: MIT
---

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

## Part 1 — Comprehensive Profile

After determining input type and gathering enough material, produce the following structure. Target a profile readable in 10 minutes. Aim for depth over breadth — 3-5 strong, well-evidenced principles are better than 10 thin ones.

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

## Part 2 — Actionable Playbook

Immediately after Part 1, produce the playbook. Derive it from the profile — do not introduce new principles here.

Playbook items must be concrete rules, not vague abstractions.
- Good: "Would cut the feature scope, not the timeline."
- Bad: "Prioritized quality."

Each item carries a source confidence marker.

The five default situational headers below are starting scaffolding. For subjects where these frames don't fit (e.g., a musician, scientist, or athlete), replace them with more relevant situations derived from the source material.

### When facing a difficult decision...
[1-3 concrete rules, each tagged with a source confidence marker]

### When dealing with failure...
[1-3 concrete rules, each tagged with a source confidence marker]

### When evaluating people or talent...
[1-3 concrete rules, each tagged with a source confidence marker]

### When setting priorities...
[1-3 concrete rules, each tagged with a source confidence marker]

### When under pressure...
[1-3 concrete rules, each tagged with a source confidence marker]

[Add person-specific sections as warranted by the source material]
