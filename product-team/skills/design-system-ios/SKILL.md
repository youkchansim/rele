---
name: design-system-ios
description: >
  This skill should be used when auditing design system consistency, managing
  design tokens/components, or checking HIG compliance and accessibility.
  Useful for "check design tokens", "audit HIG compliance", "design system audit",
  "review component consistency", "accessibility check".
---

# iOS Design System Management

Designer-exclusive skill. Analyze and maintain the project's design system for consistency.

## Workflow

### Phase 1: Design System Scan

Explore the following paths in the project:
```
**/DesignSystem/**
**/Design/**
**/Theme/**
**/Style/**
**/Components/**
**/Assets.xcassets/**
```

Items to collect:
- **Color tokens**: Color Set names, Light/Dark values
- **Typography**: Font scale, weight definitions
- **Spacing**: Spacing system (4pt/8pt based, etc.)
- **Components**: Reusable SwiftUI View inventory
- **Icons**: SF Symbols usage list + custom icons

### Phase 2: Consistency Audit

```markdown
## Design System Audit Results

### Token Usage
- System color usage: [N views, M compliant]
- Hardcoded colors: [violation list]
- Hardcoded fonts: [violation list]
- Hardcoded spacing: [violation list]

### Component Reuse
- Existing component utilization: [Reusable but re-created items]
- Similar duplicates: [Consolidation candidates]

### HIG Compliance
- [ ] SF Symbols prioritized
- [ ] System colors (.primary, .secondary) used
- [ ] Dynamic Type supported
- [ ] Minimum touch area 44x44pt
- [ ] Safe Area respected
- [ ] Dark mode handled

### Accessibility
- [ ] VoiceOver labels set
- [ ] Color contrast sufficient (4.5:1 or higher)
- [ ] Reduced motion supported (.reduceMotion)
```

### Phase 3: Token Proposals

When new tokens are needed for a feature:

```markdown
### New Token Proposals

| Token Name | Type | Light | Dark | Purpose |
|------------|------|-------|------|---------|
| `Color.featureAccent` | Color | #xxx | #xxx | [Purpose] |
| `Spacing.featureCard` | Spacing | 12pt | - | [Purpose] |
```

### Phase 4: Component Specification

When new components are needed:

```markdown
### Component: [Name]

**Role**: [One-line description]
**Location**: `DesignSystem/Components/[Name].swift`

**Props**:
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| title | String | - | Title |
| style | Style | .default | Style variant |

**State-based UI**:
- Default: [Description]
- Loading: [Description]
- Empty: [Description]
- Error: [Description]

**SwiftUI Structure** (outline):
```swift
struct FeatureCard: View {
    let title: String
    var style: Style = .default

    var body: some View {
        // Layout structure
    }
}
```
```

## SwiftUI Expert References

When SwiftUI Expert skill references are available, consult them for:
- View extraction rules
- Latest API patterns
- iOS 26+ Liquid Glass styling
