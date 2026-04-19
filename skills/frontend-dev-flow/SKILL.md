---
name: frontend-dev-flow
description: "Standardized Test-Driven Development (TDD) and agile frontend development workflow. Use when taking on a new frontend feature or requirement. Manages the end-to-end process from design evaluation, tool selection (Claude Code, Gemini CLI, etc.), test planning, implementation, to UAT and final reporting."
license: MIT
category: development
---

# Frontend Development Flow (TDD & Agile)

This skill guides you through a rigorous, human-in-the-loop development process for frontend features. It ensures high quality through test-driven planning and structured documentation.

## Directory Structure & State Management

All documents generated during this flow must be stored in a requirement-specific directory:
`docs/features/YYYY-MM-DD-[feature-name]/`

The flow is tracked through four sequential documents in this folder:
1. `01-design-eval.md`: Requirement breakdown, technical design, and human sign-off.
2. `02-test-plan.md`: Unit, Integration, and E2E test strategy and mock data definitions.
3. `03-qa-uat-log.md`: Incremental log of test failures, fixes, and user feedback during trials.
4. `04-final-report.md`: Summary of changes, test coverage, and technical debt.

---

## Phase 0: Setup & Tool Selection

**Trigger:** When starting a new feature.
1. Create the feature directory: `docs/features/YYYY-MM-DD-[feature-name]/`.
2. **Mandatory Question:** Ask the user:
   > "Which execution engine should I use for actual code writing?
   > A. **Current Agent**: I will write and modify the files directly.
   > B. **Claude Code**: I will provide instructions for you to run in Claude Code.
   > C. **Gemini CLI**: I will provide instructions for Gemini CLI.
   > D. **Human**: You will write the code, and I will guide/test."
3. Record the selection in the metadata of `01-design-eval.md`.

## Phase 1: Requirement & Design Analysis

1. Breakdown the feature into UI components, state logic, and API interactions.
2. Perform technical boundary assessment (performance, security, constraints).
3. Draft the initial implementation strategy in `01-design-eval.md`.

## Phase 2: Human Verification (Gate 1)

1. Present the design in `01-design-eval.md` to the user.
2. **Stop and Wait:** You MUST obtain an explicit "Approved" or "Sign-off" from the user before proceeding to Phase 3.

## Phase 3: Test-Driven Planning

1. Based on the approved design, write the test plan in `02-test-plan.md`.
2. Define scenarios for:
   - **Unit Tests**: Utility logic and isolated components.
   - **Integration Tests**: Component interactions and state flow.
   - **E2E/UI Tests**: Critical user paths.
3. Define Mock API data structures.

## Phase 4: Implementation

1. **If 'Current Agent' was chosen:** Start writing code in `src/` and tests in `tests/` following the test plan.
2. **If other tools were chosen:** Generate a detailed prompt/instruction set based on `02-test-plan.md` and direct the user to run it in the chosen tool.
3. Follow a progressive implementation: Structure -> Logic -> Styles.

## Phase 5: Test & Fix Loop

1. Run the test suite (Unit, Integration, E2E).
2. Log every failure in `03-qa-uat-log.md`.
3. Fix the code and re-run tests until all are green.

## Phase 6: UAT & Requirement Check (Gate 2)

1. Invite the user to perform a manual trial.
2. Compare the implementation against the original requirements in `01-design-eval.md`.
3. Log user feedback or missed details in `03-qa-uat-log.md`.
4. If changes are needed, loop back to Phase 4 or 5 as appropriate.

## Phase 7: Final Comprehensive Report

1. Generate `04-final-report.md`.
2. Include:
   - Summary of implemented functionality.
   - List of changed files.
   - Test results and coverage summary.
   - Recommended next steps or identified technical debt.
