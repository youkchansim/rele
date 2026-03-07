---
name: data-visualization
description: >
  This skill should be used when selecting chart types, designing dashboards,
  applying visualization best practices, or reviewing chart accessibility.
  Useful for "which chart should I use", "dashboard layout", "chart design",
  "visualization best practices", "accessible charts", "data presentation".
user-invocable: false
---

# Data Visualization Framework

Data Analyst skill for choosing the right chart types, applying design principles, and ensuring accessible data communication.

## Chart Selection Guide

### By Relationship Type
| What You're Showing | Recommended Chart | Avoid |
|---------------------|------------------|-------|
| **Trend over time** | Line chart | Pie chart, bar chart for many periods |
| **Comparison (few items)** | Horizontal bar chart | Pie chart if > 5 items |
| **Comparison (many items)** | Sorted bar chart | Unsorted bars, tables |
| **Part-of-whole** | Stacked bar, treemap | Pie chart (if > 5 slices) |
| **Distribution** | Histogram, box plot | Bar chart of averages |
| **Correlation** | Scatter plot | Dual-axis line chart |
| **Funnel** | Funnel chart | Bar chart |
| **Composition change** | Stacked area, 100% stacked bar | Multiple pie charts |
| **Single KPI** | Big number with trend sparkline | Complex chart |
| **Retention** | Retention curve (line) or heatmap | Table alone |

### Common App Metric Visualizations
| Metric | Best Visualization |
|--------|-------------------|
| DAU / MAU trend | Line chart with 7-day MA overlay |
| Retention cohorts | Line chart (each cohort as a line) or heatmap |
| Funnel conversion | Funnel chart or horizontal bar |
| Revenue (MRR) | Line chart with target reference line |
| Feature adoption | Horizontal bar chart (sorted) |
| User segments | Stacked bar or donut (if <= 4 segments) |
| A/B test results | Bar chart with confidence interval error bars |

## Charts to Avoid

### 1. Pie Charts (mostly)
- **Problem**: Humans are bad at comparing angles and areas
- **When acceptable**: Only for 2-3 slices showing a simple majority split
- **Better alternative**: Horizontal bar chart (sorted)

### 2. 3D Charts
- **Problem**: Distorts proportions, adds zero information
- **Better alternative**: Any 2D equivalent

### 3. Dual Y-Axis Charts
- **Problem**: Misleading — scale manipulation can create false correlations
- **Better alternative**: Two separate charts stacked vertically, or normalize to % change

### 4. Truncated Y-Axis (without clear indication)
- **Problem**: Exaggerates small differences
- **When acceptable**: Only when the baseline is clearly marked and the audience understands the context

### 5. Rainbow Color Palettes
- **Problem**: No natural ordering, inaccessible to colorblind users
- **Better alternative**: Sequential palette for ordered data, qualitative palette for categories

## Design Principles

### Color Strategy
- **Sequential data** (low-to-high): Single hue, light to dark (e.g., light blue to dark blue)
- **Diverging data** (below/above center): Two hues from center (e.g., red-white-blue)
- **Categorical data**: Distinct, accessible hues (max 5-7 colors)
- **Highlight**: Use one accent color for the key insight, gray for context
- **Consistency**: Same metric = same color across all charts in a dashboard

### Typography
- **Title**: State the insight, not the metric name ("Retention improved 15% after onboarding redesign" not "D7 Retention")
- **Axis labels**: Clear units, no abbreviations unless universal (%, $, K, M)
- **Data labels**: Only when precision matters and chart isn't cluttered
- **Annotations**: Add context directly on the chart (e.g., "App v2.0 launched" on the timeline)

### Layout
- **Reading order**: Top-left to bottom-right (most important first)
- **Alignment**: Consistent margins and spacing between charts
- **White space**: Don't fill every pixel — breathing room aids comprehension
- **Grouping**: Related charts together, separated by clear section breaks

### Accuracy
- **Start Y-axis at 0** for bar charts (always)
- **Consistent time intervals** on X-axis
- **Label the data** rather than relying on legends when possible
- **Show uncertainty**: Error bars, confidence intervals, ranges

## Amplitude Chart Configuration Tips

### Event Segmentation
- Use line chart for trend, bar chart for comparison
- Group by user property for segment analysis
- Set appropriate time granularity (daily for short periods, weekly for months)

### Funnel Analysis
- Order steps logically (acquisition -> activation -> conversion)
- Set conversion window appropriate to your funnel (1 day for onboarding, 30 days for subscription)
- Segment by user property to find where specific groups drop off

### Retention Analysis
- Use "Day" retention for short cycles, "Week" for longer
- Compare cohorts on the same chart to spot improvement trends
- Include enough time for meaningful retention window (at least 30 days)

### Dashboard Composition
```
+------------------------------------------+
| North Star (big number + sparkline)      |
+------------------------------------------+
| L1 Metric A    | L1 Metric B   | L1 C   |
| (sparkline)    | (sparkline)   | (spark) |
+------------------------------------------+
| Activation Funnel        | Retention    |
| (funnel chart)           | (line chart) |
+------------------------------------------+
| Feature Adoption         | Revenue Trend|
| (horizontal bar)         | (line chart) |
+------------------------------------------+
```

## Presentation Guide

### For Stakeholder Communication
1. **One insight per slide/chart**: Don't overload
2. **Title = takeaway**: "Free trial conversion increased 12%" not "Conversion Chart"
3. **Progressive disclosure**: Summary first, details on demand
4. **Annotate key moments**: Mark product launches, experiments, external events
5. **Compare to benchmark**: "Our D7 retention is 25% vs 20% category average"

### For Decision Documents
- Include the chart + written interpretation below
- State the "so what" — what action does this data suggest?
- Note caveats: sample size, time period, segments excluded

## Accessibility Checklist

- [ ] **Color-blind safe**: Don't rely on red-green distinction alone. Use patterns, shapes, or labels in addition to color
- [ ] **Sufficient contrast**: Text and data elements meet WCAG AA contrast ratios
- [ ] **Screen reader**: Charts have descriptive alt text or accompanying data table
- [ ] **Font size**: Minimum 12pt for labels, 14pt for titles
- [ ] **No color-only encoding**: Pair color with shape, position, or label
- [ ] **Legend placement**: Close to the data it describes, not far away

## Deliverable

Save visualization guidelines or chart reviews to `docs/decisions/YYYY-MM-DD-visualization-{topic}.md`.
