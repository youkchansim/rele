---
description: Get quick opinions from PO A/B on an idea
argument-hint: Idea you need opinions on (e.g., "add widgets", "improve onboarding")
---

# Ask PO

Get quick opinions from PO A (Data-Driven) and PO B (Intuitive) on an idea.

**Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("ask-po")`
2. Spawn both PO agents **simultaneously** via Agent tool with `team_name: "ask-po"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create tasks:

```
TaskCreate: "PO-A Data Perspective Opinion" — PO-A provides opinion from data/business perspective
TaskCreate: "PO-B User Perspective Opinion" — PO-B provides opinion from user/market perspective
TaskCreate: "Lead Opinion Summary" — Lead summarizes both opinions (blockedBy: [1, 2])
```

Assign Task 1 to PO-A, Task 2 to PO-B.

---

## Round 1: Gather Opinions (Parallel)

### PO-A Task (SendMessage)
> Provide a brief opinion on the following idea from a data/business perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. Assess business impact intuition
> 3. ICE intuition scores (1-10 each, one-line rationale)
> 4. Recommended direction (Proceed / Hold / Needs Validation)
> 5. Keep it concise (under 500 characters)

### PO-B Task (SendMessage)
> Provide a brief opinion on the following idea from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Assess user needs fit
> 3. Competitor reference (any similar features?)
> 4. Recommended direction (Proceed / Hold / Needs Validation)
> 5. Keep it concise (under 500 characters)

---

## Summary

When Lead receives opinions from PO-A and PO-B (start Task 3):

```markdown
# Quick PO Opinion: [Topic]

## PO A (Data) Opinion
[Summary]
- ICE intuition: I=? C=? E=? (Total ?)
- Recommendation: [Proceed / Hold / Needs Validation]

## PO B (Intuitive) Opinion
[Summary]
- Recommendation: [Proceed / Hold / Needs Validation]

## Synthesis
- **Agreement**: [Areas both sides agree on]
- **Disagreement**: [Areas where opinions differ]
- **Recommended Direction**: [Lead's overall judgment]
```

---

## Follow-up Options

Include the following at the end of the summary:

> **Next Step Options:**
> - Deeper discussion → `/po-debate "$ARGUMENTS"`
> - Full pipeline → `/product-pipeline "$ARGUMENTS"`

---

## Cleanup

1. Send `shutdown_request` to all teammates (SendMessage type: "shutdown_request")
2. Confirm `shutdown_response`
3. Call `TeamDelete`
