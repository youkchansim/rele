# Other SwiftUI Updates (iOS 26)

> All APIs below require `@available(iOS 26, *)`.

## Customizable Toolbar

```swift
@available(iOS 26, *)
ToolbarItemGroup {
    ToolbarItem { /* ... */ }
}
.toolbarCustomizable()
```

## WebView Integration

```swift
@available(iOS 26, *)
import WebKit
WebView(url: URL(string: "https://example.com")!)
// Execute JavaScript
webPage.callJavaScript("document.title")
```

## Styled Text Editing

```swift
@available(iOS 26, *)
@State var text = AttributedString("Hello")
TextEditor(text: $text, selection: $selection)
// Apply styles to selection range
text.transformAttributes(in: range) { attrs in
    attrs.font = .boldSystemFont(ofSize: 16)
}
```

## Swift Charts 3D

```swift
@available(iOS 26, *)
Chart3D { SurfacePlot(data) { ... } }
    .chart3DPose(ChartPose(azimuth: 45, elevation: 30))
```
