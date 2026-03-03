---
description: 3-round structured debate between PO A (Data) and PO B (Intuitive) to reach consensus
argument-hint: Debate topic (e.g., "Should we add AI schedule recommendations?")
---

# PO Debate

PO A (Data-Driven) and PO B (Intuitive) conduct a 3-round structured debate to reach consensus.

**Debate Topic**: $ARGUMENTS

---

## Round 1: Initial Positions (Parallel)

Invoke PO A and PO B agents **in parallel** for independent analysis.

**PO A Prompt**:
> Analyze the following topic from a data perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for current metrics and North Star
> 2. Query RevenueCat/Amplitude MCP for relevant metrics (when available)
> 3. State your for/against position with ICE score and expected business impact
> 4. Support your argument with specific data/numbers

**PO B Prompt**:
> Analyze the following topic from a user/market perspective: "$ARGUMENTS"
> 1. Read project CLAUDE.md for target users and core value
> 2. Analyze related user reactions and competitor apps on Reddit/HN
> 3. State your for/against position from user journey and UX value perspectives
> 4. Support your argument with competitive analysis and community insights

---

## Round 2: Cross-Critique

Pass Round 1 results to each side and request rebuttals.

**To PO A**: Pass PO B's position and request rebuttal
> PO B's position: [Round 1 PO B result]
> Critique this from a data perspective. Specify which of PO B's points you accept and which you rebut.

**To PO B**: Pass PO A's position and request rebuttal
> PO A's position: [Round 1 PO A result]
> Critique this from a user/market perspective. Specify which of PO A's points you accept and which you rebut.

---

## Round 3: Consensus

Synthesize all positions and rebuttals into a consensus.

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
