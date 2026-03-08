---
name: design-recommend-ios
description: >
  This skill should be used when recommending design styles, color palettes,
  typography, components, layouts, or visual effects for iOS SwiftUI apps
  based on app category or concept keywords. Useful for "recommend design for",
  "design style for health app", "what colors for finance app",
  "suggest SwiftUI components", "design system recommendation",
  "iOS design palette", "app design guide".
user-invocable: false
---

# iOS SwiftUI Data-Driven Design Recommendation

Designer-exclusive skill. Recommend design system elements based on app category and keywords using a BM25 search engine over curated CSV databases.

## Category Inference Table

| Category | Trigger Keywords |
|----------|-----------------|
| health | health, wellness, fitness, tracking, medical, activity, steps, heart |
| finance | finance, banking, investment, budget, expense, payment, crypto, trading |
| productivity | productivity, task, todo, calendar, schedule, notes, planner, organize |
| social | social, chat, messaging, feed, community, friends, stories, sharing |
| lifestyle | lifestyle, recipe, cooking, travel, journal, diary, magazine, blog |
| education | education, learning, quiz, course, study, language, academic, school |
| entertainment | entertainment, music, movie, streaming, media, gaming, play, video |
| utility | utility, calculator, converter, timer, weather, tools, settings, dashboard |

When the user describes an app concept, infer the most likely category from the table above.
If the concept spans multiple categories, search with multiple categories.

## Search Methods

### Option A: Python BM25 Search (Preferred)

Run the BM25 search engine for precise, ranked results:

```bash
cd ${CLAUDE_PLUGIN_ROOT}/skills/design-recommend-ios/scripts && python3 search.py --query "<user query>" --categories <category> --top 5
```

**With project overrides:**
```bash
cd ${CLAUDE_PLUGIN_ROOT}/skills/design-recommend-ios/scripts && python3 search.py --query "<user query>" --categories <category> --override-dir "<project_root>/docs/design-system/overrides"
```

**Category filter examples:**
```bash
# Single category
python3 search.py --query "건강 대시보드" --categories health --top 5

# Multiple categories
python3 search.py --query "fitness social" --categories health social --top 3

# Specific tables only
python3 search.py --query "chart progress" --tables components effects --top 5

# JSON output for structured processing
python3 search.py --query "finance dashboard" --categories finance --format json
```

### Option B: Direct CSV Read (Fallback)

When Bash is not available, read CSV files directly:

1. Read `${CLAUDE_PLUGIN_ROOT}/skills/design-recommend-ios/data/styles.csv`
2. Filter rows where `category` matches inferred category
3. Match `keywords` column against user query
4. Repeat for colors.csv, typography.csv, components.csv, layouts.csv, effects.csv

## Recommendation Output Format

After searching, compose the recommendation in this structure:

```markdown
## Design Recommendation: [App Concept]

### Inferred Category: [category]

### 1. Style
- **Style Name**: [from styles.csv]
- **Visual Weight**: [light/medium/heavy]
- **Corner Radius**: [value]pt
- **Shadow**: [style]

### 2. Color Palette
| Role | Light | Dark | SwiftUI Token | HIG Color |
|------|-------|------|---------------|-----------|
| Primary | #xxx | #xxx | `Color.primaryApp` | .blue |
| Secondary | #xxx | #xxx | `Color.secondaryApp` | .green |
| Background | #xxx | #xxx | `Color.backgroundPrimary` | .systemBackground |
| Surface | #xxx | #xxx | `Color.surfacePrimary` | .secondarySystemBackground |

### 3. Typography Scale
| Style | Weight | Size | SwiftUI |
|-------|--------|------|---------|
| Title | bold | 28pt | `.title` |
| Body | regular | 17pt | `.body` |

### 4. Recommended Components
| Component | SwiftUI View | Usage |
|-----------|-------------|-------|
| [name] | [view] | [description] |

### 5. Layout Pattern
- **Screen Type**: [dashboard/list/feed/...]
- **Navigation**: [NavigationStack/TabView/...]
- **Container**: [SwiftUI container]

### 6. Visual Effects
| Effect | Modifier | Min iOS |
|--------|----------|---------|
| [name] | [modifier] | [version] |

### SwiftUI Design Tokens (Copy-Paste Ready)

```swift
// MARK: - Colors
extension Color {
    static let primaryApp = Color("PrimaryApp")
    static let secondaryApp = Color("SecondaryApp")
    // ...
}

// MARK: - Spacing
enum Spacing {
    static let xs: CGFloat = 4
    static let sm: CGFloat = 8
    static let md: CGFloat = 16
    static let lg: CGFloat = 24
    static let xl: CGFloat = 32
}
```
```

## Project Override Support

Projects can customize recommendations by placing override CSVs at:
```
docs/design-system/overrides/
├── styles.csv
├── colors.csv
├── typography.csv
├── components.csv
├── layouts.csv
└── effects.csv
```

Override CSVs use the same schema as the base data. Rows with matching key columns
(style_name, semantic_name, etc.) replace the base data; new rows are appended.

## Cross-Referencing

After generating recommendations:
1. Check if the project already has a design system (`**/DesignSystem/**`, `**/Theme/**`)
2. If yes, align recommendations with existing tokens — prefer reuse over new tokens
3. Flag conflicts between recommendations and existing design system
4. Reference `design-system-ios` skill for detailed audit if needed
