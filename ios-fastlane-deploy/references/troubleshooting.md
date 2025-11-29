# Troubleshooting Guide

## API Key Authentication Error

```
undefined method 'app_store_connect_api_key'
```

**Solution**: `app_store_connect_api_key` must be used in **Fastfile** only, not in Appfile.

## IAP Precheck Error

```
Precheck cannot check In-app purchases with API Key
```

**Solution**: Set `run_precheck_before_submit: false` in upload_to_app_store.

## No Editable Version

```
Could not find an editable version for 'com.app.bundle'
```

**Causes**:
- Previous version is under review
- New version not yet created

**Solutions**:
1. Cancel previous review in App Store Connect
2. Upload binary first, then submit manually
3. Set `submit_for_review: false` and submit manually

## Widget Not Included

**Check IPA contents**:
```bash
unzip -l ./build/App.ipa | grep -i widget
```

**Solution**: Ensure Widget Extension is included in the build scheme.

## Build Failures

**Resolve dependencies**:
```bash
xcodebuild -resolvePackageDependencies
```

**Clear DerivedData**:
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData
```

## Version Conflict

```
This build already exists
```

**Cause**: Same build number uploaded twice.

**Solution**: Use automatic versioning (ChatGPT style or SemVer) to avoid conflicts.

## API Key Setup

If API key is not configured:

```bash
# Create directory
mkdir -p ~/.appstore_keys

# Copy .p8 file
cp /path/to/AuthKey_XXXXXX.p8 ~/.appstore_keys/

# Create config.json
cat > ~/.appstore_keys/config.json << 'EOF'
{
  "default": {
    "key_id": "YOUR_KEY_ID",
    "issuer_id": "YOUR_ISSUER_ID",
    "key_file": "AuthKey_XXXXXX.p8"
  },
  "apple_id": "your-email@example.com",
  "team_id": "XXXXXXXXXX"
}
EOF
```

**Get API Key**:
1. Go to https://appstoreconnect.apple.com
2. Users and Access → Keys → App Store Connect API
3. Create new key with Admin role
4. Copy Key ID and Issuer ID
5. Download .p8 file
