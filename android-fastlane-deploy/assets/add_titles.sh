#!/bin/bash
# 스크린샷에 타이틀 추가 스크립트 (iOS 스타일)
# ImageMagick 필요: brew install imagemagick

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
# macOS 시스템 폰트 사용 (한글 지원)
FONT_BOLD="/System/Library/Fonts/AppleSDGothicNeo.ttc"
FONT_REGULAR="/System/Library/Fonts/AppleSDGothicNeo.ttc"

# iOS 스타일 배경색 (연보라)
BG_COLOR="#E8E4F0"

add_title_to_screenshot() {
    local input_file="$1"
    local output_file="$2"
    local title="$3"
    local subtitle="$4"
    local font_bold="$5"

    # 이미지 크기 가져오기
    local width=$(magick identify -format "%w" "$input_file")
    local height=$(magick identify -format "%h" "$input_file")

    # 최종 출력 크기 (앱스토어 권장 비율)
    local final_width=$width
    local final_height=$((width * 2164 / 1000))

    # 타이틀 영역 높이 (상단 15%)
    local title_area_height=$((final_height * 15 / 100))

    # 스크린샷 크기 (80% 정도로 축소해서 여백 확보)
    local screenshot_height=$((final_height * 78 / 100))

    # 하단 여백
    local bottom_margin=$((final_height * 4 / 100))

    # 폰트 크기
    local title_font_size=$((width / 14))
    local subtitle_font_size=$((width / 24))

    # 둥근 모서리
    local corner_radius=$((width / 20))

    # 임시 파일로 둥근 모서리 스크린샷 생성
    local temp_rounded="/tmp/rounded_screenshot_$$.png"

    # 1. 스크린샷 리사이즈 + 둥근 모서리 적용
    magick "$input_file" -resize "x${screenshot_height}" \
        \( +clone -alpha extract -draw "fill black polygon 0,0 0,${corner_radius} ${corner_radius},0 fill white circle ${corner_radius},${corner_radius} ${corner_radius},0" \
           \( +clone -flip \) -compose Multiply -composite \
           \( +clone -flop \) -compose Multiply -composite \
        \) -alpha off -compose CopyOpacity -composite \
        "$temp_rounded"

    # 2. 배경 생성 + 타이틀 + 스크린샷 합성
    magick -size "${final_width}x${final_height}" xc:"${BG_COLOR}" \
        -gravity North \
        -font "$font_bold" -pointsize $title_font_size -fill "#1a1a1a" \
        -annotate +0+$((title_area_height / 3)) "$title" \
        -font "$font_bold" -pointsize $subtitle_font_size -fill "#777777" \
        -annotate +0+$((title_area_height / 3 + title_font_size + 15)) "$subtitle" \
        "$temp_rounded" -gravity South -geometry +0+${bottom_margin} -composite \
        "$output_file"

    # 임시 파일 삭제
    rm -f "$temp_rounded"

    echo "Created: $output_file"
}

process_ko_kr() {
    local locale_dir="$SCRIPT_DIR/ko-KR/images/phoneScreenshots"
    local output_dir="$SCRIPT_DIR/ko-KR/images/framed"
    mkdir -p "$output_dir"

    echo "Processing ko-KR..."

    for screenshot in "$locale_dir"/*.png; do
        [ ! -f "$screenshot" ] && continue
        local filename=$(basename "$screenshot")

        case "$filename" in
            01_home*)
                add_title_to_screenshot "$screenshot" "$output_dir/01_home_framed.png" \
                    "한눈에 보는 복습 현황" "나의 공부 현황을 확인해요" "$FONT_BOLD"
                ;;
            02_timetable*)
                add_title_to_screenshot "$screenshot" "$output_dir/02_timetable_framed.png" \
                    "타임테이블로 일정 관리" "학습 계획을 한눈에 확인해요" "$FONT_BOLD"
                ;;
            03_profile*)
                add_title_to_screenshot "$screenshot" "$output_dir/03_profile_framed.png" \
                    "나만의 학습 통계" "꾸준한 학습 습관을 만들어요" "$FONT_BOLD"
                ;;
        esac
    done
}

process_en_us() {
    local locale_dir="$SCRIPT_DIR/en-US/images/phoneScreenshots"
    [ ! -d "$locale_dir" ] && return

    local output_dir="$SCRIPT_DIR/en-US/images/framed"
    mkdir -p "$output_dir"

    echo "Processing en-US..."

    for screenshot in "$locale_dir"/*.png; do
        [ ! -f "$screenshot" ] && continue
        local filename=$(basename "$screenshot")

        case "$filename" in
            01_home*)
                add_title_to_screenshot "$screenshot" "$output_dir/01_home_framed.png" \
                    "Review at a Glance" "Check your study progress" "$FONT_BOLD"
                ;;
            02_timetable*)
                add_title_to_screenshot "$screenshot" "$output_dir/02_timetable_framed.png" \
                    "Timetable Management" "Plan your study schedule" "$FONT_BOLD"
                ;;
            03_profile*)
                add_title_to_screenshot "$screenshot" "$output_dir/03_profile_framed.png" \
                    "Your Learning Stats" "Build consistent study habits" "$FONT_BOLD"
                ;;
        esac
    done
}

# 메인 실행
echo "========================================"
echo "📸 스크린샷 타이틀 추가 시작"
echo "========================================"

process_ko_kr
process_en_us

echo ""
echo "========================================"
echo "✅ 완료! 결과물 위치:"
echo "   - ko-KR/images/framed/"
echo "   - en-US/images/framed/ (있는 경우)"
echo "========================================"
