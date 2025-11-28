# claude-md-manager

Optimized CLAUDE.md structure generator for any project.

## What it does

Analyzes your project and creates token-efficient CLAUDE.md with @ import syntax:

```markdown
# YourProject

Description (SwiftUI + TCA)

## Documentation

@.claude/docs/coding-standards.md
@.claude/docs/architecture.md
@DESIGN_GUIDELINES.md

## Critical Rules

- AI responses: Korean
```

## Commands

| Command | Trigger | Description |
|---------|---------|-------------|
| **init** | "CLAUDE.md 초기화" | Create optimal structure from scratch |
| **analyze** | "CLAUDE.md 분석" | Analyze and report optimization opportunities |
| **optimize** | "CLAUDE.md 최적화" | Convert existing to @ import structure |
| **add** | "문서 추가" | Add new doc with @ import |

## Key Features

- **Dynamic generation** - No fixed templates, analyzes your actual project
- **Reuses existing docs** - Links to DESIGN_GUIDELINES.md, README.md, etc.
- **Token efficient** - Main file ~20 lines, details in @ imports
- **Multi-stack support** - iOS, Android, Web, Backend

## Installation

```bash
# Add to your Claude skills
cp -r claude-md-manager ~/.claude/skills/
```

Or reference from rele marketplace.

## Usage Examples

```
# New project
> CLAUDE.md 초기화해줘

# Existing project with bloated CLAUDE.md
> CLAUDE.md 최적화해줘

# Check current state
> CLAUDE.md 분석해줘

# Add specific doc
> deployment 문서 추가해줘
```

## How it works

1. **Scan** - Detects tech stack, tools, existing docs
2. **Analyze** - Determines what documents are needed
3. **Decide** - Reuse existing vs create new
4. **Generate** - Creates optimized structure with @ imports

## Requirements

- Claude Code
- Project with identifiable tech stack

## License

MIT
