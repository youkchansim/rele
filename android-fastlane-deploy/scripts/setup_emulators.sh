#!/bin/bash
#
# Setup script for screenshot emulators
# Creates two AVDs with different locales for automated screenshots
#
# Usage: ./setup_emulators.sh
#
# Requirements:
#   - Android SDK installed
#   - ANDROID_HOME or ANDROID_SDK_ROOT set
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# SDK paths
ANDROID_SDK="${ANDROID_HOME:-${ANDROID_SDK_ROOT:-$HOME/Library/Android/sdk}}"
SDKMANAGER="$ANDROID_SDK/cmdline-tools/latest/bin/sdkmanager"
AVDMANAGER="$ANDROID_SDK/cmdline-tools/latest/bin/avdmanager"
EMULATOR="$ANDROID_SDK/emulator/emulator"
ADB="$ANDROID_SDK/platform-tools/adb"

# Emulator configuration
SYSTEM_IMAGE="system-images;android-34;google_apis_playstore;arm64-v8a"
DEVICE="pixel_6"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📱 Screenshot Emulator Setup${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

# Check Android SDK
if [ ! -d "$ANDROID_SDK" ]; then
    echo -e "${RED}❌ Android SDK not found at: $ANDROID_SDK${NC}"
    echo "Please set ANDROID_HOME or ANDROID_SDK_ROOT environment variable."
    exit 1
fi

echo -e "${GREEN}✓ Android SDK found: $ANDROID_SDK${NC}"

# Check/install system image
echo -e "\n${YELLOW}📦 Checking system image...${NC}"
if ! "$SDKMANAGER" --list_installed 2>/dev/null | grep -q "android-34.*google_apis_playstore.*arm64"; then
    echo "Installing system image..."
    "$SDKMANAGER" "$SYSTEM_IMAGE"
fi
echo -e "${GREEN}✓ System image ready${NC}"

# Function to create AVD
create_avd() {
    local avd_name=$1
    local locale=$2

    echo -e "\n${YELLOW}📱 Creating AVD: $avd_name (locale: $locale)${NC}"

    # Delete if exists
    if [ -d "$HOME/.android/avd/${avd_name}.avd" ]; then
        echo "Deleting existing AVD..."
        "$AVDMANAGER" delete avd -n "$avd_name" 2>/dev/null || true
    fi

    # Create AVD
    echo "no" | "$AVDMANAGER" create avd \
        -n "$avd_name" \
        -k "$SYSTEM_IMAGE" \
        -d "$DEVICE" \
        --force

    # Configure AVD
    local avd_config="$HOME/.android/avd/${avd_name}.avd/config.ini"

    # Set locale in config
    echo "# Locale settings" >> "$avd_config"

    if [ "$locale" = "ko-KR" ]; then
        cat >> "$avd_config" << EOF

# Korean locale
hw.keyboard = yes
hw.mainKeys = no
PlayStore.enabled = true
EOF
    else
        cat >> "$avd_config" << EOF

# English locale
hw.keyboard = yes
hw.mainKeys = no
PlayStore.enabled = true
EOF
    fi

    echo -e "${GREEN}✓ AVD created: $avd_name${NC}"
}

# Create Korean emulator
create_avd "Screenshot_KO" "ko-KR"

# Create English emulator
create_avd "Screenshot_EN" "en-US"

echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Emulator setup complete!${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo -e "\n${YELLOW}⚠️  Important: Manual locale configuration required${NC}"
echo -e "
For each emulator, you need to set the system locale manually:

${BLUE}1. Screenshot_KO (Korean):${NC}
   $EMULATOR -avd Screenshot_KO
   - Go to Settings → System → Languages & input → Languages
   - Add Korean (한국어) and move to top
   - Create snapshot after configuration

${BLUE}2. Screenshot_EN (English):${NC}
   $EMULATOR -avd Screenshot_EN
   - Go to Settings → System → Languages & input → Languages
   - Ensure English (United States) is at top
   - Create snapshot after configuration

${GREEN}After configuration, run:${NC}
   fastlane screenshots
"

# List created AVDs
echo -e "\n${BLUE}Created AVDs:${NC}"
"$AVDMANAGER" list avd | grep -E "Name:|Path:" | head -8
