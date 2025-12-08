# Troubleshooting Guide

Common issues and solutions for Android Fastlane deployment.

## Screenshot Issues

### Screenshots show wrong locale

**Problem**: English screenshots show Korean content (or vice versa)

**Cause**: System locale not properly set in emulator

**Solutions**:
1. Use separate emulators for each locale:
   ```bash
   ./scripts/setup_emulators.sh
   ```

2. Manually set locale in each emulator:
   - Settings → System → Languages & input → Languages
   - Move desired language to top
   - Save snapshot

3. Use resource-based locale detection in mock data:
   ```kotlin
   // values/screenshot_strings.xml
   <string name="screenshot_locale">en</string>

   // values-ko-rKR/screenshot_strings.xml
   <string name="screenshot_locale">ko</string>

   // In your mock repository
   private val isKorean: Boolean
       get() = context.getString(R.string.screenshot_locale) == "ko"
   ```

### Permission denied when pulling screenshots

**Problem**: `adb pull` fails with permission denied

**Solution**: Use `run-as` command:
```bash
adb shell "run-as com.your.package cat /data/data/com.your.package/app_screengrab/en-US/images/screenshots/01_home.png" > screenshot.png
```

### Emulator not starting

**Problem**: Emulator fails to start or boot

**Solutions**:
1. Check available AVDs:
   ```bash
   $ANDROID_HOME/emulator/emulator -list-avds
   ```

2. Cold boot emulator:
   ```bash
   emulator -avd YourAVD -no-snapshot-load
   ```

3. Recreate AVD:
   ```bash
   ./scripts/setup_emulators.sh
   ```

### ImageMagick not found

**Problem**: Frame script fails with "magick: command not found"

**Solution**: Install ImageMagick:
```bash
brew install imagemagick
```

## Build Issues

### Gradle build fails

**Problem**: `./gradlew assembleScreenshotDebug` fails

**Solutions**:
1. Clean and rebuild:
   ```bash
   ./gradlew clean
   ./gradlew assembleScreenshotDebug
   ```

2. Check product flavors in build.gradle:
   ```groovy
   productFlavors {
       normal { ... }
       screenshot { ... }
   }
   ```

### Missing screenshot flavor

**Problem**: "Task 'assembleScreenshotDebug' not found"

**Solution**: Add screenshot flavor to build.gradle:
```groovy
android {
    flavorDimensions += "version"
    productFlavors {
        normal {
            dimension = "version"
        }
        screenshot {
            dimension = "version"
            applicationIdSuffix = ".screenshot"
        }
    }
}
```

## Deployment Issues

### Google Play API authentication failed

**Problem**: Upload fails with 401 or 403 error

**Solutions**:
1. Check service account permissions in Google Cloud Console
2. Verify JSON key file is valid:
   ```bash
   cat ~/.google_play_keys/api-key.json | jq .client_email
   ```

3. Ensure service account has "Release Manager" role in Play Console

### Version code already exists

**Problem**: Upload fails with "Version code X has already been used"

**Solution**: Increment version code:
```groovy
// In build.gradle
android {
    defaultConfig {
        versionCode 123  // Increment this
    }
}
```

Or use auto-increment in Fastfile.

### AAB not found

**Problem**: Fastlane can't find the AAB file

**Solution**: Check build output path:
```ruby
upload_to_play_store(
  aab: "app/build/outputs/bundle/release/app-release.aab"
)
```

## CI/CD Issues

### GitHub Actions emulator timeout

**Problem**: Emulator takes too long to boot in CI

**Solutions**:
1. Use hardware acceleration:
   ```yaml
   - uses: reactivecircus/android-emulator-runner@v2
     with:
       api-level: 34
       arch: x86_64
       emulator-options: -no-window -gpu swiftshader_indirect -noaudio -no-boot-anim
   ```

2. Use AVD cache:
   ```yaml
   - uses: actions/cache@v4
     with:
       path: ~/.android/avd/*
       key: avd-api-34
   ```

### Secrets not available

**Problem**: `${{ secrets.XYZ }}` is empty

**Solutions**:
1. Check secret is set in repository Settings → Secrets
2. Verify secret name matches exactly (case-sensitive)
3. Ensure workflow has access to secrets (not a fork)

## Getting Help

If you encounter issues not covered here:
1. Check Fastlane documentation: https://docs.fastlane.tools
2. Search GitHub issues: https://github.com/fastlane/fastlane/issues
3. Stack Overflow: https://stackoverflow.com/questions/tagged/fastlane
