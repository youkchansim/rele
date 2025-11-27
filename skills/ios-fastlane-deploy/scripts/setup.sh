#!/bin/bash
# iOS Fastlane 배포 환경 초기 설정 스크립트
#
# 기능:
#   1. Fastlane 설치 확인
#   2. 템플릿 파일 복사
#   3. 기존 App Store 앱이면 메타데이터 다운로드
#   4. 설정 파일 자동 구성
#
# 사용법: ./setup.sh /path/to/project
#
# 필요한 정보 (대화식으로 입력):
#   - Bundle ID
#   - Apple ID (이메일)
#   - Team ID
#   - API Key 정보 (선택)

set -e

# 색상 정의
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 스크립트 위치 기준 경로
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SKILL_DIR="$(dirname "$SCRIPT_DIR")"
ASSETS_DIR="$SKILL_DIR/assets"

# 프로젝트 경로
PROJECT_ROOT="${1:-.}"
cd "$PROJECT_ROOT"
PROJECT_ROOT="$(pwd)"

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🚀 iOS Fastlane 배포 환경 설정${NC}"
echo -e "${BLUE}   프로젝트: $PROJECT_ROOT${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 1. Fastlane 설치 확인
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}1️⃣  Fastlane 설치 확인...${NC}"
if command -v fastlane &> /dev/null; then
    echo -e "   ${GREEN}✅ Fastlane 설치됨${NC}"
else
    echo -e "   ${RED}❌ Fastlane 미설치${NC}"
    echo -e "   ${YELLOW}설치 중...${NC}"
    gem install fastlane
    echo -e "   ${GREEN}✅ Fastlane 설치 완료${NC}"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 2. Xcode 프로젝트 찾기
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}2️⃣  Xcode 프로젝트 탐색...${NC}"
XCODEPROJ=$(find . -maxdepth 1 -name "*.xcodeproj" -type d | head -1)
if [ -z "$XCODEPROJ" ]; then
    echo -e "   ${RED}❌ Xcode 프로젝트를 찾을 수 없습니다${NC}"
    exit 1
fi
PROJECT_NAME=$(basename "$XCODEPROJ" .xcodeproj)
echo -e "   ${GREEN}✅ 프로젝트 발견: $PROJECT_NAME${NC}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 3. 프로젝트 정보 입력
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}3️⃣  프로젝트 정보 입력${NC}"

# Bundle ID 자동 감지 시도
DETECTED_BUNDLE_ID=$(xcodebuild -project "$XCODEPROJ" -target "$PROJECT_NAME" -showBuildSettings 2>/dev/null | grep "PRODUCT_BUNDLE_IDENTIFIER" | head -1 | awk '{print $3}')

if [ -n "$DETECTED_BUNDLE_ID" ]; then
    echo -e "   감지된 Bundle ID: ${GREEN}$DETECTED_BUNDLE_ID${NC}"
    read -p "   사용하시겠습니까? (Y/n): " USE_DETECTED
    if [[ "$USE_DETECTED" =~ ^[Nn]$ ]]; then
        read -p "   Bundle ID 입력: " BUNDLE_ID
    else
        BUNDLE_ID="$DETECTED_BUNDLE_ID"
    fi
else
    read -p "   Bundle ID (예: com.company.app): " BUNDLE_ID
fi

read -p "   Apple ID (이메일): " APPLE_ID

# Team ID 자동 감지 시도
DETECTED_TEAM_ID=$(xcodebuild -project "$XCODEPROJ" -target "$PROJECT_NAME" -showBuildSettings 2>/dev/null | grep "DEVELOPMENT_TEAM" | head -1 | awk '{print $3}')
if [ -n "$DETECTED_TEAM_ID" ] && [ "$DETECTED_TEAM_ID" != "" ]; then
    echo -e "   감지된 Team ID: ${GREEN}$DETECTED_TEAM_ID${NC}"
    read -p "   사용하시겠습니까? (Y/n): " USE_DETECTED_TEAM
    if [[ "$USE_DETECTED_TEAM" =~ ^[Nn]$ ]]; then
        read -p "   Team ID: " TEAM_ID
    else
        TEAM_ID="$DETECTED_TEAM_ID"
    fi
else
    read -p "   Team ID: " TEAM_ID
fi

echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 4. API 키 설정
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}4️⃣  App Store Connect API 키 설정${NC}"
read -p "   API 키를 설정하시겠습니까? (Y/n): " SETUP_API_KEY

if [[ ! "$SETUP_API_KEY" =~ ^[Nn]$ ]]; then
    read -p "   Key ID: " API_KEY_ID
    read -p "   Issuer ID: " API_ISSUER_ID
    read -p "   .p8 파일 경로 (또는 Enter로 건너뛰기): " API_KEY_PATH

    if [ -n "$API_KEY_PATH" ] && [ -f "$API_KEY_PATH" ]; then
        mkdir -p fastlane
        cp "$API_KEY_PATH" "fastlane/AuthKey_${API_KEY_ID}.p8"
        echo -e "   ${GREEN}✅ API 키 파일 복사 완료${NC}"
    fi
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 5. fastlane 디렉토리 생성 및 템플릿 복사
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}5️⃣  Fastlane 설정 파일 생성...${NC}"
mkdir -p fastlane

# Appfile 생성
cat > fastlane/Appfile << EOF
# Appfile - 자동 생성됨
# 생성일: $(date '+%Y-%m-%d %H:%M:%S')

app_identifier("$BUNDLE_ID")
apple_id("$APPLE_ID")
team_id("$TEAM_ID")
EOF
echo -e "   ${GREEN}✅ Appfile 생성${NC}"

# Fastfile 복사 및 수정
cp "$ASSETS_DIR/Fastfile.template" fastlane/Fastfile

# Fastfile 설정값 교체
sed -i '' "s/YourApp.xcodeproj/${PROJECT_NAME}.xcodeproj/g" fastlane/Fastfile
sed -i '' "s/SCHEME = \"YourApp\"/SCHEME = \"${PROJECT_NAME}\"/g" fastlane/Fastfile
sed -i '' "s/com.yourcompany.app/${BUNDLE_ID}/g" fastlane/Fastfile

if [ -n "$API_KEY_ID" ]; then
    sed -i '' "s/YOUR_KEY_ID/${API_KEY_ID}/g" fastlane/Fastfile
    sed -i '' "s/YOUR_ISSUER_ID/${API_ISSUER_ID}/g" fastlane/Fastfile
    sed -i '' "s/AuthKey_XXXXX.p8/AuthKey_${API_KEY_ID}.p8/g" fastlane/Fastfile
fi
echo -e "   ${GREEN}✅ Fastfile 생성${NC}"

# ExportOptions.plist 복사 및 수정
cp "$ASSETS_DIR/ExportOptions.plist" fastlane/ExportOptions.plist
sed -i '' "s/XXXXXXXXXX/${TEAM_ID}/g" fastlane/ExportOptions.plist
echo -e "   ${GREEN}✅ ExportOptions.plist 생성${NC}"
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 6. App Store 메타데이터 다운로드 (기존 앱인 경우)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}6️⃣  App Store 메타데이터 확인...${NC}"
read -p "   이미 App Store에 출시된 앱입니까? (y/N): " IS_PUBLISHED

if [[ "$IS_PUBLISHED" =~ ^[Yy]$ ]]; then
    echo -e "   ${BLUE}📥 App Store Connect에서 메타데이터 다운로드 중...${NC}"

    # deliver init으로 메타데이터 구조 생성 및 다운로드
    if [ -n "$API_KEY_ID" ]; then
        fastlane deliver download_metadata \
            --app_identifier "$BUNDLE_ID" \
            --api_key_path "fastlane/AuthKey_${API_KEY_ID}.p8" \
            --api_key_id "$API_KEY_ID" \
            --api_issuer_id "$API_ISSUER_ID" \
            2>/dev/null || true

        fastlane deliver download_screenshots \
            --app_identifier "$BUNDLE_ID" \
            --api_key_path "fastlane/AuthKey_${API_KEY_ID}.p8" \
            --api_key_id "$API_KEY_ID" \
            --api_issuer_id "$API_ISSUER_ID" \
            2>/dev/null || true
    else
        fastlane deliver download_metadata \
            --app_identifier "$BUNDLE_ID" \
            --username "$APPLE_ID" \
            2>/dev/null || true

        fastlane deliver download_screenshots \
            --app_identifier "$BUNDLE_ID" \
            --username "$APPLE_ID" \
            2>/dev/null || true
    fi

    if [ -d "fastlane/metadata" ]; then
        echo -e "   ${GREEN}✅ 메타데이터 다운로드 완료${NC}"
        echo -e "   ${GREEN}   - fastlane/metadata/ (앱 설명, 키워드 등)${NC}"
    fi

    if [ -d "fastlane/screenshots" ]; then
        echo -e "   ${GREEN}✅ 스크린샷 다운로드 완료${NC}"
        echo -e "   ${GREEN}   - fastlane/screenshots/ (앱 스크린샷)${NC}"
    fi
else
    echo -e "   ${YELLOW}⏭️  메타데이터 다운로드 건너뜀 (신규 앱)${NC}"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 7. 설정 검증
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${YELLOW}7️⃣  설정 검증 중...${NC}"
if fastlane lanes &> /dev/null; then
    echo -e "   ${GREEN}✅ Fastlane 설정 유효${NC}"
else
    echo -e "   ${YELLOW}⚠️  Fastlane 설정 확인 필요${NC}"
fi
echo ""

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 완료
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 설정 완료!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "생성된 파일:"
echo -e "   📁 fastlane/"
echo -e "      ├── Appfile"
echo -e "      ├── Fastfile"
echo -e "      ├── ExportOptions.plist"
if [ -n "$API_KEY_ID" ]; then
echo -e "      ├── AuthKey_${API_KEY_ID}.p8"
fi
if [ -d "fastlane/metadata" ]; then
echo -e "      ├── metadata/"
fi
if [ -d "fastlane/screenshots" ]; then
echo -e "      └── screenshots/"
fi
echo ""
echo -e "사용 가능한 명령어:"
echo -e "   ${BLUE}fastlane beta${NC}       - TestFlight 배포"
echo -e "   ${BLUE}fastlane release${NC}    - App Store 배포"
echo -e "   ${BLUE}fastlane build_only${NC} - 빌드만"
echo ""
