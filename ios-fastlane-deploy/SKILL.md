---
name: ios-fastlane-deploy
description: Automates iOS app builds and deploys to App Store/TestFlight using Fastlane. Use when setting up iOS deployment, configuring Fastlane, or automating App Store releases. Provides interactive wizard for step-by-step configuration of metadata, versioning, review submission, and CI/CD options.
---

# iOS Fastlane Deploy

Automated iOS deployment solution with interactive setup wizard.

**Language Convention**: Respond in the user's input language.

## Interactive Setup Wizard

When user requests deployment setup (e.g., "set up iOS deployment", "configure Fastlane"), use **AskUserQuestion** tool to guide through each step.

### Workflow

```
[STEP 1] Project Analysis (automatic)
    ↓
[STEP 2] Deploy Target
    ↓
[STEP 3] Metadata Management
    ↓
[STEP 4] Review/Release Options
    ↓
[STEP 5] Version Management
    ↓
[STEP 6] CI/CD Setup
    ↓
[STEP 7] Advanced Options
    ↓
[DONE] Generate Config Files
```

### Step 1: Project Analysis (Automatic)

Analyze project automatically:
1. Find Xcode project (`*.xcodeproj`)
2. Detect Bundle ID
3. Detect Team ID
4. Check existing fastlane setup

```bash
find . -maxdepth 1 -name "*.xcodeproj" -type d
xcodebuild -project "*.xcodeproj" -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
```

### Step 2: Deploy Target

**Question**: "Where do you want to deploy?"

| Option | Description |
|--------|-------------|
| TestFlight only | Beta testing only |
| App Store only | Production release only |
| Both | TestFlight + App Store (recommended) |

### Step 3: Metadata Management

**Question**: "How do you want to manage app metadata?"

| Option | Description |
|--------|-------------|
| App Store Connect | Manage via web (Fastlane uploads binary only) |
| Fastlane (local) | Version control with Git, auto-upload |
| Hybrid | Screenshots via Connect, text via Fastlane |

**Follow-up** (if Fastlane selected): "Download existing metadata from App Store?"

### Step 4: Review/Release Options

**Question**: "How should review and release be handled?"

| Option | Description |
|--------|-------------|
| Fully automatic | Upload → Submit → Auto-release on approval |
| Review only | Upload → Submit (manual release) |
| Upload only | Upload only (manual review submission) |

**Follow-up** (if auto-submit): "Does your app use IDFA?"

### Step 5: Version Management

**Question**: "How do you want to manage version numbers?"

| Option | Format | Example |
|--------|--------|---------|
| ChatGPT style (recommended) | MAJOR.YEAR.MMDDNNN | 1.2025.1129001 |
| Semantic Versioning | MAJOR.MINOR.PATCH | 1.2.3 |
| Manual | User-managed | - |

### Step 6: CI/CD Setup

**Question**: "Set up CI/CD automation?"

| Option | Description |
|--------|-------------|
| GitHub Actions | Most common, free tier available |
| Local only | No CI/CD, deploy from local machine |
| Later | Skip for now |

**Follow-up** (if GitHub Actions): "What triggers deployment?"
- Tag push (`v*` for App Store, `beta-*` for TestFlight)
- Manual trigger
- Both

### Step 7: Advanced Options

**Question** (multi-select): "Select additional options:"

| Option | Description |
|--------|-------------|
| Widget Extension | Build widget with main app |
| Auto-commit version | Commit version changes after deploy |
| AI release notes | Generate from git commits |
| Slack notifications | Notify on deployment |

## Generated Files

```
project/
├── fastlane/
│   ├── Appfile
│   ├── Fastfile
│   └── ExportOptions.plist
└── .github/workflows/    # (if CI/CD selected)
    ├── ios-deploy.yml
    └── ios-test.yml
```

## Commands

```bash
fastlane beta                    # TestFlight deploy
fastlane release                 # App Store deploy
fastlane release notes:"..."     # With custom release notes
fastlane build_only              # Build without upload
fastlane sync_metadata           # Download metadata
fastlane upload_metadata         # Upload metadata only
```

## Release Notes

**Default**: "Improved stability and performance."

**Custom**: `fastlane release notes:"New feature added!"`

**From file** (`fastlane/release_notes.txt`):
```
[ko]
새로운 기능이 추가되었어요!

[en-US]
New features added!
```

**AI-generated**: "Analyze recent commits and create release notes"

## Reference Files

Load these as needed:

- **`references/fastlane-options.md`**: All Fastlane configuration options
- **`references/troubleshooting.md`**: Common errors and solutions
- **`references/wizard-guide.md`**: Detailed wizard implementation guide

## Assets

- **`assets/Fastfile.template`**: Fastfile template with placeholders
- **`assets/Appfile.template`**: Appfile template
- **`assets/ExportOptions.plist`**: Export options template
- **`assets/.github/workflows/`**: GitHub Actions templates
