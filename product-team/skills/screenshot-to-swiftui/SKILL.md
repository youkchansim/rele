---
name: screenshot-to-swiftui
description: >
  This skill should be used when analyzing app screenshots or design references
  to extract design tokens and generate SwiftUI code. Useful for "analyze this screenshot",
  "replicate this design", "convert screenshot to SwiftUI", "extract design from image",
  "design from reference", "clone this UI", "screenshot to code".
user-invocable: false
---

# Screenshot-to-SwiftUI Analysis

Designer-exclusive skill. Analyze reference screenshots using Claude's multimodal capabilities to extract design tokens and generate SwiftUI code. No Python required.

## Workflow

### Phase 1: Image Analysis

Use the Read tool to view the screenshot image file:

```
Read the image at: [user-provided path]
```

Extract the following from the image:

#### 1.1 Color Extraction
- **Primary color**: The dominant brand/accent color
- **Secondary colors**: Supporting colors
- **Background**: Main background color (light/dark)
- **Surface**: Card/container background
- **Text colors**: Primary, secondary, tertiary text

> **Important**: Color hex values are **estimates** based on visual analysis.
> Always recommend verification with a color picker tool (e.g., Digital Color Meter on macOS).

#### 1.2 Typography Analysis
- **Heading style**: Weight, approximate size, letter spacing
- **Body style**: Weight, approximate size, line height
- **Caption/label style**: Weight, size
- **Font family inference**: SF Pro (default), serif, rounded, monospace

#### 1.3 Layout Structure
- **Navigation pattern**: NavigationStack, TabView, custom
- **Content layout**: List, grid, scroll, stacked
- **Spacing rhythm**: Tight (4pt), standard (8pt), relaxed (16pt)
- **Safe area usage**: Edge-to-edge or inset

#### 1.4 Component Inventory
List every distinct UI component visible:
- Cards, buttons, icons, inputs, toggles, etc.
- Note their approximate dimensions and styling

#### 1.5 Visual Effects
- **Shadows**: Soft, elevated, none
- **Corner radius**: Sharp (0-4pt), medium (8-12pt), rounded (16-24pt), pill
- **Materials/blur**: Glass, ultra-thin, regular material
- **Animations**: Any implied motion (carousel indicators, progress, etc.)

### Phase 2: Design Token Generation

Convert extracted analysis into structured tokens:

```markdown
## Extracted Design Tokens

### Colors (Estimated — verify with color picker)
| Role | Light Mode | Dark Mode (inferred) | SwiftUI Token |
|------|-----------|---------------------|---------------|
| Primary | #XXXXXX | #XXXXXX | `Color.primaryApp` |
| Background | #XXXXXX | #XXXXXX | `Color.backgroundPrimary` |
| Surface | #XXXXXX | #XXXXXX | `Color.surfacePrimary` |
| Text Primary | #XXXXXX | #XXXXXX | `Color.textPrimary` |

### Typography
| Style | Font | Weight | Size | SwiftUI |
|-------|------|--------|------|---------|
| Heading | SF Pro | Bold | ~24pt | `.title2.bold()` |
| Body | SF Pro | Regular | ~17pt | `.body` |

### Spacing
- Base unit: [4pt / 8pt]
- Content padding: [Xpt]
- Card gap: [Xpt]

### Corner Radius
- Cards: [X]pt
- Buttons: [X]pt
- Inputs: [X]pt
```

### Phase 3: SwiftUI Code Generation

Generate SwiftUI code that recreates the screenshot's look and feel:

```swift
// MARK: - Design Tokens

extension Color {
    // Estimated colors — verify with color picker
    static let primaryApp = Color(hex: "XXXXXX")
    static let backgroundPrimary = Color(.systemBackground)
    // ...
}

// MARK: - Main View

struct ScreenNameView: View {
    var body: some View {
        // Recreated layout structure
    }
}
```

**Code generation rules:**
1. Use HIG-compliant system colors where possible (`.primary`, `.systemBackground`)
2. Map extracted colors to the closest system color when appropriate
3. Use standard SwiftUI layout containers (VStack, HStack, LazyVGrid)
4. Include both Light and Dark mode support
5. Add `// Estimated` comments next to hardcoded color values
6. Use SF Symbols for icons where applicable
7. Support Dynamic Type with standard text styles

### Phase 4: HIG Alignment & Cross-Validation

After generating tokens and code:

1. **Cross-validate with design-recommend-ios database**:
   - Infer the app category from the screenshot
   - Search the CSV database for matching styles, colors, components
   - Compare extracted tokens with database recommendations
   - Note alignment or divergence

2. **HIG compliance check**:
   - [ ] Uses standard navigation patterns
   - [ ] Touch targets >= 44x44pt
   - [ ] Sufficient color contrast (4.5:1)
   - [ ] Dynamic Type compatible
   - [ ] Dark mode handled
   - [ ] SF Symbols used where possible
   - [ ] Safe Area respected

3. **Recommendations**:
   - Suggest HIG-aligned alternatives for non-compliant elements
   - Recommend system colors over hardcoded hex values
   - Suggest accessibility improvements

## Output Format

```markdown
## Screenshot Analysis: [Description]

### Phase 1: Visual Analysis
[Extracted elements]

### Phase 2: Design Tokens
[Token table]

### Phase 3: SwiftUI Code
[Generated code]

### Phase 4: HIG Alignment
- Category match: [inferred category]
- Database cross-reference: [matching styles/components]
- HIG compliance: [checklist results]
- Recommendations: [improvement suggestions]

> **Disclaimer**: Color values are estimated from visual analysis.
> Use a color picker (Digital Color Meter) for exact values.
```

## Limitations

1. **Color accuracy**: Hex values are best-effort estimates from image analysis. Screen calibration, image compression, and rendering can affect accuracy.
2. **Font identification**: Font family is inferred — may not match exactly. Defaults to SF Pro for iOS.
3. **Spacing precision**: Pixel-level spacing is approximate. Use the generated values as starting points.
4. **Animation**: Static screenshots cannot convey motion. Animations are inferred from context (progress bars, carousels, etc.).
