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
