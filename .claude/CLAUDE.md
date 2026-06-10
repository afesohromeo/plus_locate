# SmartDrive Terminal — Agent Instructions

## MCP Servers

Two MCP servers are active for this project:

| Server | Purpose |
|--------|---------|
| **dart** | Dart/Flutter tooling — code analysis, pub package resolution, widget previews, integration tests |
| **stitch** | Google Stitch — AI-powered UI screen generation and design systems |

Always prefer MCP tools over shell commands when they overlap (e.g. use dart MCP for pub operations, stitch MCP for UI generation).

---

## Skills Framework

All skills live in `.claude/skills/` organized into three folders:

| Folder | Domain |
|--------|--------|
| `superpowers/` | Agentic workflow — planning, TDD, debugging, code review |
| `flutter/` | Flutter/Dart development patterns |
| `stitch/` | UI design via the Stitch MCP server |

**Mandatory:** Before starting ANY task, scan the skill indexes below. If a skill applies (even 1% chance), read its `SKILL.md` and follow it.

---

## Superpowers Skills

> Path prefix: `.claude/skills/superpowers/`

| Skill | File | When to Use |
|-------|------|-------------|
| using-superpowers | `using-superpowers/SKILL.md` | Start of any conversation — establishes skill discovery |
| brainstorming | `brainstorming/SKILL.md` | Before any creative work (features, components, modifications) |
| writing-plans | `writing-plans/SKILL.md` | After spec approval, before touching code |
| executing-plans | `executing-plans/SKILL.md` | Executing plans with review checkpoints |
| subagent-driven-development | `subagent-driven-development/SKILL.md` | Executing plans with fresh subagent per task |
| test-driven-development | `test-driven-development/SKILL.md` | Before writing ANY implementation code |
| systematic-debugging | `systematic-debugging/SKILL.md` | Any bug, test failure, or unexpected behavior |
| verification-before-completion | `verification-before-completion/SKILL.md` | Before claiming work is complete |
| requesting-code-review | `requesting-code-review/SKILL.md` | After completing tasks or before merging |
| receiving-code-review | `receiving-code-review/SKILL.md` | When receiving code review feedback |
| using-git-worktrees | `using-git-worktrees/SKILL.md` | Starting feature work needing isolation |
| finishing-a-development-branch | `finishing-a-development-branch/SKILL.md` | When implementation is complete |
| dispatching-parallel-agents | `dispatching-parallel-agents/SKILL.md` | 2+ independent tasks to run concurrently |
| writing-skills | `writing-skills/SKILL.md` | Creating or editing skills |

### Core Workflow

```
Brainstorm → Write Plan → Execute (TDD) → Verify → Review → Finish Branch
```

### Key Principles

- **TDD**: No production code without a failing test first
- **YAGNI**: You Aren't Gonna Need It — remove unnecessary features
- **Systematic Debugging**: Find root cause before attempting fixes
- **Evidence Before Claims**: Run verification, read output, THEN claim results

---

## Flutter Skills

> Path prefix: `.claude/skills/flutter/`

| Skill | File | When to Use |
|-------|------|-------------|
| flutter-apply-architecture-best-practices | `flutter-apply-architecture-best-practices/SKILL.md` | Structuring a new project or refactoring for scalability (MVVM + Repository pattern) |
| flutter-build-responsive-layout | `flutter-build-responsive-layout/SKILL.md` | UI must adapt to mobile and tablet/desktop (LayoutBuilder, MediaQuery) |
| flutter-fix-layout-issues | `flutter-fix-layout-issues/SKILL.md` | Any RenderFlex overflow, unbounded constraint, or layout error |
| flutter-add-widget-test | `flutter-add-widget-test/SKILL.md` | Validating widget rendering or user interactions with WidgetTester |
| flutter-add-integration-test | `flutter-add-integration-test/SKILL.md` | Adding integration tests or automating user flows |
| flutter-add-widget-preview | `flutter-add-widget-preview/SKILL.md` | Creating or updating UI components — add interactive previews |
| flutter-implement-json-serialization | `flutter-implement-json-serialization/SKILL.md` | Mapping JSON keys to Dart model classes (fromJson/toJson) |
| flutter-setup-declarative-routing | `flutter-setup-declarative-routing/SKILL.md` | Deep linking, browser history, or advanced URL-based navigation (go_router) |
| flutter-setup-localization | `flutter-setup-localization/SKILL.md` | Initializing i18n support (flutter_localizations + intl) |
| flutter-use-http-package | `flutter-use-http-package/SKILL.md` | Fetching from or sending data to a REST API |

### Flutter Key Principles

- **Architecture**: UI (MVVM) → Domain (Use Cases, optional) → Data (Repository + Service)
- **No Logic in Views**: Views are dumb — state and commands live in ViewModels
- **Responsive by Default**: Use `LayoutBuilder` over device-type checks
- **Test Every Widget**: Widget tests before marking a UI task complete

---

## Stitch Skills

> Path prefix: `.claude/skills/stitch/`
> Requires: **stitch MCP server** (active for this project)

| Skill | File | When to Use |
|-------|------|-------------|
| stitch-design | `stitch-design/SKILL.md` | **Primary entry point** — generating or editing screens, prompt enhancement, DESIGN.md synthesis |
| taste-design | `taste-design/SKILL.md` | Generating premium DESIGN.md with strict typography and anti-generic UI standards |
| design-md | `design-md/SKILL.md` | Analyzing an existing Stitch project to synthesize a DESIGN.md |
| enhance-prompt | `enhance-prompt/SKILL.md` | Transforming vague UI ideas into polished Stitch-optimized prompts |
| stitch-loop | `stitch-loop/SKILL.md` | Autonomously building a multi-page website iteratively via baton-passing loop |
| react-components | `react-components/SKILL.md` | Converting Stitch designs into modular Vite/React components |
| shadcn-ui | `shadcn-ui/SKILL.md` | Integrating and building with shadcn/ui components |
| remotion | `remotion/SKILL.md` | Generating walkthrough videos from Stitch screens using Remotion |

### Stitch Workflow

```
enhance-prompt → stitch-design (generate/edit) → taste-design / design-md → stitch-loop (multi-page)
```

### Stitch Key Principles

- **Always enhance prompts** before calling any generation tool
- **DESIGN.md first**: Check for `.stitch/DESIGN.md`; generate one if missing (use `taste-design` or `design-md`)
- **Never re-generate** if `edit_screens` can achieve the goal
- **Persist metadata**: Always save `.stitch/metadata.json` after creating a project

---

## Quick Reference

For consolidated skill overviews, see the knowledge folder:

- `.claude/knowledge/superpowers-skills/artifacts/skills-reference.md`
- `.claude/knowledge/flutter-skills/artifacts/skills-reference.md`
- `.claude/knowledge/stitch-skills/artifacts/skills-reference.md`