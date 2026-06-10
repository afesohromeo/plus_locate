# Superpowers Skills Framework - Complete Reference

> Source: https://github.com/obra/superpowers.git
> Local (project): .claude/skills/superpowers/
> Version: 5.1.0

## Skills Index

| # | Skill | When to Use | Skill File Path |
|---|-------|-------------|-----------------|
| 1 | **using-superpowers** | Starting any conversation — establishes skill discovery | `.claude/skills/superpowers/using-superpowers/SKILL.md` |
| 2 | **brainstorming** | Before any creative work — features, components, modifications | `.claude/skills/superpowers/brainstorming/SKILL.md` |
| 3 | **writing-plans** | After spec approval — creating implementation plans | `.claude/skills/superpowers/writing-plans/SKILL.md` |
| 4 | **executing-plans** | Executing plans in a separate session with checkpoints | `.claude/skills/superpowers/executing-plans/SKILL.md` |
| 5 | **subagent-driven-development** | Executing plans with fresh subagent per task + two-stage review | `.claude/skills/superpowers/subagent-driven-development/SKILL.md` |
| 6 | **test-driven-development** | Before writing ANY implementation code | `.claude/skills/superpowers/test-driven-development/SKILL.md` |
| 7 | **systematic-debugging** | Any bug, test failure, or unexpected behavior | `.claude/skills/superpowers/systematic-debugging/SKILL.md` |
| 8 | **verification-before-completion** | Before claiming work is complete or fixed | `.claude/skills/superpowers/verification-before-completion/SKILL.md` |
| 9 | **requesting-code-review** | After completing tasks or before merging | `.claude/skills/superpowers/requesting-code-review/SKILL.md` |
| 10 | **receiving-code-review** | When receiving code review feedback | `.claude/skills/superpowers/receiving-code-review/SKILL.md` |
| 11 | **using-git-worktrees** | Starting feature work needing isolation | `.claude/skills/superpowers/using-git-worktrees/SKILL.md` |
| 12 | **finishing-a-development-branch** | When implementation is complete, all tests pass | `.claude/skills/superpowers/finishing-a-development-branch/SKILL.md` |
| 13 | **dispatching-parallel-agents** | 2+ independent tasks that can run concurrently | `.claude/skills/superpowers/dispatching-parallel-agents/SKILL.md` |
| 14 | **writing-skills** | Creating new skills or editing existing ones | `.claude/skills/superpowers/writing-skills/SKILL.md` |

---

## Core Workflow

```
User Request → Brainstorming → Writing Plans → Execution (Subagent or Inline) → Verification → Finishing Branch
```

### 1. Brainstorming (MUST use before any creative/feature work)
- Explore project context first
- Ask ONE question at a time (prefer multiple choice)
- Propose 2-3 approaches with trade-offs
- Present design in sections, get approval per section
- Write spec to `docs/superpowers/specs/YYYY-MM-DD-<topic>-design.md`
- Self-review spec, then user reviews
- **Terminal state: invoke writing-plans skill**

### 2. Writing Plans (after spec approval)
- Bite-sized tasks (2-5 minutes each)
- Each step = one action with exact file paths and complete code
- NO placeholders (TBD, TODO, "implement later")
- TDD structure: write failing test → verify fail → implement → verify pass → commit
- Save to `docs/superpowers/plans/YYYY-MM-DD-<feature>.md`
- Self-review: spec coverage, placeholder scan, type consistency

### 3. Execution (two options)
**Subagent-Driven (recommended):** Fresh subagent per task + two-stage review (spec compliance → code quality)
**Inline Execution:** Batch execution with human checkpoints

### 4. Test-Driven Development (THE Iron Law)
```
NO PRODUCTION CODE WITHOUT A FAILING TEST FIRST
```
- RED: Write one minimal failing test
- Verify RED: Watch it fail (MANDATORY)
- GREEN: Write simplest code to pass
- Verify GREEN: Watch it pass (MANDATORY)
- REFACTOR: Clean up, keep green
- Write code before test? **Delete it. Start over.**

### 5. Systematic Debugging (4 Phases)
```
NO FIXES WITHOUT ROOT CAUSE INVESTIGATION FIRST
```
- **Phase 1: Root Cause** — Read errors, reproduce, check changes, trace data flow
- **Phase 2: Pattern** — Find working examples, compare differences
- **Phase 3: Hypothesis** — Form single hypothesis, test minimally
- **Phase 4: Implementation** — Create failing test, single fix, verify
- **If 3+ fixes failed:** Question the architecture, don't attempt fix #4

### 6. Verification Before Completion
```
NO COMPLETION CLAIMS WITHOUT FRESH VERIFICATION EVIDENCE
```
- Run the command. Read the output. THEN claim the result.
- Never use "should", "probably", "seems to"
- Evidence before claims, always.

---

## Key Principles

| Principle | Description |
|-----------|-------------|
| **TDD** | Write tests first, always |
| **YAGNI** | You Aren't Gonna Need It — remove unnecessary features |
| **DRY** | Don't Repeat Yourself |
| **Systematic > Ad-hoc** | Process over guessing |
| **Evidence > Claims** | Verify before declaring success |
| **Complexity Reduction** | Simplicity as primary goal |

---

## Reading Individual Skills

To read full skill details, access the SKILL.md file at:
```
c:\New_folder\bus tracking\smart_drive\.claude\skills\superpowers\<skill-name>\SKILL.md
```

Supporting files (techniques, templates) are in the same directory as each SKILL.md.