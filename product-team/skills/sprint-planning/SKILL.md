---
name: sprint-planning
description: >
  This skill should be used when planning sprints, organizing backlogs,
  setting sprint goals, or scheduling tasks for a development cycle.
  Useful for "plan next sprint", "organize backlog", "sprint goal setting",
  "weekly planning", "task scheduling", "estimate sprint capacity".
---

# Sprint Planning

Shared skill for the entire team. Solo iOS developer-optimized 1-2 week sprint planning.

## Sprint Structure

```markdown
# Sprint: [Title] (YYYY-MM-DD ~ YYYY-MM-DD)

## Goal
**Sprint Goal**: [Define in one sentence]
**North Star Connection**: [Which core metric does this serve]

## Metric Targets
| Metric | Current | Target | Measurement |
|--------|---------|--------|------------|
| [KPI 1] | | | |
| [KPI 2] | | | |

## Backlog

### Must Have (Required this sprint)
| # | Task | Est. Effort | Perspective | Status |
|---|------|------------|-----------|--------|
| 1 | | [h/d] | [PO/Design/Dev/Data/Mkt] | [ ] |

### Nice to Have (If time permits)
| # | Task | Est. Effort | Perspective |
|---|------|------------|-----------|
| 1 | | [h/d] | |

### Won't Do (Excluded this sprint, with reason)
| # | Task | Exclusion Reason |
|---|------|-----------------|
| 1 | | |

## Schedule

### Week 1
| Day | Main Work | Deliverable |
|-----|----------|------------|
| Mon | | |
| Tue | | |
| Wed | | |
| Thu | | |
| Fri | Mid-sprint check | |

### Week 2 (if 2-week sprint)
| Day | Main Work | Deliverable |
|-----|----------|------------|
| Mon | | |
| ... | | |
| Fri | Sprint review | |

## Risks
| Risk | Impact | Mitigation |
|------|--------|-----------|
| [Risk 1] | High/Med/Low | [Response] |

## Success Criteria
- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]
```

## Planning Workflow

### Phase 1: Context Gathering
1. Check North Star metrics and current state in CLAUDE.md
2. Review previous sprint results (`docs/sprints/` latest)
3. Check unresolved decisions (`docs/decisions/`)

### Phase 2: Goal Setting
1. Identify areas needing improvement from current metrics
2. Set achievable goals for 1-2 weeks
3. Explicitly connect to North Star

### Phase 3: Backlog Construction
1. Collect tasks from each team member's perspective
2. Prioritize by ICE score
3. Factor in solo-developer constraints (40 hours/week)
4. Classify as Must/Nice/Won't

### Phase 4: Schedule Allocation
1. Determine order based on dependencies
2. Follow design -> implementation -> testing -> deploy flow
3. Include buffer time (fill only 80% of capacity)

## Solo Developer Optimization

- **Actual coding per week**: 20-25 hours (rest for planning/review/deploy)
- **Task size**: Split into 4-hour maximum units
- **WIP limit**: Max 2 concurrent tasks
- **Demo-ready units**: Each task produces a visible result

## Deliverable

Save sprint document to `docs/sprints/YYYY-MM-DD-sprint.md`.
