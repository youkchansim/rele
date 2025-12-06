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
[STEP 2] API Key Setup
    ↓
[STEP 3] Deploy Target
    ↓
[STEP 4] Metadata Management
    ↓
[STEP 5] Review/Release Options
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
1. Find Xcode project (`*.xcodeproj`)
2. Detect Bundle ID
3. Detect Team ID
4. Check existing fastlane setup

```bash
find . -maxdepth 1 -name "*.xcodeproj" -type d
xcodebuild -project "*.xcodeproj" -showBuildSettings | grep PRODUCT_BUNDLE_IDENTIFIER
```

### Step 2: API Key Setup

**Question 2-1**: "How do you want to manage App Store Connect API keys?"

| Option | Description |
|--------|-------------|
| Global shared folder | Store in `~/.appstore_keys/` (recommended for multi-project) |
| Project .env file | Use `.env` template in project root |
| Existing setup | Already configured, skip |

**If Global shared folder selected:**
- Check if `~/.appstore_keys/config.json` exists
- If not, show setup guide:
  ```bash
  mkdir -p ~/.appstore_keys
  # Copy AuthKey_XXXXXX.p8 to ~/.appstore_keys/
  # Create config.json with key_id, issuer_id, key_file
  ```

**If Project .env file selected:**
- Generate `.env.template` with placeholders
- Generate `.env.example` for documentation
- Add `.env` to `.gitignore`
- Fastfile reads from `.env` using `dotenv` gem

**Question 2-2** (if .env selected): "Do you have multiple apps with different API keys?"

| Option | Description |
|--------|-------------|
| Single app | One API key for this project |
| Multiple apps | Support app-specific keys (e.g., `APP_STORE_KEY_ID_MYAPP`) |

### Step 3: Deploy Target

**Question**: "Where do you want to deploy?"

| Option | Description |
|--------|-------------|
| TestFlight only | Beta testing only |
| App Store only | Production release only |
| Both | TestFlight + App Store (recommended) |

### Step 4: Metadata Management

**Question**: "How do you want to manage app metadata?"

| Option | Description |
|--------|-------------|
| App Store Connect | Manage via web (Fastlane uploads binary only) |
| Fastlane (local) | Version control with Git, auto-upload |
| Hybrid | Screenshots via Connect, text via Fastlane |

**Follow-up** (if Fastlane selected): "Download existing metadata from App Store?"

### Step 5: Review/Release Options

**Question**: "How should review and release be handled?"

| Option | Description |
|--------|-------------|
| Fully automatic | Upload → Submit → Auto-release on approval |
| Review only | Upload → Submit (manual release) |
| Upload only | Upload only (manual review submission) |

**Follow-up** (if auto-submit): "Does your app use IDFA?"

### Step 6: Version Management

**Question 6-1**: "How do you want to manage version numbers?"

| Option | Format | Example |
|--------|--------|---------|
| ChatGPT style (recommended) | MAJOR.YEAR.MMDDNNN | 1.2025.1129001 |
| Semantic Versioning | MAJOR.MINOR.PATCH | 1.2.3 |
| Manual | User-managed | - |

**Question 6-2** (if ChatGPT or SemVer): "What is the current major version?"

| Option | Description |
|--------|-------------|
| 1 | First major version (default) |
| 2 | Second major version |
| Other | Enter custom number |

**Question 6-3** (if SemVer): "How should patch version be incremented?"

| Option | Description |
|--------|-------------|
| Auto-increment | +1 on each deploy (default) |
| Reset on minor | Reset to 0 when minor changes |
| Manual | Specify each time |

**Question 6-4**: "Auto-commit version changes to Git?"

| Option | Description |
|--------|-------------|
| Yes | Commit version bump after deploy |
| No | Skip commit (manual) |
| CI only | Skip in CI, commit locally |

### Step 7: CI/CD Setup

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

### Step 8: Advanced Options

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
├── .env.template          # (if .env selected)
├── .env.example           # (if .env selected)
└── .github/workflows/     # (if CI/CD selected)
    ├── ios-deploy.yml
    └── ios-test.yml
```

**API Key Setup Files** (if global folder selected):
```
~/.appstore_keys/
├── config.json            # API key configuration
└── AuthKey_XXXXXX.p8      # API key file
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
- **`assets/env.template`**: .env template for project-based API key management
- **`assets/appstore_keys_config.template.json`**: config.json template for global API key folder
