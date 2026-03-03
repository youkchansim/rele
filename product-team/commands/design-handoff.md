---
description: Generate design-to-developer handoff document with analytics event integration
argument-hint: Feature to hand off (e.g., "AI recommendation card", "new settings screen")
---

# Design-Developer Handoff

Designer creates UI/UX, Developer verifies technical feasibility, Analyst integrates analytics events.

**Target Feature**: $ARGUMENTS

---

## Phase 1: Design

### Designer
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

---

## Phase 2: Technical Verification (Parallel)

### iOS Developer
> Review the designer's specification from a technical perspective:
> [Pass Phase 1 design results]
> 1. Search existing codebase for reusable components
> 2. Verify feasibility (identify impossible or overly complex designs)
> 3. Evaluate performance impact (heavy animations, large images, etc.)
> 4. Propose integration approach with existing architecture
> 5. Suggest optimal implementation using SwiftUI Expert/Swift Concurrency references
> 6. Estimate effort

### Data Analyst
> Design analytics events for this feature:
> [Pass Phase 1 design results]
> 1. Apply 3-Question filter to determine needed events
> 2. Events for screen display, user actions, completion/failure steps
> 3. Object_Action naming, property definitions
> 4. Check for overlap with existing events

---

## Phase 3: Handoff Document

Compile all results into a handoff document.

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
