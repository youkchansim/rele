#!/bin/bash
# iOS Fastlane 배포 환경 초기 설정 스크립트
#
# 기능:
#   1. 공용 설정이 있으면 자동으로 진행
#   2. 없으면 에러 + 설정 가이드 표시
#   3. 기존 App Store 앱이면 메타데이터 다운로드
#
# 사용법: ./setup.sh /path/to/project [--auto]
#   --auto: 대화형 입력 없이 자동 진행

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

# 공용 설정 경로
GLOBAL_CONFIG_DIR="$HOME/.appstore_keys"
GLOBAL_CONFIG_FILE="$GLOBAL_CONFIG_DIR/config.json"

# 인자 파싱
PROJECT_ROOT="${1:-.}"
AUTO_MODE=false
if [[ "$2" == "--auto" ]] || [[ "$1" == "--auto" ]]; then
    AUTO_MODE=true
    if [[ "$1" == "--auto" ]]; then
        PROJECT_ROOT="."
    fi
fi

cd "$PROJECT_ROOT"
PROJECT_ROOT="$(pwd)"

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 공용 설정 검증 함수
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
check_global_config() {
    if [ ! -f "$GLOBAL_CONFIG_FILE" ]; then
        return 1
    fi

    # jq가 있으면 사용, 없으면 grep으로 파싱
    if command -v jq &> /dev/null; then
        GLOBAL_APPLE_ID=$(jq -r '.apple_id // empty' "$GLOBAL_CONFIG_FILE")
        GLOBAL_TEAM_ID=$(jq -r '.team_id // empty' "$GLOBAL_CONFIG_FILE")
        GLOBAL_KEY_ID=$(jq -r '.default.key_id // empty' "$GLOBAL_CONFIG_FILE")
        GLOBAL_ISSUER_ID=$(jq -r '.default.issuer_id // empty' "$GLOBAL_CONFIG_FILE")
        GLOBAL_KEY_FILE=$(jq -r '.default.key_file // empty' "$GLOBAL_CONFIG_FILE")
    else
        GLOBAL_APPLE_ID=$(grep -o '"apple_id"[[:space:]]*:[[:space:]]*"[^"]*"' "$GLOBAL_CONFIG_FILE" 2>/dev/null | cut -d'"' -f4)
        GLOBAL_TEAM_ID=$(grep -o '"team_id"[[:space:]]*:[[:space:]]*"[^"]*"' "$GLOBAL_CONFIG_FILE" 2>/dev/null | cut -d'"' -f4)
        GLOBAL_KEY_ID=$(grep -o '"key_id"[[:space:]]*:[[:space:]]*"[^"]*"' "$GLOBAL_CONFIG_FILE" 2>/dev/null | cut -d'"' -f4)
        GLOBAL_ISSUER_ID=$(grep -o '"issuer_id"[[:space:]]*:[[:space:]]*"[^"]*"' "$GLOBAL_CONFIG_FILE" 2>/dev/null | cut -d'"' -f4)
        GLOBAL_KEY_FILE=$(grep -o '"key_file"[[:space:]]*:[[:space:]]*"[^"]*"' "$GLOBAL_CONFIG_FILE" 2>/dev/null | cut -d'"' -f4)
    fi

    # API 키 파일 존재 확인
    if [ -z "$GLOBAL_KEY_FILE" ] || [ ! -f "$GLOBAL_CONFIG_DIR/$GLOBAL_KEY_FILE" ]; then
        return 1
    fi

    # 필수 값 확인
    if [ -z "$GLOBAL_KEY_ID" ] || [ -z "$GLOBAL_ISSUER_ID" ] || [ -z "$GLOBAL_TEAM_ID" ]; then
        return 1
    fi

    return 0
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 설정 가이드 표시
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
show_setup_guide() {
    echo ""
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${RED}❌ App Store Connect API 키가 설정되지 않았습니다!${NC}"
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo -e "${YELLOW}📁 설정 방법:${NC}"
    echo ""
    echo "1. 디렉토리 생성:"
    echo -e "   ${GREEN}mkdir -p ~/.appstore_keys${NC}"
    echo ""
    echo "2. API 키 파일 복사 (.p8 파일):"
    echo -e "   ${GREEN}cp /path/to/AuthKey_XXXXXX.p8 ~/.appstore_keys/${NC}"
    echo ""
    echo "3. config.json 생성:"
    echo -e "   ${GREEN}cat > ~/.appstore_keys/config.json << 'EOF'"
    echo '   {'
    echo '     "default": {'
    echo '       "key_id": "YOUR_KEY_ID",'
    echo '       "issuer_id": "YOUR_ISSUER_ID",'
    echo '       "key_file": "AuthKey_XXXXXX.p8"'
    echo '     },'
    echo '     "apple_id": "your-email@example.com",'
    echo '     "team_id": "XXXXXXXXXX"'
    echo '   }'
    echo -e "   EOF${NC}"
    echo ""
    echo -e "${YELLOW}📌 API 키 발급 방법:${NC}"
    echo "   1. https://appstoreconnect.apple.com 접속"
    echo "   2. Users and Access → Keys → App Store Connect API"
    echo "   3. + 버튼으로 새 키 생성 (Admin 권한)"
    echo "   4. Key ID, Issuer ID 복사"
    echo "   5. .p8 파일 다운로드"
    echo ""
    echo -e "${RED}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    exit 1
}

# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
# 메인 로직 시작
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}🚀 iOS Fastlane 배포 환경 설정${NC}"
echo -e "${BLUE}   프로젝트: $PROJECT_ROOT${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 1. 공용 설정 확인
echo -e "${YELLOW}1️⃣  공용 설정 확인...${NC}"
if ! check_global_config; then
    show_setup_guide
fi
echo -e "   ${GREEN}✅ 공용 설정 발견${NC}"
echo -e "      Apple ID: $GLOBAL_APPLE_ID"
echo -e "      Team ID: $GLOBAL_TEAM_ID"
echo -e "      Key ID: $GLOBAL_KEY_ID"
echo ""

# 2. Fastlane 설치 확인
echo -e "${YELLOW}2️⃣  Fastlane 설치 확인...${NC}"
if command -v fastlane &> /dev/null; then
    echo -e "   ${GREEN}✅ Fastlane 설치됨${NC}"
else
    echo -e "   ${YELLOW}⏳ Fastlane 설치 중...${NC}"
    gem install fastlane
    echo -e "   ${GREEN}✅ Fastlane 설치 완료${NC}"
fi
echo ""

# 3. Xcode 프로젝트 찾기
echo -e "${YELLOW}3️⃣  Xcode 프로젝트 탐색...${NC}"
XCODEPROJ=$(find . -maxdepth 1 -name "*.xcodeproj" -type d | head -1)
if [ -z "$XCODEPROJ" ]; then
    echo -e "   ${RED}❌ Xcode 프로젝트를 찾을 수 없습니다${NC}"
    exit 1
fi
PROJECT_NAME=$(basename "$XCODEPROJ" .xcodeproj)
echo -e "   ${GREEN}✅ 프로젝트 발견: $PROJECT_NAME${NC}"
echo ""

# 4. Bundle ID 자동 감지
echo -e "${YELLOW}4️⃣  Bundle ID 감지...${NC}"
BUNDLE_ID=$(xcodebuild -project "$XCODEPROJ" -target "$PROJECT_NAME" -showBuildSettings 2>/dev/null | grep "^[[:space:]]*PRODUCT_BUNDLE_IDENTIFIER = " | head -1 | awk -F' = ' '{print $2}')
if [ -z "$BUNDLE_ID" ]; then
    echo -e "   ${RED}❌ Bundle ID를 감지할 수 없습니다${NC}"
    exit 1
fi
echo -e "   ${GREEN}✅ Bundle ID: $BUNDLE_ID${NC}"
echo ""

# 5. Fastlane 파일 생성
echo -e "${YELLOW}5️⃣  Fastlane 설정 파일 생성...${NC}"
mkdir -p fastlane

# Appfile 생성
cat > fastlane/Appfile << EOF
# Appfile - 자동 생성됨
# 생성일: $(date '+%Y-%m-%d %H:%M:%S')

app_identifier("$BUNDLE_ID")
apple_id("$GLOBAL_APPLE_ID")
team_id("$GLOBAL_TEAM_ID")
EOF
echo -e "   ${GREEN}✅ Appfile 생성${NC}"

# Fastfile 복사 및 수정
cp "$ASSETS_DIR/Fastfile.template" fastlane/Fastfile
sed -i '' "s/YourApp.xcodeproj/${PROJECT_NAME}.xcodeproj/g" fastlane/Fastfile
sed -i '' "s/SCHEME = \"YourApp\"/SCHEME = \"${PROJECT_NAME}\"/g" fastlane/Fastfile
sed -i '' "s/com.yourcompany.app/${BUNDLE_ID}/g" fastlane/Fastfile
echo -e "   ${GREEN}✅ Fastfile 생성${NC}"

# ExportOptions.plist 복사 및 수정
cp "$ASSETS_DIR/ExportOptions.plist" fastlane/ExportOptions.plist
sed -i '' "s/XXXXXXXXXX/${GLOBAL_TEAM_ID}/g" fastlane/ExportOptions.plist
echo -e "   ${GREEN}✅ ExportOptions.plist 생성${NC}"
echo ""

# 6. App Store 메타데이터 다운로드 (자동 모드가 아닐 때만 질문)
echo -e "${YELLOW}6️⃣  App Store 메타데이터 확인...${NC}"
if [ "$AUTO_MODE" = true ]; then
    IS_PUBLISHED="n"
else
    read -p "   이미 App Store에 출시된 앱입니까? (y/N): " IS_PUBLISHED
fi

if [[ "$IS_PUBLISHED" =~ ^[Yy]$ ]]; then
    echo -e "   ${BLUE}📥 메타데이터 다운로드 중...${NC}"

    fastlane deliver download_metadata \
        --app_identifier "$BUNDLE_ID" \
        --api_key_path "$GLOBAL_CONFIG_DIR/$GLOBAL_KEY_FILE" \
        2>/dev/null || true

    fastlane deliver download_screenshots \
        --app_identifier "$BUNDLE_ID" \
        --api_key_path "$GLOBAL_CONFIG_DIR/$GLOBAL_KEY_FILE" \
        2>/dev/null || true

    if [ -d "fastlane/metadata" ]; then
        echo -e "   ${GREEN}✅ 메타데이터 다운로드 완료${NC}"
    fi
else
    echo -e "   ${YELLOW}⏭️  메타데이터 다운로드 건너뜀${NC}"
fi
echo ""

# 7. 완료
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ 설정 완료!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "생성된 파일:"
echo -e "   📁 fastlane/"
echo -e "      ├── Appfile"
echo -e "      ├── Fastfile"
echo -e "      └── ExportOptions.plist"
echo ""
echo -e "사용 가능한 명령어:"
echo -e "   ${BLUE}fastlane beta${NC}       - TestFlight 배포"
echo -e "   ${BLUE}fastlane release${NC}    - App Store 배포"
echo -e "   ${BLUE}fastlane build_only${NC} - 빌드만"
echo ""
