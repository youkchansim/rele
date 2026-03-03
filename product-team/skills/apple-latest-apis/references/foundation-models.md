# Foundation Models (On-Device LLM)

Apple Intelligence on-device language model.

> All Foundation Models APIs require `@available(iOS 26, *)`.

## Core Pattern

```swift
@available(iOS 26, *)
import FoundationModels

// Availability check (required)
let model = SystemLanguageModel.default
switch model.availability {
case .available: // Show AI UI
case .unavailable(.deviceNotEligible): // Show fallback UI
case .unavailable(.appleIntelligenceNotEnabled): // Guide to Settings
case .unavailable(.modelNotReady): // Downloading
}

// Create session + get response
let session = LanguageModelSession(instructions: "You are a helpful assistant.")
let response = try await session.respond(to: "Question")
print(response.content)  // Use .content (NOT .output)
```

## Guided Generation (Structured Output)

```swift
@available(iOS 26, *)
@Generable(description: "Cat profile")
struct CatProfile {
    var name: String
    @Guide(description: "Age", .range(0...20))
    var age: Int
}

let response = try await session.respond(to: "Structured query", generating: CatProfile.self)
print(response.content.name)  // Type-safe access
```

## Streaming (Snapshot Method)

```swift
@available(iOS 26, *)
let stream = session.streamResponse(to: prompt, generating: TripIdeas.self)
for try await partial in stream {
    // partial is PartiallyGenerated<TripIdeas> — all properties are Optional
}
```

## Limitations
- Token limit: 4,096 tokens per session (~12,000 characters)
- No concurrent requests: check `session.isResponding` first
- Split large data across multiple sessions
