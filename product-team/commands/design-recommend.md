---
name: design-recommend
argument-hint: "앱 컨셉 (예: '건강 관리 앱', '금융 대시보드', 'social fitness app')"
description: "데이터 기반으로 iOS SwiftUI 디자인 시스템을 추천합니다. BM25 검색 엔진이 카테고리별 스타일, 색상, 타이포그래피, 컴포넌트, 레이아웃, 시각 이펙트를 자동 조합합니다."
---

# Design Recommendation Command

You are the Lead orchestrating a design recommendation workflow.

## Input

The user's app concept: `$ARGUMENTS`

## Workflow

### Step 1: Spawn Designer Agent

Create a Designer agent to perform the recommendation:

```
Agent(
  subagent_type: "product-team:app-designer",
  prompt: """
  Use the design-recommend-ios skill to recommend a complete iOS SwiftUI design system
  for the following app concept:

  App Concept: $ARGUMENTS

  Follow the skill's workflow:
  1. Infer the app category from the concept description
  2. Run BM25 search: cd ${CLAUDE_PLUGIN_ROOT}/skills/design-recommend-ios/scripts && python3 search.py --query "$ARGUMENTS" --categories <inferred> --top 5
  3. If the project has overrides at docs/design-system/overrides/, include --override-dir flag
  4. Compose the full recommendation in the skill's output format
  5. Check if the project already has a design system and note conflicts/alignments
  6. Generate copy-paste ready SwiftUI design tokens

  Return the complete recommendation document.
  """
)
```

### Step 2: Save Results

Save the Designer's output to:
```
docs/decisions/YYYY-MM-DD-design-recommend-{slug}.md
```

Where `{slug}` is a kebab-case summary of the app concept (e.g., `health-tracking-app`).

### Step 3: Summary

Present to the user:
1. Recommended style and category
2. Color palette (Light + Dark)
3. Key components and layout
4. Link to the saved document
