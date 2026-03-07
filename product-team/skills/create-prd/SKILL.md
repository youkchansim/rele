---
name: create-prd
description: >
  This skill should be used when creating Product Requirements Documents, writing feature specs,
  or structuring product proposals with risk analysis.
  Useful for "create PRD", "write product spec", "feature requirements document",
  "product requirements", "pre-mortem analysis", "risk assessment for feature".
user-invocable: false
---

# Create PRD

Comprehensive Product Requirements Document template with pre-mortem risk analysis.

## 8-Section PRD Template

### Section 1: Executive Summary

State the problem, proposed solution, and expected impact in 3-4 sentences.

```markdown
## Executive Summary

**Problem:** [What user problem are we solving? Include evidence — user complaints, data, support tickets.]
**Solution:** [One-sentence description of what we're building.]
**Impact:** [Expected business outcome — metric improvement, revenue impact, user growth.]
**Timeline:** [High-level estimate — weeks, not days.]
```

### Section 2: Background & Context

Provide the context needed for anyone to understand why this feature matters now.

```markdown
## Background & Context

### Market Context
[Industry trends, competitive landscape, market timing — why now?]

### User Feedback
[Summarize relevant user feedback — App Store reviews, support tickets, survey results, community discussions.]

### Competitive Landscape
[What are competitors doing in this space? Direct and indirect competitors.]

### Internal Context
[Previous attempts, related features, technical foundation that enables this work.]
```

### Section 3: Objectives & Key Results

Define one primary objective and 2-3 measurable key results.

```markdown
## Objectives & Key Results

**Primary Objective:** [One clear sentence — what does success look like?]

| Key Result | Metric | Current | Target | Timeline |
|-----------|--------|---------|--------|----------|
| KR1 | [Metric name] | [Baseline] | [Target] | [By when] |
| KR2 | [Metric name] | [Baseline] | [Target] | [By when] |
| KR3 | [Metric name] | [Baseline] | [Target] | [By when] |

**North Star Connection:** [How does this objective connect to the product's North Star metric?]
```

### Section 4: Target Users

Define primary and secondary personas with concrete characteristics.

```markdown
## Target Users

### Primary Persona
- **Who:** [Description — role, demographics, behavior pattern]
- **Pain point:** [Specific problem this persona faces]
- **Current workaround:** [How they solve this today]
- **Success criteria:** [What "solved" looks like for this persona]

### Secondary Persona
- **Who:** [Description]
- **Pain point:** [Specific problem]
- **How they benefit:** [Secondary value from this feature]

### Anti-Persona (Who This Is NOT For)
- **Who:** [Description of users we are explicitly not designing for]
- **Why excluded:** [Reason — scope control, different needs]
```

### Section 5: User Stories & Scenarios

Structured user stories following the standard format.

```markdown
## User Stories & Scenarios

### Must-Have Stories
| ID | As a... | I want to... | So that... | Acceptance Criteria |
|----|---------|-------------|-----------|-------------------|
| US-1 | [persona] | [action] | [benefit] | [testable criteria] |
| US-2 | [persona] | [action] | [benefit] | [testable criteria] |

### Should-Have Stories
| ID | As a... | I want to... | So that... | Acceptance Criteria |
|----|---------|-------------|-----------|-------------------|
| US-3 | [persona] | [action] | [benefit] | [testable criteria] |

### Key Scenario
**Scenario:** [Name]
1. [Step 1 — user context and entry point]
2. [Step 2 — primary action]
3. [Step 3 — system response]
4. [Step 4 — user outcome and exit point]
```

### Section 6: Solution Design

High-level approach without prescribing implementation details.

```markdown
## Solution Design

### High-Level Approach
[2-3 paragraphs describing the solution direction. Focus on what, not how.]

### Key Screens / Flows
[List the primary screens or user flows. Can include rough wireframe descriptions.]
1. **[Screen/Flow 1]:** [Description of what user sees and does]
2. **[Screen/Flow 2]:** [Description]
3. **[Screen/Flow 3]:** [Description]

### Technical Considerations
- **Data model changes:** [New entities, relationships, or schema changes needed]
- **API/Integration needs:** [External services, platform APIs required]
- **Performance requirements:** [Response time, offline support, sync considerations]
- **Platform constraints:** [iOS version requirements, device support, accessibility]

### What This Is NOT
[Explicitly state what is out of scope to prevent scope creep.]
- [Out of scope item 1]
- [Out of scope item 2]
```

### Section 7: Open Questions & Risks

Capture unresolved questions and apply pre-mortem risk analysis.

```markdown
## Open Questions

| # | Question | Owner | Deadline | Status |
|---|---------|-------|----------|--------|
| 1 | [Question] | [Who will answer] | [By when] | Open/Resolved |
| 2 | [Question] | [Who] | [By when] | Open/Resolved |
```

**Pre-mortem risk analysis is detailed separately below.**

### Section 8: Timeline & Milestones

Break the work into phases with clear deliverables.

```markdown
## Timeline & Milestones

| Phase | Deliverable | Duration | Dependencies |
|-------|-----------|----------|-------------|
| Phase 1: Foundation | [Core data model, basic UI] | [X weeks] | None |
| Phase 2: Core Feature | [Primary user flow complete] | [X weeks] | Phase 1 |
| Phase 3: Polish | [Edge cases, animations, accessibility] | [X weeks] | Phase 2 |
| Phase 4: Launch | [App Store submission, monitoring] | [X weeks] | Phase 3 |

### Launch Criteria
- [ ] All must-have user stories complete
- [ ] Performance benchmarks met
- [ ] Accessibility audit passed
- [ ] Analytics events instrumented
```

---

## Pre-Mortem Risk Analysis

The pre-mortem imagines the feature has already failed and works backward to identify why. Risks are categorized into three types:

### Tiger
Real, identified risks with known impact. These are concrete, specific, and actionable.

**Characteristics:**
- You can name the specific failure mode
- The probability and impact are estimable
- A mitigation plan can be written today

**Response:** Create contingency plans. Assign owners. Monitor leading indicators.

**Example:** "If App Store review rejects the notification permission usage, launch is delayed by 1-2 weeks."

### Paper Tiger
Perceived risks that seem scary but are manageable upon closer examination.

**Characteristics:**
- The risk feels large but has low actual probability
- Past experience or data suggests it's unlikely
- Worrying about it costs more than the risk itself

**Response:** Acknowledge the concern, document why it's manageable, and monitor without over-investing.

**Example:** "Users might be confused by the new navigation — but we're adding a progressive onboarding flow, and our last navigation change had no measurable retention impact."

### Elephant
Large, uncomfortable risks that everyone sees but nobody wants to discuss openly.

**Characteristics:**
- People avoid bringing it up in meetings
- It often involves organizational or strategic issues, not just technical ones
- Ignoring it won't make it go away

**Response:** Force explicit discussion. Write it down. Assign an owner even if the mitigation is uncertain.

**Example:** "We don't actually know if our target users want this feature — our evidence is based on 3 support tickets and an assumption."

### Risk Assessment Template

```markdown
## Pre-Mortem Risk Analysis

"It is 3 months from now. This feature has failed. Why?"

| # | Risk | Category | Likelihood | Impact | Mitigation |
|---|------|----------|-----------|--------|------------|
| 1 | [Risk statement] | Tiger | H/M/L | H/M/L | [Specific action] |
| 2 | [Risk statement] | Paper Tiger | H/M/L | H/M/L | [Monitor/accept] |
| 3 | [Risk statement] | Elephant | H/M/L | H/M/L | [Force discussion] |

### Top Risks Requiring Immediate Action
1. **[Risk #]:** [Action] — Owner: [Name] — By: [Date]
```

---

## Full PRD Template

```markdown
# PRD: [Feature Name]
Version: 1.0
Date: YYYY-MM-DD
Author: [Name]
Status: Draft / In Review / Approved

---

## 1. Executive Summary
**Problem:**
**Solution:**
**Impact:**
**Timeline:**

## 2. Background & Context
### Market Context
### User Feedback
### Competitive Landscape
### Internal Context

## 3. Objectives & Key Results
**Primary Objective:**

| Key Result | Metric | Current | Target | Timeline |
|-----------|--------|---------|--------|----------|

**North Star Connection:**

## 4. Target Users
### Primary Persona
### Secondary Persona
### Anti-Persona

## 5. User Stories & Scenarios
### Must-Have Stories
### Should-Have Stories
### Key Scenario

## 6. Solution Design
### High-Level Approach
### Key Screens / Flows
### Technical Considerations
### What This Is NOT

## 7. Open Questions & Risks
### Open Questions
### Pre-Mortem Risk Analysis

## 8. Timeline & Milestones
### Launch Criteria
```

---

## Quality Checklist

Before submitting a PRD for review, verify:

- [ ] Problem clearly defined with evidence (not just assumption)?
- [ ] Success metrics are measurable and time-bound?
- [ ] User stories cover primary use cases?
- [ ] Technical feasibility validated?
- [ ] Risks categorized (Tiger / Paper Tiger / Elephant)?
- [ ] Scope appropriate for solo developer?
- [ ] Connected to North Star metric?
- [ ] Open questions have owners and deadlines?
