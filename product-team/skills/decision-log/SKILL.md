---
name: decision-log
description: >
  This skill should be used when recording product decisions, documenting
  debate outcomes, or tracking Go/No-Go results in ADR format.
  Useful for "record this decision", "log debate result", "document Go/No-Go",
  "save decision", "create decision record", "what did we decide about".
user-invocable: false
---

# Decision Log

Shared skill for the entire team. Document decisions in ADR (Architecture Decision Record) format.

## Record Format

```markdown
# Decision: [Title]

**Date**: YYYY-MM-DD
**Status**: [Proposed / Accepted / Deprecated / Superseded by [link]]
**Participants**: [Relevant team member roles]

## Context
[Why was this decision needed? Background and problem situation]

## Options Considered

### Option A: [Name]
- **Pros**: [List]
- **Cons**: [List]
- **Risks**: [List]
- **Supported by**: [Which team member and why]

### Option B: [Name]
- **Pros**: [List]
- **Cons**: [List]
- **Risks**: [List]
- **Supported by**: [Which team member and why]

## Decision
[Final choice and reasoning]

## Rules Applied
[Which consensus principle was used]
- [ ] Data clear -> Data wins
- [ ] Data insufficient -> MVP validation
- [ ] Low risk -> Try intuition
- [ ] High risk -> Conservative approach

## Consequences
- **Positive**: [Expected good outcomes]
- **Negative**: [Trade-offs to accept]
- **Follow-ups**: [Additional work needed from this decision]

## Success Metrics
- [How to judge if this decision was right]
- [Measurement method and timeline]
```

## When to Record

Record decisions in these situations:
1. **PO Debate Results** — After `po-debate` command completes
2. **Feature Go/No-Go** — After `feature-review` command completes
3. **Technical Choices** — Architecture, library, or API selection
4. **Strategy Changes** — North Star, target users, pricing changes
5. **Sprint Goals** — After sprint planning completes

These commands automatically produce decision-worthy outputs. Capture the key decisions from their results using this format.

## Workflow

### 1. Create Record
- Write document using the format above
- Save to `docs/decisions/YYYY-MM-DD-{topic}.md`

### 2. Reference Previous Decisions
- Check related prior decisions before making new ones
- Explicitly supersede if a new decision conflicts with an old one

### 3. Track Outcomes
- Review previous decision outcomes during sprint retrospectives
- Record learning points when results differ from expectations

## Searchable Filenames

Filename conventions for quick searching:
- `YYYY-MM-DD-debate-{topic}.md` — PO debate results
- `YYYY-MM-DD-review-{feature}.md` — Feature review results
- `YYYY-MM-DD-tech-{topic}.md` — Technical choices
- `YYYY-MM-DD-strategy-{topic}.md` — Strategy changes
