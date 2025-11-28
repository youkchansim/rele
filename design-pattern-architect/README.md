# Design Pattern Architect Skill

A systematic software design skill that helps choose appropriate design patterns while avoiding over-engineering.

## Overview

This skill analyzes requirements, identifies design problems, and applies appropriate design patterns **or chooses simpler approaches** when patterns aren't necessary.

**Core Philosophy**:
- **Simplicity first** - No pattern is the best pattern
- **YAGNI** - Don't solve future problems
- **Patterns are tools, not goals** - Use when beneficial, skip when not
- **Context matters** - Same problem, different contexts, different solutions

## Installation

### Method 1: Plugin Marketplace (Recommended)

```bash
/plugin marketplace add youkchansim/architect-skills
/plugin install design-pattern-architect@design-pattern-architect-skills
```

### Method 2: Manual Install

```bash
cp -r design-pattern-architect ~/.claude/skills/
```

## How It Works

### 6-Phase Design Process

```
Phase 1: Requirements Analysis
├─ Identify design problems
├─ Assess constraints
└─ Simplicity check first!

Phase 2: OOP Principles Review
├─ SOLID principles check
└─ Simple refactoring first

Phase 3: Pattern Selection (if needed)
├─ Problem → Pattern mapping
├─ Over-engineering risk assessment
└─ Consider platform alternatives

Phase 4: Design Documentation
└─ Document decisions and trade-offs

Phase 5: Workflow Handoff
└─ Pass context to implementation/review

Phase 6: Output
└─ Respond in user's language
```

### Over-Engineering Detection

Built-in weighted scoring system:

```
Questions (Yes = add %):
├─ YAGNI: Solving future problems? (35%)
├─ Team: Will team struggle? (25%)
├─ Necessity: Works without pattern? (20%)
├─ Clarity: Adds complexity? (15%)
└─ Time: Worth the effort? (5%)

Score > 50%: Simplify! ❌
Score < 35%: Pattern appropriate ✅
```

## File Structure

```
design-pattern-architect/
├── SKILL.md (260 lines)              # Main workflow
├── references/
│   └── pattern-selection.md (328 lines)  # Problem→Pattern mapping
├── assets/
│   ├── templates/
│   │   ├── design-document.md        # Design doc template
│   │   └── pattern-analysis.md       # Pattern evaluation template
│   └── examples/
│       ├── simple-over-pattern.md    # Pattern avoided
│       ├── pattern-applied-modified.md  # Pattern with modifications
│       └── over-engineering-avoided.md  # Over-engineering case
└── README.md                          # This file

Total: ~590 lines of core content
```

## When to Use

✅ **Use when**:
- Designing new features or systems
- Refactoring complex code
- Evaluating architectural decisions
- Need systematic design approach
- Want workflow orchestration (design → implementation → review)

❌ **Don't use when**:
- Writing simple utility functions
- Making trivial changes
- Time-critical quick fixes

## Key Features

### 1. Workflow Orchestration ⭐

Seamless handoff between stages:

```
Design → Implementation → Review
(Context automatically preserved)
```

### 2. Pattern Decision Guide

Maps problems to patterns with alternatives:

```
Problem: Complex object construction
├─ Pattern: Builder
└─ Alternative: Default parameters (if language supports)

Problem: One-to-many notification
├─ Pattern: Observer
└─ Alternative: Platform features (Combine, RxSwift, LiveData)
```

### 3. Language Agnostic

Patterns are concepts, not code:
- Works with any OOP language
- Documentation in English
- Output matches your input language

### 4. Anti-Over-Engineering

Proactive warnings:
- "This pattern might be overkill"
- "Simple if-else would work here"
- "Platform already provides this"

## Quick Example

```
User: "Design a payment system with credit card and PayPal"

Skill Output (in user's language):

Phase 1: Analysis
- Problem: Multiple payment methods
- Constraint: Runtime selection needed

Phase 2: SOLID Check
- Current approach would violate OCP

Phase 3: Pattern Selection
- Candidate: Strategy pattern
- Over-engineering score: 20% ✅ (appropriate)
- Alternative considered: Simple if-else (rejected: hard to extend)

Phase 4: Design
[Provides design document]

Phase 5: Handoff
- Ready for implementation
- Context: 2 payment strategies, extensible for future methods
```

## Pattern Coverage

The skill references all major GoF patterns but focuses on **decision-making**:

**Creational**: Singleton, Factory Method, Abstract Factory, Builder, Prototype
**Structural**: Adapter, Bridge, Composite, Decorator, Facade, Proxy, Flyweight
**Behavioral**: Observer, Strategy, Command, State, Template Method, Chain of Responsibility, Iterator

For each pattern:
- When to use / **When NOT to use** ⭐
- Trade-offs
- Simpler alternatives
- Over-engineering risk level

## Best Practices

### Do's ✅
- Start simple, evolve if needed
- Document the "why"
- Consider team familiarity
- Use platform features first
- Modify patterns to fit context

### Don'ts ❌
- Don't pattern-first (problem-first!)
- Don't solve future problems (YAGNI)
- Don't cargo-cult patterns
- Don't ignore context
- Don't skip trade-off analysis

## Use Cases

### 1. Solo Development
```
"Design a user authentication system"
→ Systematic design + rationale documentation
```

### 2. Team Workflow
```
"Design → Review → Implement authentication"
→ Design handoff to code review → Implementation
```

### 3. Refactoring
```
"Refactor this 500-line function"
→ Pattern necessity check → Simple refactoring suggested
```

### 4. Learning
```
"When should I use Factory vs Builder?"
→ Problem-based comparison with examples
```

## Contributing

This is an open-source skill. Contributions welcome!

1. **Add patterns**: Update `pattern-selection.md`
2. **Add examples**: Create in `assets/examples/`
3. **Improve workflow**: Enhance `SKILL.md` phases

Guidelines:
- Keep files concise (Claude already knows patterns)
- Focus on decision-making, not pattern explanation
- Real-world examples with context
- Follow existing language conventions

## Why This Skill?

**What Claude already knows:**
- ✅ All GoF patterns
- ✅ SOLID principles
- ✅ Anti-patterns

**What this skill adds:**
- ✅ Systematic decision workflow
- ✅ Over-engineering prevention
- ✅ Workflow orchestration (design → dev → review)
- ✅ Context-aware pattern selection
- ✅ Team and project context consideration

## License

MIT License - Use freely for personal or commercial projects.

## Version

**v1.2.0** (2025-11-03)
- Removed redundant pattern catalogs (Claude already knows)
- Added workflow handoff capability
- Streamlined to 590 core lines
- Enhanced over-engineering detection

---

**Remember**: The best pattern is often the one you don't need.
