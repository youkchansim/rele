# Fastlane Options Reference

## upload_to_app_store Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_metadata` | bool | false | Skip metadata upload |
| `skip_screenshots` | bool | false | Skip screenshots upload |
| `skip_binary_upload` | bool | false | Skip binary upload |
| `submit_for_review` | bool | true | Auto-submit for review |
| `automatic_release` | bool | true | Auto-release after approval |
| `run_precheck_before_submit` | bool | false | Run precheck before submit |
| `force` | bool | true | Skip confirmation prompts |

## submission_information Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `add_id_info_uses_idfa` | bool | false | Uses IDFA for advertising |
| `export_compliance_uses_encryption` | bool | false | Uses encryption |
| `export_compliance_platform` | string | - | Encryption platform |

## build_app Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `configuration` | string | "Release" | Build configuration |
| `export_method` | string | "app-store" | Export method |
| `clean` | bool | true | Clean before build |
| `include_symbols` | bool | true | Include dSYM |
| `include_bitcode` | bool | false | Include Bitcode (deprecated) |

## upload_to_testflight Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `skip_waiting_for_build_processing` | bool | true | Skip waiting for processing |
| `distribute_external` | bool | false | Distribute to external testers |
| `groups` | array | - | Tester groups |
| `changelog` | string | - | Changelog for testers |

## Configuration Mapping

### Metadata Management

| User Choice | Settings |
|-------------|----------|
| App Store Connect | `skip_metadata: true`, `skip_screenshots: true` |
| Fastlane (local) | `skip_metadata: false`, `skip_screenshots: false` |
| Hybrid | `skip_metadata: false`, `skip_screenshots: true` |

### Review/Release Options

| User Choice | Settings |
|-------------|----------|
| Fully automatic | `submit_for_review: true`, `automatic_release: true` |
| Review only | `submit_for_review: true`, `automatic_release: false` |
| Upload only | `submit_for_review: false`, `automatic_release: false` |
