# Swift 6.2 Concurrency Updates

"Approachable Concurrency" — single-threaded by default, opt-in to concurrency.

## Key Changes

```swift
// Swift 6.2: async functions continue on the calling actor (previously: auto-offloaded to background)
// -> Reduces data race errors

// Default Actor Isolation mode (enable in build settings)
// -> All code defaults to @MainActor isolation
// -> @MainActor annotations can be omitted
```

## Isolated Conformances

```swift
// When a @MainActor type implements a nonisolated protocol
@available(iOS 26, *)
extension StickerModel: @MainActor Exportable {
    func export() { photoProcessor.exportAsPNG() }
}
```

## @concurrent for Background Offloading

```swift
nonisolated struct PhotoProcessor {
    @concurrent
    func process(data: Data) async -> ProcessedPhoto? { ... }
}
// Usage
processedPhotos[id] = await PhotoProcessor().process(data: data)
```

## Migration Summary
1. Enable Default Actor Isolation -> most `@MainActor` annotations can be removed
2. Use `@concurrent` + `nonisolated` explicitly when background execution is needed
3. Activate in Xcode Build Settings under Swift Compiler - Concurrency
