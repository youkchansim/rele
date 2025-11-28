---
name: design-pattern-architect
description: Systematically analyzes design problems and recommends appropriate patterns while preventing over-engineering. Use when designing new features, refactoring complex code, evaluating architectural decisions, or orchestrating design→implementation→review workflows.
---

# Design Pattern Architect

## Overview

This skill systematically analyzes requirements, identifies design problems, and applies appropriate design patterns or their variations to create effective software designs.

**Core Philosophy**:
- Design patterns are **starting points**, not **absolute answers**
- Patterns can and should be **modified** to fit the context
- Always **explicitly state** why a pattern was chosen and what problem it solves
- **Simplicity over complexity** - avoid over-engineering
- **Pattern-less design is valid** - not every problem needs a pattern

**Language Convention**:
- All design documents: Written in **English**
- All output/communication to user: **Match input language**
  - Korean input (한글) → Korean output
  - English input → English output
  - Other languages → Respond in same language

**Language-Agnostic Approach**:
- Patterns are **concepts**, not language-specific implementations
- Code examples use Swift for clarity, but principles apply to all OOP languages
- Same pattern structure works in Java, C#, TypeScript, Python, Kotlin, etc.
- Focus on understanding **why** and **when**, not just **how**

## Design Process

### Phase 1: Requirements Analysis & Problem Definition

Classify requirements, identify design problems (frequent changes, extensibility needs, coupling, complexity), assess constraints (performance, team expertise, time pressure), and check if straightforward approach suffices before considering patterns.

### Phase 2: Object-Oriented Principles Review

Apply SOLID analysis (SRP, OCP, LSP, ISP, DIP). Identify where principles might be broken, assess consequences, and prefer simple refactoring over pattern application when sufficient.

### Phase 3: Pattern Selection & Design (If Needed)

Load `references/pattern-selection.md`, identify candidate patterns, evaluate over-engineering risk (unnecessary complexity, team understanding, maintenance cost), score patterns by Problem-Fit/Simplicity/Team-Familiarity/Future-Proof, and decide: pattern selected, pattern modified, or no pattern. Focus on when to use, when NOT to use, and trade-offs. Consider platform alternatives.

### Phase 4: Design Documentation

Use `assets/templates/design-document.md`. Document: Problem Statement (what and why), Approach Decision (simple vs pattern, rationale), Solution Design (pattern/architecture, key components), Trade-offs (gains, sacrifices, risks), and Anti-Patterns Avoided. All in English.

### Phase 5: Workflow Handoff (For Multi-Stage Tasks)

Prepare context (design decisions, pattern rationale, constraints, deviations) and handoff to next stage: Implementation (component responsibilities, constraints), Code Review (design rationale for verification), or Architecture Review (decisions and trade-offs). Ensure continuity for seamless Design → Implementation → Review workflow.

### Phase 6: Output to User (Dynamic Language)

Detect input language and match output language. Communicate: problem summary, chosen approach, rationale, trade-offs, next steps, and handoff summary (if multi-stage).

## Guidelines

### Do's
- **Always question pattern necessity**: "Do I really need a pattern here?"
- **Start simple, evolve if needed**: Begin with straightforward design
- **Document the 'why'**: Every design decision needs clear reasoning
- **Consider maintenance**: Who will maintain this? Do they understand it?
- **Embrace pattern variations**: Patterns are guidelines, not rigid rules
- **Acknowledge simplicity**: It's okay to say "no pattern needed"

### Don'ts
- **Don't pattern-first**: Never start with "I'll use Factory pattern"
- **Don't over-engineer**: More patterns ≠ better design
- **Don't cargo-cult**: Don't use patterns just because they're popular
- **Don't ignore context**: Same problem in different contexts may need different solutions
- **Don't skip trade-off analysis**: Every pattern has costs

## Over-Engineering Detection

Calculate weighted score (sum of Yes answers × weight):
- **YAGNI** (35%): Solving problems that don't exist yet?
- **Team-Readiness** (25%): Team will struggle to maintain?
- **Necessity** (20%): Works acceptably without pattern?
- **Clarity** (15%): Pattern makes code harder to understand?
- **Time-Cost** (5%): Implementation time not worth benefit?

**Decision**: < 35% = appropriate ✅ | 35-50% = review ⚠️ | > 50% = simplify ❌

## Reference Files

Load only when needed during the design process:

- **Pattern Selection Guide**: `references/pattern-selection.md`
  - Problem → Pattern mapping
  - Decision trees for pattern selection
  - Simple alternatives to patterns
  - Red flags for over-engineering

**Note**: Claude already knows all GoF patterns, SOLID principles, and common anti-patterns. Reference files are minimal and focus only on decision-making guidance.

## Templates

- **Design Document**: `assets/templates/design-document.md`
- **Pattern Analysis**: `assets/templates/pattern-analysis.md`

## Examples

Real-world examples in `assets/examples/`:
- Simple approach chosen over pattern
- Pattern applied and modified
- Pattern avoided (over-engineering case)
