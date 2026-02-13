---
name: android-fastlane-deploy
description: Automates Android app builds and deploys to Google Play using Fastlane. Use when setting up Android deployment, configuring Fastlane, automating screenshots, or Play Store releases. Provides interactive wizard for step-by-step configuration of metadata, versioning, screenshots with multiple locales, and CI/CD options.
---

# Android Fastlane Deploy

Automated Android deployment solution with interactive setup wizard.

**Language Convention**: Respond in the user's input language.

## Interactive Setup Wizard

When user requests deployment setup (e.g., "set up Android deployment", "configure Fastlane"), use **AskUserQuestion** tool to guide through each step.

### Workflow

```
[STEP 1] Project Analysis (automatic)
    ↓
[STEP 2] Google Play API Setup
    ↓
[STEP 3] Deploy Target
    ↓
[STEP 4] Screenshot Automation
    ↓
[STEP 5] Metadata Management
    ↓
[STEP 6] Version Management
    ↓
[STEP 7] CI/CD Setup
    ↓
[STEP 8] Advanced Options
    ↓
[DONE] Generate Config Files
```

### Step 1: Project Analysis (Automatic)

Analyze project automatically:
1. Find Gradle project (`build.gradle` or `build.gradle.kts`)
2. Detect Package Name from `applicationId`
3. Check existing fastlane setup
4. Detect product flavors

```bash
grep -r "applicationId" app/build.gradle*
./gradlew tasks --all | grep assemble
```

### Step 2: Google Play API Setup

**Question 2-1**: "How do you want to manage Google Play API credentials?"

| Option | Description |
|--------|-------------|
| Global shared folder | Store in `~/.playstore_keys/` with `config.json` (recommended for multi-project) |
| Project file | Use `fastlane/play-store-credentials.json` (CI/CD auto-detected) |
| Existing setup | Already configured, skip |

**If Global shared folder selected:**
- Check if `~/.playstore_keys/config.json` exists
- If not, show setup guide:
  ```bash
  mkdir -p ~/.playstore_keys
  # Copy Service Account JSON key
  cp /path/to/service-account.json ~/.playstore_keys/
  # Create config.json pointing to the key file
  cat > ~/.playstore_keys/config.json << 'EOF'
  {
    "json_key_file": "service-account.json"
  }
  EOF
  ```

**Key lookup order** (in Fastfile):
1. Project local: `fastlane/*.json` (for CI/CD where secrets are written to file)
2. Global: `~/.playstore_keys/{config.json → json_key_file}`

**Setup Guide:**
1. Go to Google Play Console → Setup → API access
2. Create or link Google Cloud project
3. Create Service Account with "Release Manager" role
4. Download JSON key file and save as `service-account.json`

### Step 3: Deploy Target

**Question**: "Where do you want to deploy?"

| Option | Description |
|--------|-------------|
| Internal testing | Internal testers only (fastest) |
| Closed testing | Alpha/Beta tracks |
| Open testing | Public beta |
| Production | Full release |
| All tracks | Configure all options |

### Step 4: Screenshot Automation

**Question 4-1**: "Set up automated screenshots?"

| Option | Description |
|--------|-------------|
| Yes (recommended) | Capture screenshots for each locale automatically |
| No | Manage screenshots manually |

**If Yes selected:**

**Question 4-2**: "Which locales do you need?"

| Option | Description |
|--------|-------------|
| Korean + English | ko-KR, en-US |
| Korean only | ko-KR |
| English only | en-US |
| Custom | Specify locales |

**Question 4-3**: "How should screenshot frames be styled?"

| Option | Description |
|--------|-------------|
| iOS style | Light purple background, rounded corners, title + subtitle |
| Clean | Device frame only |
| Custom | Provide custom template |

**Emulator Setup (Automatic):**
- Create 2 AVDs with different locales:
  - `Screenshot_KO` - Korean locale
  - `Screenshot_EN` - English locale
- Each emulator runs separately to capture locale-specific screenshots

### Step 5: Metadata Management

**Question**: "How do you want to manage app metadata?"

| Option | Description |
|--------|-------------|
| Google Play Console | Manage via web (Fastlane uploads binary only) |
| Fastlane (local) | Version control with Git, auto-upload |
| Hybrid | Screenshots via Fastlane, text via Console |

**Follow-up** (if Fastlane selected): "Download existing metadata from Play Store?"

### Step 6: Version Management

**Question 6-1**: "How do you want to manage version codes?"

| Option | Description |
|--------|-------------|
| Auto-increment | Increment versionCode automatically |
| Timestamp-based | Use timestamp (YYMMDDHHmm) |
| Manual | Manage in build.gradle |

**Question 6-2**: "How do you want to manage version names?"

| Option | Format | Example |
|--------|--------|---------|
| ChatGPT style (recommended) | MAJOR.YEAR.MMDDNNN | 1.2025.1208001 |
| Semantic Versioning | MAJOR.MINOR.PATCH | 1.2.3 |
| Manual | User-managed | - |

### Step 7: CI/CD Setup

**Question**: "Set up CI/CD automation?"

| Option | Description |
|--------|-------------|
| GitHub Actions | Most common, free tier available |
| Local only | No CI/CD, deploy from local machine |
| Later | Skip for now |

**Follow-up** (if GitHub Actions): "What triggers deployment?"
- Tag push (`v*` for Production, `beta-*` for Testing)
- Manual trigger
- Both

### Step 8: Advanced Options

**Question** (multi-select): "Select additional options:"

| Option | Description |
|--------|-------------|
| Screenshot flavor | Create separate `screenshot` flavor for mock data |
| Auto-commit version | Commit version changes after deploy |
| AI release notes | Generate from git commits |
| Slack notifications | Notify on deployment |
| ProGuard mapping | Upload mapping files for crash reporting |

## Generated Files

```
project/
├── fastlane/
│   ├── Appfile
│   ├── Fastfile
│   ├── Screengrabfile
│   └── screenshots/
│       ├── add_titles.sh
│       ├── ko-KR/
│       └── en-US/
├── app/
│   └── src/
│       ├── screenshot/          # Screenshot flavor (mock data)
│       └── androidTest/
│           └── .../ScreenshotTest.kt
└── .github/workflows/           # (if CI/CD selected)
    ├── android-deploy.yml
    └── android-screenshots.yml
```

**API Key Setup Files** (if global folder selected):
```
~/.playstore_keys/
├── config.json                # {"json_key_file": "service-account.json"}
└── service-account.json       # Google Play Service Account key
```

## Commands

```bash
# Screenshots
fastlane screenshots              # Capture all locales
fastlane screenshots_ko           # Korean only
fastlane screenshots_en           # English only
fastlane add_titles               # Apply frames to screenshots

# Deployment
fastlane internal                 # Internal testing
fastlane beta                     # Closed testing
fastlane release                  # Production release
fastlane release notes:"..."      # With custom release notes

# Utilities
fastlane build_only               # Build without upload
fastlane sync_metadata            # Download metadata
fastlane upload_metadata          # Upload metadata only
```

## Screenshot Workflow

### Dual Emulator Strategy

For accurate locale-specific screenshots, we use two separate emulators:

```bash
# 1. Create emulators (one-time setup)
./scripts/setup_emulators.sh

# 2. Capture screenshots (automatic)
fastlane screenshots
# This will:
# - Start Screenshot_KO emulator
# - Capture Korean screenshots
# - Stop Screenshot_KO
# - Start Screenshot_EN emulator
# - Capture English screenshots
# - Stop Screenshot_EN
# - Apply frames to all screenshots
```

### Mock Data for Screenshots

Use `screenshot` product flavor with mock data:

```kotlin
// app/src/screenshot/java/.../MockRepository.kt
class MockReviewRepository : ReviewRepository {
    private val isKorean: Boolean
        get() = context.getString(R.string.screenshot_locale) == "ko"

    // Return locale-appropriate mock data
}
```

## Reference Files

Load these as needed:

- **`references/fastlane-options.md`**: All Fastlane configuration options
- **`references/troubleshooting.md`**: Common errors and solutions
- **`references/screenshot-guide.md`**: Detailed screenshot automation guide (includes emulator setup)

## Assets

- **`assets/Fastfile.template`**: Fastfile template with placeholders
- **`assets/Appfile.template`**: Appfile template
- **`assets/Screengrabfile.template`**: Screengrab configuration
- **`assets/add_titles.sh`**: iOS-style screenshot framing script
- **`assets/ScreenshotTest.kt.template`**: Screenshot test template
- **`assets/.github/workflows/`**: GitHub Actions templates

## Emulator Requirements

For screenshot automation:
- Android SDK with emulator
- At least 2 AVDs configured:
  - `Screenshot_KO`: System locale = Korean
  - `Screenshot_EN`: System locale = English
- ImageMagick for frame processing: `brew install imagemagick`
