# Screenshot Automation Guide

Complete guide for setting up automated app store screenshots.

## Overview

The screenshot automation system captures app screenshots in multiple locales using:
- **Dual Emulator Strategy**: Separate emulators for each locale
- **Screenshot Flavor**: Product flavor with mock data
- **iOS-style Frames**: Beautiful frames with titles and rounded corners

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    Screenshot Workflow                   │
├─────────────────────────────────────────────────────────┤
│                                                         │
│  ┌──────────────┐    ┌──────────────┐                  │
│  │ Screenshot_KO│    │ Screenshot_EN│   Emulators      │
│  │ (Korean)     │    │ (English)    │                  │
│  └──────┬───────┘    └──────┬───────┘                  │
│         │                   │                          │
│         ▼                   ▼                          │
│  ┌──────────────────────────────────────┐              │
│  │     Screenshot APK (Mock Data)       │   App        │
│  │     - MockReviewRepository           │              │
│  │     - Locale-aware data              │              │
│  └──────────────┬───────────────────────┘              │
│                 │                                      │
│                 ▼                                      │
│  ┌──────────────────────────────────────┐              │
│  │       ScreenshotTest.kt              │   Test       │
│  │       - Compose UI tests             │              │
│  │       - Screengrab capture           │              │
│  └──────────────┬───────────────────────┘              │
│                 │                                      │
│                 ▼                                      │
│  ┌──────────────────────────────────────┐              │
│  │       add_titles.sh                  │   Frames     │
│  │       - iOS-style backgrounds        │              │
│  │       - Rounded corners              │              │
│  │       - Titles & subtitles           │              │
│  └──────────────────────────────────────┘              │
│                                                         │
└─────────────────────────────────────────────────────────┘
```

## Setup Steps

### 1. Create Screenshot Product Flavor

In `app/build.gradle`:

```groovy
android {
    flavorDimensions += "version"

    productFlavors {
        normal {
            dimension = "version"
        }
        screenshot {
            dimension = "version"
            // Optional: different app ID for testing
            applicationIdSuffix = ".screenshot"
        }
    }
}
```

### 2. Create Mock Data Sources

Create locale-aware mock repositories in `app/src/screenshot/`:

```kotlin
// app/src/screenshot/.../MockReviewRepository.kt
@Singleton
class MockReviewRepository @Inject constructor(
    @ApplicationContext private val context: Context
) : ReviewRepository {

    private val isKorean: Boolean
        get() = context.getString(R.string.screenshot_locale) == "ko"

    private val mockData: List<Review>
        get() = if (isKorean) koreanReviews else englishReviews

    private val koreanReviews = listOf(
        Review("토익 단어장 5과", ...),
        Review("미적분 - 적분법", ...),
    )

    private val englishReviews = listOf(
        Review("TOEIC Vocabulary Ch.5", ...),
        Review("Calculus - Integration", ...),
    )
}
```

### 3. Add Locale Resource Strings

```xml
<!-- app/src/screenshot/res/values/screenshot_strings.xml -->
<resources>
    <string name="screenshot_locale">en</string>
</resources>

<!-- app/src/screenshot/res/values-ko-rKR/screenshot_strings.xml -->
<resources>
    <string name="screenshot_locale">ko</string>
</resources>
```

### 4. Create Screenshot Test

```kotlin
// app/src/androidTest/.../ScreenshotTest.kt
@RunWith(AndroidJUnit4::class)
class ScreenshotTest {

    companion object {
        @get:ClassRule
        @JvmStatic
        val localeTestRule = LocaleTestRule()
    }

    @get:Rule
    val composeTestRule = createAndroidComposeRule<MainActivity>()

    @Test
    fun captureScreenshots() {
        Screengrab.setDefaultScreenshotStrategy(UiAutomatorScreenshotStrategy())

        composeTestRule.waitForIdle()
        Thread.sleep(3000)

        // Capture each screen
        Screengrab.screenshot("01_home")

        // Navigate and capture more screens
        clickOnTab("Time Table", "타임테이블")
        Screengrab.screenshot("02_timetable")
    }
}
```

### 5. Setup Dual Emulators

Run the setup script:
```bash
./scripts/setup_emulators.sh
```

Then manually configure locales:
1. Start `Screenshot_KO`, set Korean as primary language
2. Start `Screenshot_EN`, set English as primary language
3. Save snapshots for faster boot

### 6. Create Frame Script

Copy `add_titles.sh` to `fastlane/screenshots/` and customize:
- Titles for each screen
- Colors and fonts
- Background style

## Commands

```bash
# Capture all screenshots
fastlane screenshots

# Capture Korean only
fastlane screenshots_ko

# Capture English only
fastlane screenshots_en

# Apply frames only (if screenshots already captured)
fastlane add_titles
```

## Frame Customization

### Colors

Edit `add_titles.sh`:
```bash
BG_COLOR="#E8E4F0"  # Light purple background
TITLE_COLOR="#1a1a1a"  # Dark title
SUBTITLE_COLOR="#777777"  # Gray subtitle
```

### Titles

Define titles for each locale:
```bash
# Korean
TITLES_KO=(
    "한눈에 보는 복습 현황|나의 공부 현황을 확인해요"
    "시간표로 정리하는 학습|체계적인 시간 관리"
    "나의 학습 통계|성장하는 나를 확인해요"
)

# English
TITLES_EN=(
    "Review at a Glance|Check your study progress"
    "Organized Time Table|Systematic time management"
    "My Study Statistics|Track your growth"
)
```

### Dimensions

Adjust sizing for different aspect ratios:
```bash
# For phone screenshots (9:19.5 aspect ratio)
final_height=$((width * 2164 / 1000))
title_area_height=$((final_height * 15 / 100))
screenshot_height=$((final_height * 78 / 100))
corner_radius=$((width / 20))
```

## Troubleshooting

See [troubleshooting.md](troubleshooting.md) for common issues.

## Best Practices

1. **Use realistic mock data**: Show meaningful content, not "Lorem ipsum"
2. **Consistent styling**: Match your app's design language
3. **Test all locales**: Verify text fits in all languages
4. **Version control frames**: Keep frame script in git
5. **Automate in CI**: Use GitHub Actions for consistent results
