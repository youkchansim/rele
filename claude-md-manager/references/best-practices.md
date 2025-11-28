# CLAUDE.md Best Practices

## @ Import Syntax

### Basic Usage

```markdown
# In CLAUDE.md
@.claude/docs/coding-standards.md
@docs/architecture.md
@DESIGN_GUIDELINES.md
```

### Path Types

| Path | Example | Use Case |
|------|---------|----------|
| Relative | `@docs/file.md` | Project files |
| .claude | `@.claude/docs/file.md` | Claude-specific docs |
| Home | `@~/.claude/file.md` | Personal global docs |

### Behavior

- **Dynamic loading**: Files loaded on-demand, not at session start
- **Recursive support**: Up to 5 levels deep
- **Session persistence**: Once loaded, stays in context

### Known Limitations

⚠️ **Global CLAUDE.md bug**: @ imports in `~/.claude/CLAUDE.md` may not work properly. Use project-level CLAUDE.md for @ imports.

⚠️ **Code blocks**: @ symbols inside markdown code blocks are NOT parsed as imports (intentional).

---

## Token Optimization

### Target Metrics

| Component | Target | Max |
|-----------|--------|-----|
| Main CLAUDE.md | ~300 tokens | 500 tokens |
| Per @ doc | ~500-1000 tokens | 2000 tokens |
| Total loaded per task | <3000 tokens | 5000 tokens |

### What Goes Where

**Main CLAUDE.md (Always Loaded)**:
- Project name + one-line description
- @ import references
- 3-5 critical rules maximum
- Response language preference

**@ Import Documents (On-Demand)**:
- Detailed coding standards
- Architecture explanations
- Build/test commands
- Deployment guides
- Design system details

### Anti-Patterns

❌ Full code examples in main CLAUDE.md
❌ Complete architecture docs inline
❌ Duplicating existing README content
❌ Listing all project files
❌ Verbose explanations

✅ Brief rule statements
✅ @ imports for details
✅ Links to existing docs
✅ Concise critical rules

---

## Directory Structure

### Recommended

```
project/
├── CLAUDE.md                 # Main file (~20 lines)
├── .claude/
│   └── docs/
│       ├── coding-standards.md
│       ├── architecture.md
│       ├── commands.md
│       └── deployment.md
└── [existing docs remain in place]
```

### Alternative (Existing Docs)

```
project/
├── CLAUDE.md                 # @ imports existing
├── DESIGN_GUIDELINES.md      # Referenced via @
├── docs/
│   └── architecture.md       # Referenced via @
└── .claude/
    └── docs/
        └── commands.md       # Only new docs here
```

---

## Document Categories

### coding-standards.md

Should contain:
- Language-specific conventions
- Framework patterns (SwiftUI, React, etc.)
- Naming conventions
- File organization rules
- Do's and Don'ts with brief examples

### architecture.md

Should contain:
- Layer structure diagram (text-based)
- Key patterns (TCA, MVVM, etc.)
- Data flow description
- Important files and purposes
- Dependency overview

### commands.md

Should contain:
- Build commands (debug/release)
- Test commands
- Lint commands
- Dependency management
- Quick reference table

### deployment.md

Should contain:
- CI/CD workflow triggers
- Manual deployment commands
- Required secrets/credentials list
- Environment setup
- Troubleshooting common issues

---

## Quality Checklist

Before finalizing CLAUDE.md:

- [ ] Main file < 30 lines
- [ ] All detailed content uses @ import
- [ ] Critical rules are truly critical (3-5 max)
- [ ] No duplicate content with existing docs
- [ ] All @ paths are valid
- [ ] Response language is specified
- [ ] Tech stack is mentioned in description
