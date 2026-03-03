# Liquid Glass (iOS 26+)

Dynamic glass material API for SwiftUI.

> All Liquid Glass APIs require `@available(iOS 26, *)`.

## Core API

```swift
@available(iOS 26, *)
// Basic application
Text("Hello").padding().glassEffect()

// Custom shape
Text("Hello").padding().glassEffect(in: .rect(cornerRadius: 16))

// Tint + interactive
Text("Hello").padding().glassEffect(.regular.tint(.orange).interactive())

// Button styles
Button("Action") { }.buttonStyle(.glass)
Button("Primary") { }.buttonStyle(.glassProminent)
```

## Multiple Glass Effects

```swift
@available(iOS 26, *)
// Wrap in GlassEffectContainer for performance optimization + merging/morphing
GlassEffectContainer(spacing: 40) {
    HStack(spacing: 40) {
        view1.glassEffect()
        view2.glassEffect()
    }
}

// Merge multiple views into a single Glass
@Namespace private var ns
view1.glassEffect().glassEffectUnion(id: "group1", namespace: ns)
view2.glassEffect().glassEffectUnion(id: "group1", namespace: ns)

// Morphing transitions (when views are added/removed)
view.glassEffect().glassEffectID("unique-id", in: namespace)
```

## Important Notes
- Always use `GlassEffectContainer` when multiple Glass effects are present
- Apply `.glassEffect()` after other appearance modifiers
- `withAnimation` triggers automatic morphing when the view hierarchy changes
