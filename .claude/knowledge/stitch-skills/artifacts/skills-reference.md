# Stitch Skills - Complete Reference

> Local (project): .claude/skills/stitch/
> MCP Server: stitch (HTTP — https://stitch.googleapis.com/mcp)

## Skills Index

| # | Skill | When to Use | Skill File Path |
|---|-------|-------------|-----------------|
| 1 | **stitch-design** | **Primary entry point** — generating or editing screens, prompt enhancement, DESIGN.md synthesis | `.claude/skills/stitch/stitch-design/SKILL.md` |
| 2 | **taste-design** | Generating a premium DESIGN.md with strict typography and anti-generic UI standards | `.claude/skills/stitch/taste-design/SKILL.md` |
| 3 | **design-md** | Analyzing an existing Stitch project to synthesize a DESIGN.md | `.claude/skills/stitch/design-md/SKILL.md` |
| 4 | **enhance-prompt** | Transforming vague UI ideas into polished Stitch-optimized prompts | `.claude/skills/stitch/enhance-prompt/SKILL.md` |
| 5 | **stitch-loop** | Autonomously building a multi-page website iteratively via baton-passing loop | `.claude/skills/stitch/stitch-loop/SKILL.md` |
| 6 | **react-components** | Converting Stitch designs into modular Vite/React components | `.claude/skills/stitch/react-components/SKILL.md` |
| 7 | **shadcn-ui** | Integrating and building with shadcn/ui components | `.claude/skills/stitch/shadcn-ui/SKILL.md` |
| 8 | **remotion** | Generating walkthrough videos from Stitch screens using Remotion | `.claude/skills/stitch/remotion/SKILL.md` |

---

## Stitch MCP Tools

The stitch MCP server exposes 13 tools:

| Tool | Purpose |
|------|---------|
| `create_project` | Create a new Stitch project |
| `get_project` | Retrieve project details by name |
| `list_projects` | List all accessible projects |
| `list_screens` | List all screens within a project |
| `get_screen` | Retrieve a specific screen's details |
| `generate_screen_from_text` | Generate a new screen from a text prompt (async, takes minutes) |
| `edit_screens` | Edit existing screens via a text prompt |
| `generate_variants` | Generate variants of existing screens |
| `upload_design_md` | Upload a DESIGN.md file to a project |
| `create_design_system` | Create a design system (colors, typography, shape, appearance) |
| `update_design_system` | Update an existing design system |
| `create_design_system_from_design_md` | Create a design system from an uploaded DESIGN.md |
| `list_design_systems` | List all design systems for a project |
| `apply_design_system` | Apply a design system's tokens to selected screens |

---

## Core Workflow

### Single Screen (most common)
```
enhance-prompt → stitch-design → generate_screen_from_text → get_screen (poll if timeout)
```

### First-Time Design System
```
taste-design (create DESIGN.md) → upload_design_md → create_design_system_from_design_md
```

### Editing Existing Screen
```
stitch-design → edit_screens (prefer over re-generation for targeted changes)
```

### Multi-Page Website
```
taste-design → stitch-loop (baton system: next-prompt.md → generate → integrate → update baton)
```

### Stitch → React/Web
```
stitch-design → react-components (Vite + React) OR shadcn-ui
```

---

## Prompt Enhancement Template

Before calling any generation tool, structure the prompt:

```markdown
[Overall vibe, mood, and purpose of the page]

**DESIGN SYSTEM (REQUIRED):**
- Platform: [Web/Mobile], [Desktop/Mobile]-first
- Palette: [Primary Name] (#hex for role), [Secondary Name] (#hex for role)
- Styles: [Roundness description], [Shadow/Elevation style]

**PAGE STRUCTURE:**
1. **Header:** [Navigation and branding description]
2. **Hero Section:** [Headline, subtext, primary CTA]
3. **Primary Content Area:** [Detailed component breakdown]
4. **Footer:** [Links and copyright]
```

---

## File Structure Convention

```
project/
└── .stitch/
    ├── metadata.json       # Stitch project & screen IDs (always persist!)
    ├── DESIGN.md           # Visual design system source of truth
    ├── SITE.md             # Site vision, sitemap, roadmap (stitch-loop)
    ├── next-prompt.md      # Baton file for stitch-loop iterations
    └── designs/            # Staging area for downloaded HTML + PNG
        ├── {page}.html
        └── {page}.png
```

### metadata.json Schema
```json
{
  "name": "projects/{id}",
  "projectId": "{id}",
  "title": "Project Title",
  "deviceType": "MOBILE",
  "designTheme": { "colorMode": "LIGHT", "font": "INTER", "roundness": "ROUND_EIGHT", "customColor": "#hex" },
  "screens": {
    "{page}": { "id": "...", "sourceScreen": "projects/{id}/screens/{id}", "x": 0, "y": 0, "width": 390, "height": 1249 }
  }
}
```

---

## Key Principles

| Principle | Rule |
|-----------|------|
| **Enhance First** | Always enhance the prompt before calling any generation tool |
| **DESIGN.md First** | Check for `.stitch/DESIGN.md`; generate one if missing |
| **Edit Over Regenerate** | Prefer `edit_screens` for targeted changes |
| **Persist Metadata** | Save `.stitch/metadata.json` after every `create_project` or `get_project` call |
| **Poll on Timeout** | If `generate_screen_from_text` times out, poll `get_screen` every 30s up to 10 times |
| **Never Retry on Timeout** | Do NOT retry generation — the process may still be running |

---

## Reading Individual Skills

```
c:\New_folder\bus tracking\smart_drive\.claude\skills\stitch\<skill-name>\SKILL.md
```