---
name: design-from-screenshot
argument-hint: "스크린샷 경로 (예: '/path/to/screenshot.png', '~/Desktop/reference.jpg')"
description: "레퍼런스 스크린샷을 분석하여 디자인 토큰을 추출하고 SwiftUI 코드를 생성합니다. 색상, 타이포그래피, 레이아웃, 컴포넌트를 자동 추출합니다."
---

# Screenshot-to-SwiftUI Command

You are the Lead orchestrating a screenshot design analysis workflow.

## Input

Screenshot path: `$ARGUMENTS`

## Workflow

### Step 1: Validate Input

Verify that `$ARGUMENTS` contains a valid file path. If not provided, ask the user for the screenshot path.

### Step 2: Spawn Designer Agent

Create a Designer agent to analyze the screenshot:

```
Agent(
  subagent_type: "product-team:app-designer",
  prompt: """
  Use the screenshot-to-swiftui skill to analyze the following screenshot and generate
  a complete SwiftUI design system from it.

  Screenshot path: $ARGUMENTS

  Follow the skill's 4-phase workflow:
  1. Phase 1: Read the image file and extract colors, typography, layout, components, effects
  2. Phase 2: Generate structured design tokens (Light + Dark mode)
  3. Phase 3: Generate SwiftUI code that recreates the screenshot's look and feel
  4. Phase 4: Cross-validate with design-recommend-ios database and check HIG compliance

  For Phase 4 cross-validation, run:
  cd ${CLAUDE_PLUGIN_ROOT}/skills/design-recommend-ios/scripts && python3 search.py --query "<inferred keywords>" --categories <inferred category> --top 3

  Important:
  - Mark all color hex values as "estimated" — recommend color picker verification
  - Generate both Light and Dark mode tokens
  - Use system colors where they match closely
  - Include copy-paste ready SwiftUI code

  Return the complete analysis document.
  """
)
```

### Step 3: Save Results

Save the Designer's output to:
```
docs/decisions/YYYY-MM-DD-screenshot-design-{slug}.md
```

Where `{slug}` is a brief description of the screenshot content (e.g., `fitness-dashboard-reference`).

### Step 4: Summary

Present to the user:
1. Key design elements extracted (colors, style, layout)
2. Generated SwiftUI code highlights
3. HIG compliance status
4. Any recommendations for improvement
5. Link to the saved document

> **Note**: Color values are estimates from visual analysis.
> Use Digital Color Meter (macOS) or a similar tool for exact values.
