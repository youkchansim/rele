---
description: 3-round structured debate between PO A (Data) and PO B (Intuitive) to reach consensus
argument-hint: Debate topic (e.g., "Should we add AI schedule recommendations?")
---

# PO Debate

PO A (Data-Driven) and PO B (Intuitive) conduct a 3-round structured debate to reach consensus.

**Debate Topic**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("po-debate")`
2. Spawn both PO agents **simultaneously** via Agent tool with `team_name: "po-debate"`:
   - **PO-A** (product-team:po-data-driven, name: "PO-A")
   - **PO-B** (product-team:po-intuitive, name: "PO-B")
3. Create all tasks with dependencies:

```
Task 1: "PO-A Round 1 초기 입장 표명" — assign to PO-A
Task 2: "PO-B Round 1 초기 입장 표명" — assign to PO-B
Task 3: "PO-A Round 2 교차 비판" — assign to PO-A (blockedBy: [1, 2])
Task 4: "PO-B Round 2 교차 비판" — assign to PO-B (blockedBy: [1, 2])
Task 5: "Lead Round 3 합의 도출" — Lead handles (blockedBy: [3, 4])
```

---

## Round 1: Initial Positions (Parallel)

Send tasks to both POs simultaneously via SendMessage:

### To PO-A:
> Analyze the following topic from a data perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. Query RevenueCat/Amplitude MCP for relevant metrics (when available)
> 3. State your for/against position with ICE score and expected business impact
> 4. Support your argument with specific data/numbers
> When done, send your analysis back to Lead via SendMessage and mark Task 1 as completed.

### To PO-B:
> Analyze the following topic from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Analyze related user reactions and competitor apps on Reddit/HN
> 3. State your for/against position from user journey and UX value perspectives
> 4. Support your argument with competitive analysis and community insights
> When done, send your analysis back to Lead via SendMessage and mark Task 2 as completed.

---

## Round 2: Cross-Critique

When both Task 1 and Task 2 are complete, Lead forwards cross-results via SendMessage:

### To PO-A (SendMessage):
> PO B's position: [Round 1 PO B result summary]
> Critique this from a data perspective. Specify which of PO B's points you accept and which you rebut.
> Mark Task 3 as completed when done.

### To PO-B (SendMessage):
> PO A's position: [Round 1 PO A result summary]
> Critique this from a user/market perspective. Specify which of PO A's points you accept and which you rebut.
> Mark Task 4 as completed when done.

---

## Round 3: Consensus (Lead)

When both Task 3 and Task 4 are complete, Lead synthesizes all positions and rebuttals into a consensus (Task 5).

### Consensus Rules
1. **Data clear** -> Data wins
2. **Data insufficient** -> MVP validation
3. **Low risk** -> Try intuition
4. **High risk** -> Conservative approach

### Consensus Format

```markdown
# PO Debate Result: [Topic]

## Consensus Summary
[One-sentence conclusion]

## PO A Key Arguments
- [Summary]

## PO B Key Arguments
- [Summary]

## Points of Agreement
- [Items both sides agreed on]

## Points of Disagreement
- [Remaining differences + resolution approach]

## Rule Applied
[Which of the 4 rules was applied]

## Next Steps
- [ ] [Specific action item 1]
- [ ] [Specific action item 2]
```

---

## Save Deliverables

Save consensus to the `docs/decisions/` directory.
Filename: `YYYY-MM-DD-debate-{topic-summary}.md`

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to PO-A and PO-B via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
