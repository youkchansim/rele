---
name: claude-md-manager
description: Analyzes projects and creates optimized CLAUDE.md structures with @ import syntax for token efficiency. Dynamically generates documentation based on detected tech stack, existing docs, and project patterns. Use for initializing, analyzing, or optimizing CLAUDE.md in any project.
---

# CLAUDE.md Manager

## Overview

This skill creates and manages optimized CLAUDE.md structures for any project. It analyzes the project's tech stack, existing documentation, and patterns to dynamically generate the most efficient documentation structure.

**Core Philosophy**:
- **No fixed templates** - Generate based on actual project analysis
- **@ import for efficiency** - Minimize always-loaded content
- **Reuse existing docs** - Link to existing documentation instead of duplicating
- **Project-specific** - Each project gets tailored structure

**Language Convention**:
- Documentation files: **English** (for token efficiency and Claude parsing)
- Output to user: **Match input language**

## Commands

### 1. Initialize (`init`)

**Trigger**: "CLAUDE.md 초기화", "CLAUDE.md init", "setup CLAUDE.md"

**Process**:
1. Scan project structure
2. Detect tech stack and tools
3. Find existing documentation
4. Generate optimal structure
5. Create CLAUDE.md with @ imports

### 2. Analyze (`analyze`)

**Trigger**: "CLAUDE.md 분석", "CLAUDE.md analyze", "check CLAUDE.md"

**Process**:
1. Read existing CLAUDE.md
2. Calculate token usage
3. Identify optimization opportunities
4. Check @ import usage
5. Report findings with recommendations

### 3. Optimize (`optimize`)

**Trigger**: "CLAUDE.md 최적화", "CLAUDE.md optimize"

**Process**:
1. Analyze current structure
2. Extract content into modular docs
3. Convert to @ import structure
4. Preserve critical rules in main file

### 4. Add Document (`add`)

**Trigger**: "문서 추가", "add doc [type]"

**Process**:
1. Determine document type needed
2. Analyze project for relevant content
3. Generate document
4. Add @ import to CLAUDE.md

## Analysis Phase

### Step 1: Project Scanning

Detect and analyze:

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
│   ├── Android: fastlane/, gradle
│   ├── Web: webpack, vite, turbo
│   └── CI/CD: .github/workflows/, .gitlab-ci.yml
│
├── Existing Documentation
│   ├── README.md
│   ├── DESIGN_GUIDELINES.md, DESIGN_SYSTEM.md
│   ├── ARCHITECTURE.md, docs/
│   ├── CONTRIBUTING.md
│   └── Any .md files in project root
│
└── Code Patterns
    ├── Architecture: TCA, MVVM, Clean, MVC
    ├── Design System: Asset catalogs, theme files
    └── Testing: test directories, test configs
```

### Step 2: Document Category Mapping

Based on analysis, determine needed documents:

| Category | When to Create | Content Source |
|----------|---------------|----------------|
| `coding-standards` | Always | Analyze code patterns, existing guidelines |
| `architecture` | Complex projects | Detect patterns, existing docs |
| `commands` | Build tools found | Extract from configs |
| `deployment` | CI/CD or fastlane found | Analyze workflow files |
| `design-system` | Design files found | Link to existing or generate |
| `testing` | Test dirs found | Analyze test patterns |
| `api` | Backend/API project | Analyze endpoints |

### Step 3: Reuse vs Create Decision

```
For each document category:
├── Existing doc found?
│   ├── Yes → @ import existing file directly
│   └── No → Generate new doc in .claude/docs/
│
└── Quality check:
    ├── Existing doc comprehensive? → Use as-is
    ├── Needs enhancement? → Create wrapper with @ import
    └── Outdated/poor? → Generate new, suggest migration
```

## Generation Phase

### CLAUDE.md Structure

Always generate in this format:

```markdown
# {ProjectName}

{One-line description with tech stack}

## Documentation

@.claude/docs/coding-standards.md
@.claude/docs/architecture.md
@.claude/docs/commands.md
@{path/to/existing/doc.md}

## Critical Rules

- {Only absolutely critical rules that must always apply}
- {Maximum 3-5 rules}
```

### Document Generation Guidelines

**coding-standards.md**:
- Language/framework specific conventions
- Project-specific patterns (from code analysis)
- Do's and Don'ts with examples
- Link to design system if exists

**architecture.md**:
- Layer structure
- Key patterns used
- Data flow
- Key files and their purposes

**commands.md**:
- Build commands
- Test commands
- Lint commands
- Deployment commands (if no separate deployment.md)

**deployment.md**:
- CI/CD workflows
- Manual deployment steps
- Environment setup
- Required secrets/credentials

## Optimization Metrics

### Token Efficiency Score

Calculate and report:

```
Main CLAUDE.md size:
- Excellent: < 500 tokens (~20 lines)
- Good: 500-1000 tokens (~40 lines)
- Needs optimization: > 1000 tokens

@ Import usage:
- All detailed docs use @ import: ✅
- Some inline content: ⚠️ Review needed
- No @ imports: ❌ Needs restructuring

Content distribution:
- Critical rules only in main: ✅
- Detailed examples in main: ⚠️ Move to docs
- Full guides in main: ❌ Must modularize
```

### Optimization Recommendations

Always check for:
- Duplicate content across files
- Overly detailed main CLAUDE.md
- Missing @ imports for large sections
- Outdated or unused documentation
- Inconsistent structure

## Best Practices Reference

Load `references/best-practices.md` for:
- @ import syntax rules
- Known limitations (global CLAUDE.md bug)
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
3. .claude/docs/architecture.md
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
2. {specific recommendation}
...

## Quick Fixes

- Move {section} to separate doc
- Add @ import for {file}
...
```
