---
name: apple-latest-apis
description: >
  This skill should be used when implementing latest Apple APIs for iOS 26 / Xcode 26.
  Covers Liquid Glass, Swift 6.2 concurrency, Foundation Models, SwiftData inheritance,
  AlarmKit, StoreKit updates, and other new SwiftUI features.
  Useful for "use Liquid Glass", "Foundation Models on-device AI", "Swift 6.2 concurrency changes",
  "SwiftData inheritance", "AlarmKit timers", "StoreKit subscription updates".
user-invocable: false
---

# Apple Latest API Reference

iOS 26 / Xcode 26 curated implementation guide. Based on Apple's Xcode Intelligence documentation.

All APIs below require `@available(iOS 26, *)` guard patterns.

---

## 1. Liquid Glass
Dynamic glass material for SwiftUI — `.glassEffect()`, `.buttonStyle(.glass)`, `GlassEffectContainer`, merging/morphing.
See `references/liquid-glass.md` for details.

## 2. Swift 6.2 Concurrency
"Approachable Concurrency" — Default Actor Isolation, `@concurrent`, Isolated Conformances.
See `references/swift-concurrency-6-2.md` for details.

## 3. Foundation Models (On-Device LLM)
Apple Intelligence on-device language model — `LanguageModelSession`, `@Generable`, Snapshot Streaming.
See `references/foundation-models.md` for details.

## 4. SwiftData Class Inheritance
`@Model` class inheritance — type-based filtering, polymorphic relationships.
See `references/swiftdata-inheritance.md` for details.

## 5. AlarmKit
Alarm/countdown timer API — `AlarmManager`, `Alarm`, `CountdownTimer`, Live Activities integration.
See `references/alarmkit.md` for details.

## 6. StoreKit Updates
Multiple entitlements, `SubscriptionOfferView`, `visibleRelationship`.
See `references/storekit-updates.md` for details.

## 7. Other SwiftUI Updates
Customizable toolbars, WebView integration, styled text editing, Swift Charts 3D.
See `references/other-updates.md` for details.
