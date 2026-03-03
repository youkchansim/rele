---
description: Generate design-to-developer handoff document with analytics event integration
argument-hint: Feature to hand off (e.g., "AI recommendation card", "new settings screen")
---

# Design-Developer Handoff

Designer creates UI/UX, Developer verifies technical feasibility, Analyst integrates analytics events.

**Target Feature**: $ARGUMENTS

---

## Setup

1. Create team: `TeamCreate("design-handoff")`
2. Spawn Designer first (Developer and Analyst spawn after Phase 1):
   - **Designer** (product-team:app-designer, name: "Designer")
3. Create initial tasks:

```
Task 1: "Designer UI/UX Design" — assign to Designer
```

Tasks 2-4 are created after Task 1 completes (when Developer and Analyst are spawned).

---

## Phase 1: Design

### To Designer (SendMessage):
> Design the UI/UX for the following feature: "$ARGUMENTS"
> 1. Scan the project's DesignSystem directory for existing tokens/components
> 2. Check Assets.xcassets for Color Sets
> 3. Screen design:
>    - ASCII wireframe
>    - Design tokens to use (colors, fonts, spacing)
>    - Existing components to reuse
>    - New components needed
>    - State-based UI (default, loading, empty, error)
>    - Interaction/animation
> 4. Accessibility check (VoiceOver, Dynamic Type, color contrast)
> 5. Dark mode considerations
> 6. HIG compliance verification
> 7. SwiftUI code snippets (layout structure)
> Mark Task 1 as completed when done.

---

## Phase 2: Technical Verification + Event Design (Parallel)

After Task 1 completes:

1. **Spawn Developer and Analyst** via Agent tool with `team_name: "design-handoff"`. Include Phase 1 design summary in spawn prompts.
   - **Developer** (product-team:ios-developer, name: "Developer")
   - **Analyst** (product-team:data-analyst, name: "Analyst")
2. Create remaining tasks:

```
Task 2: "Developer Technical Verification" — assign to Developer (blockedBy: [1])
Task 3: "Analyst Event Design" — assign to Analyst (blockedBy: [1])
Task 4: "Lead Handoff Document Compile" — Lead handles (blockedBy: [2, 3])
```

### To Developer (included in spawn prompt + SendMessage):
> Review the designer's specification from a technical perspective:
> [Phase 1 design results summary]
> 1. Search existing codebase for reusable components
> 2. Verify feasibility (identify impossible or overly complex designs)
> 3. Evaluate performance impact (heavy animations, large images, etc.)
> 4. Propose integration approach with existing architecture
> 5. Suggest optimal implementation using SwiftUI Expert/Swift Concurrency references
> 6. Estimate effort
> Mark Task 2 as completed when done.

### To Analyst (included in spawn prompt + SendMessage):
> Design analytics events for this feature:
> [Phase 1 design results summary]
> 1. Apply 3-Question filter to determine needed events
> 2. Events for screen display, user actions, completion/failure steps
> 3. Object_Action naming, property definitions
> 4. Check for overlap with existing events
> Mark Task 3 as completed when done.

---

## Phase 3: Handoff Document (Lead)

When Tasks 2 and 3 complete, Lead compiles the handoff document (Task 4):

```markdown
# Design Handoff: [Feature Name]

## UI Design

### Screen Structure
[Wireframe]

### Design Tokens
| Element | Token | Light | Dark |
|---------|-------|-------|------|
| Background | | | |
| Text | | | |
| Accent | | | |

### Components
- Reused: [Existing component list]
- New: [New component specs]

### State-based UI
| State | Description |
|-------|------------|
| Default | |
| Loading | |
| Empty | |
| Error | |

### Interaction
[Animation, gesture, transition descriptions]

### Accessibility
- VoiceOver: [Labels]
- Dynamic Type: [Handling]
- Minimum touch: 44x44pt

## Implementation Guide

### Affected Files
- Modified: [List]
- New: [List]

### SwiftUI Structure
[Code snippets]

### Technical Notes
[Performance, architecture considerations]

### Estimated Effort
[Hours/days]

## Analytics Events

| Event | Trigger | Properties | Connected Metric |
|-------|---------|------------|-----------------|
| | | | |

### Code Placement
[Where to place Logger.log() calls]
```

---

## Save Deliverables

Save handoff document to `docs/decisions/YYYY-MM-DD-handoff-{feature-name}.md`.

Verify `docs/decisions/` directory exists before saving; create if needed.

---

## Cleanup

1. Send `shutdown_request` to Designer, Developer, Analyst via SendMessage
2. Wait for `shutdown_response` confirmations
3. Call `TeamDelete`
