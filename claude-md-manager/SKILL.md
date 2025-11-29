---
name: claude-md-manager
description: Analyzes projects and creates optimized CLAUDE.md structures with @ import syntax for token efficiency. Dynamically generates documentation based on detected tech stack, existing docs, and project patterns. Use for initializing, analyzing, or optimizing CLAUDE.md in any project.
---

# CLAUDE.md Manager

Creates and manages optimized CLAUDE.md structures for any project.

**Language Convention**: Respond in the user's input language.

## Core Philosophy

- **No fixed templates** - Generate based on actual project analysis
- **@ import for efficiency** - Minimize always-loaded content
- **Reuse existing docs** - Link instead of duplicating
- **Project-specific** - Tailored structure for each project

## Commands

### 1. Initialize (`init`)

**Triggers**: "CLAUDE.md init", "setup CLAUDE.md", "create CLAUDE.md"

**Process**:
1. Scan project structure
2. Detect tech stack and tools
3. Find existing documentation
4. Generate optimal structure
5. Create CLAUDE.md with @ imports

### 2. Analyze (`analyze`)

**Triggers**: "CLAUDE.md analyze", "check CLAUDE.md"

**Process**:
1. Read existing CLAUDE.md
2. Calculate token usage
3. Identify optimization opportunities
4. Check @ import usage
5. Report findings with recommendations

### 3. Optimize (`optimize`)

**Triggers**: "CLAUDE.md optimize"

**Process**:
1. Analyze current structure
2. Extract content into modular docs
3. Convert to @ import structure
4. Preserve critical rules in main file

### 4. Add Document (`add`)

**Triggers**: "add doc [type]"

**Process**:
1. Determine document type needed
2. Analyze project for relevant content
3. Generate document
4. Add @ import to CLAUDE.md

## Analysis Phase

### Step 1: Project Scanning

```
Project Root
├── Tech Stack Detection
│   ├── iOS: .xcodeproj, Package.swift, Podfile
│   ├── Android: build.gradle, AndroidManifest.xml
│   ├── Web: package.json, tsconfig.json
│   ├── Backend: requirements.txt, go.mod, Cargo.toml
│   └── Cross-platform: pubspec.yaml, react-native.config.js
│
├── Build Tools Detection
│   ├── iOS: fastlane/, Tuist/, xcodegen
│   ├── Web: webpack, vite, turbo
│   └── CI/CD: .github/workflows/, .gitlab-ci.yml
│
├── Existing Documentation
│   ├── README.md, DESIGN_GUIDELINES.md
│   ├── ARCHITECTURE.md, docs/
│   └── Any .md files in project root
│
└── Code Patterns
    ├── Architecture: TCA, MVVM, Clean, MVC
    └── Design System: Asset catalogs, theme files
```

### Step 2: Document Category Mapping

| Category | When to Create | Content Source |
|----------|---------------|----------------|
| `coding-standards` | Always | Code patterns, existing guidelines |
| `architecture` | Complex projects | Detected patterns, existing docs |
| `commands` | Build tools found | Extract from configs |
| `deployment` | CI/CD or fastlane found | Workflow files |
| `design-system` | Design files found | Link existing or generate |

### Step 3: Reuse vs Create Decision

```
For each document category:
├── Existing doc found?
│   ├── Yes → @ import existing file
│   └── No → Generate in .claude/docs/
│
└── Quality check:
    ├── Comprehensive? → Use as-is
    ├── Needs enhancement? → Create wrapper with @ import
    └── Outdated? → Generate new, suggest migration
```

## Generation Phase

### CLAUDE.md Structure

```markdown
# {ProjectName}

{One-line description with tech stack}

## Documentation

@.claude/docs/coding-standards.md
@.claude/docs/architecture.md
@{path/to/existing/doc.md}

## Critical Rules

- {Maximum 3-5 critical rules}
```

### Document Guidelines

**coding-standards.md**: Language conventions, project patterns, do's/don'ts

**architecture.md**: Layer structure, key patterns, data flow

**commands.md**: Build, test, lint, deployment commands

**deployment.md**: CI/CD workflows, environment setup

## Token Efficiency

### Target Metrics

| Component | Target | Max |
|-----------|--------|-----|
| Main CLAUDE.md | ~300 tokens | 500 tokens |
| Per @ doc | ~500-1000 tokens | 2000 tokens |

### Efficiency Score

```
Main CLAUDE.md size:
- Excellent: < 500 tokens (~20 lines)
- Good: 500-1000 tokens (~40 lines)
- Needs optimization: > 1000 tokens

@ Import usage:
- All detailed docs use @ import: ✅
- Some inline content: ⚠️ Review needed
- No @ imports: ❌ Needs restructuring
```

## Reference Files

Load these as needed:

- **`references/analysis-checklist.md`**: Load when analyzing projects
  - Tech stack detection patterns
  - Build tools and CI/CD detection
  - Documentation quality assessment

- **`references/best-practices.md`**: Load when generating or optimizing
  - @ import syntax rules and limitations
  - Token optimization strategies
  - Directory structure conventions

## Output Format

### Init/Optimize Output

```
## Analysis Results

**Tech Stack**: {detected}
**Existing Docs**: {list}
**Recommended Structure**: {structure}

## Generated Files

1. CLAUDE.md (X lines, ~Y tokens)
2. .claude/docs/coding-standards.md
...

## Summary

- Main file: X tokens (target: <500)
- Total docs: Y files
- Reused existing: Z files
```

### Analyze Output

```
## CLAUDE.md Analysis

**Current Size**: X lines (~Y tokens)
**@ Imports**: Z files
**Efficiency Score**: Good/Needs Work

## Recommendations

1. {specific recommendation}
...

## Quick Fixes

- Move {section} to separate doc
- Add @ import for {file}
```
