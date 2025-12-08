# Fastlane Configuration Options

Quick reference for common Fastlane options in Android projects.

## Gradle Action

```ruby
gradle(
  task: "bundle",              # Task to run: assemble, bundle, test
  flavor: "production",         # Product flavor
  build_type: "Release",        # Build type: Debug, Release
  project_dir: "./",            # Project directory
  properties: {                 # Extra properties
    "android.injected.signing.store.file" => keystore_path
  },
  flags: "--stacktrace"         # Extra flags
)
```

## Upload to Play Store

```ruby
upload_to_play_store(
  package_name: "com.example.app",
  track: "production",          # internal, alpha, beta, production
  aab: "path/to/app.aab",       # AAB file path
  apk: "path/to/app.apk",       # Or APK file path

  # Release options
  release_status: "completed",  # completed, draft, halted, inProgress
  rollout: "1.0",               # Rollout percentage (0.0 to 1.0)

  # Metadata options
  skip_upload_aab: false,
  skip_upload_apk: true,
  skip_upload_metadata: false,
  skip_upload_images: false,
  skip_upload_screenshots: false,
  skip_upload_changelogs: false,

  # JSON key
  json_key: "path/to/key.json",
  json_key_data: ENV["JSON_KEY"],  # Or from env variable

  # Version control
  version_code: 123,            # Override version code
  version_name: "1.2.3",        # Override version name

  # Mapping file
  mapping: "path/to/mapping.txt",
  mapping_paths: ["path1", "path2"]
)
```

## Screengrab

```ruby
screengrab(
  app_package_name: "com.example.app",
  app_apk_path: "path/to/app.apk",
  tests_apk_path: "path/to/test.apk",

  # Locales
  locales: ["en-US", "ko-KR", "ja-JP"],
  output_directory: "fastlane/screenshots",
  clear_previous_screenshots: true,

  # Test configuration
  use_tests_in_classes: ["com.example.ScreenshotTest"],
  use_tests_in_packages: ["com.example.screenshots"],
  test_instrumentation_runner: "androidx.test.runner.AndroidJUnitRunner",

  # Emulator options
  use_adb_root: true,
  reinstall_app: true,
  ending_locale: "en-US",

  # Device selection
  specific_device: "emulator-5554",
  device_type: "phone",         # phone, sevenInch, tenInch, tv, wear

  # Timeouts
  app_apk_path_timeout: 120,
  tests_apk_path_timeout: 120
)
```

## Supply (Download Metadata)

```ruby
download_from_play_store(
  package_name: "com.example.app",
  metadata_path: "fastlane/metadata/android",
  track: "production",          # Track to download from
  json_key: "path/to/key.json"
)
```

## Tracks

| Track | Description |
|-------|-------------|
| `internal` | Internal testing (fastest) |
| `alpha` | Closed testing (alpha) |
| `beta` | Closed testing (beta) |
| `production` | Production release |

## Version Management

### Auto-increment Version Code

```ruby
# Read current version code
gradle_file = "../app/build.gradle"
content = File.read(gradle_file)
current_code = content.match(/versionCode\s+(\d+)/)[1].to_i

# Increment
new_code = current_code + 1
new_content = content.gsub(/versionCode\s+\d+/, "versionCode #{new_code}")
File.write(gradle_file, new_content)
```

### ChatGPT-style Version Name

```ruby
# Format: MAJOR.YEAR.MMDDNNN
major = 1
today = Time.now
version_name = "#{major}.#{today.year}.#{today.strftime('%m%d')}001"
# Result: 1.2025.1208001
```

## Environment Variables

```ruby
# Read from environment
ENV["GOOGLE_PLAY_KEY_FILE"]
ENV["KEYSTORE_PASSWORD"]

# Read from .env file (requires dotenv gem)
Dotenv.load(".env")
```

## Error Handling

```ruby
begin
  upload_to_play_store(...)
rescue => e
  UI.error("Upload failed: #{e.message}")
  # Handle error
end
```

## Useful Actions

```ruby
# Get git information
git_branch
last_git_commit[:message]
git_tags

# Notifications
slack(message: "Deployed!", webhook_url: ENV["SLACK_URL"])

# Increment build number
increment_version_code(gradle_file_path: "app/build.gradle")
```
