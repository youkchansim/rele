#!/usr/bin/env bash
# X API v2를 통한 트윗 게시 (미디어 첨부 지원)
# 사용법: x-post.sh "트윗 내용" [미디어파일1,미디어파일2,...]
# 환경변수 파일: ~/.x-poster.env

set -euo pipefail

# 환경변수 로드
ENV_FILE="$HOME/.x-poster.env"
if [[ ! -f "$ENV_FILE" ]]; then
  echo "ERROR: $ENV_FILE 파일이 없습니다."
  echo "~/.claude/plugins/x-poster/.env.example 을 참고하여 생성하세요."
  exit 1
fi
source "$ENV_FILE"

# 필수 환경변수 확인
for var in X_API_KEY X_API_SECRET X_ACCESS_TOKEN X_ACCESS_TOKEN_SECRET; do
  if [[ -z "${!var:-}" ]]; then
    echo "ERROR: $var 환경변수가 설정되지 않았습니다."
    exit 1
  fi
done

TWEET_TEXT="$1"
MEDIA_FILES="${2:-}"

if [[ -z "$TWEET_TEXT" ]]; then
  echo "ERROR: 트윗 내용을 인자로 전달하세요."
  echo "사용법: x-post.sh \"트윗 내용\" [미디어파일1,미디어파일2,...]"
  exit 1
fi

# 글자 수 확인 (X는 280자 제한)
CHAR_COUNT=${#TWEET_TEXT}
if [[ $CHAR_COUNT -gt 280 ]]; then
  echo "WARNING: 트윗이 ${CHAR_COUNT}자입니다 (제한: 280자). 잘릴 수 있습니다."
fi

# 퍼센트 인코딩 함수
percent_encode() {
  local string="$1"
  printf '%s' "$string" | curl -Gso /dev/null -w '%{url_effective}' --data-urlencode @- '' | cut -c 3-
}

# OAuth 1.0a 서명 생성 함수
generate_oauth_header() {
  local http_method="$1"
  local base_url="$2"
  local extra_params="${3:-}"

  local nonce
  nonce=$(openssl rand -hex 16)
  local timestamp
  timestamp=$(date +%s)

  local params="oauth_consumer_key=${X_API_KEY}&oauth_nonce=${nonce}&oauth_signature_method=HMAC-SHA1&oauth_timestamp=${timestamp}&oauth_token=${X_ACCESS_TOKEN}&oauth_version=1.0"
  if [[ -n "$extra_params" ]]; then
    params="${extra_params}&${params}"
    # 파라미터를 알파벳 순으로 정렬
    params=$(echo "$params" | tr '&' '\n' | sort | tr '\n' '&' | sed 's/&$//')
  fi

  local signature_base="${http_method}&$(percent_encode "$base_url")&$(percent_encode "$params")"
  local signing_key="$(percent_encode "$X_API_SECRET")&$(percent_encode "$X_ACCESS_TOKEN_SECRET")"
  local signature
  signature=$(printf '%s' "$signature_base" | openssl dgst -sha1 -hmac "$signing_key" -binary | base64)
  local encoded_signature
  encoded_signature=$(percent_encode "$signature")

  echo "OAuth oauth_consumer_key=\"${X_API_KEY}\", oauth_nonce=\"${nonce}\", oauth_signature=\"${encoded_signature}\", oauth_signature_method=\"HMAC-SHA1\", oauth_timestamp=\"${timestamp}\", oauth_token=\"${X_ACCESS_TOKEN}\", oauth_version=\"1.0\""
}

# 미디어 업로드 함수 (v1.1 media/upload API)
upload_media() {
  local file_path="$1"

  if [[ ! -f "$file_path" ]]; then
    echo "ERROR: 미디어 파일을 찾을 수 없습니다: $file_path" >&2
    return 1
  fi

  local upload_url="https://upload.twitter.com/1.1/media/upload.json"
  local auth_header
  auth_header=$(generate_oauth_header "POST" "$upload_url")

  local response
  response=$(curl -s -w "\n%{http_code}" -X POST "$upload_url" \
    -H "Authorization: ${auth_header}" \
    -F "media=@${file_path}")

  local http_code
  http_code=$(echo "$response" | tail -1)
  local body
  body=$(echo "$response" | sed '$d')

  if [[ "$http_code" == "200" ]] || [[ "$http_code" == "201" ]] || [[ "$http_code" == "202" ]]; then
    local media_id
    media_id=$(echo "$body" | python3 -c "import sys,json; print(json.loads(sys.stdin.read())['media_id_string'])" 2>/dev/null)
    if [[ -n "$media_id" ]]; then
      echo "$media_id"
      return 0
    fi
  fi

  echo "ERROR: 미디어 업로드 실패 (HTTP ${http_code}): ${body}" >&2
  return 1
}

# 미디어 파일 업로드 처리
MEDIA_IDS=()
if [[ -n "$MEDIA_FILES" ]]; then
  IFS=',' read -ra FILES <<< "$MEDIA_FILES"

  if [[ ${#FILES[@]} -gt 4 ]]; then
    echo "ERROR: 미디어는 최대 4개까지 첨부할 수 있습니다."
    exit 1
  fi

  for file in "${FILES[@]}"; do
    file=$(echo "$file" | xargs) # trim whitespace
    echo "미디어 업로드 중: $file"
    media_id=$(upload_media "$file")
    if [[ $? -ne 0 ]]; then
      echo "ERROR: 미디어 업로드에 실패했습니다."
      exit 1
    fi
    MEDIA_IDS+=("$media_id")
    echo "업로드 완료: media_id=$media_id"
  done
fi

# 트윗 JSON payload 구성
TWEET_JSON=$(python3 -c "
import json, sys
payload = {'text': sys.argv[1]}
media_ids = sys.argv[2:]
if media_ids:
    payload['media'] = {'media_ids': media_ids}
print(json.dumps(payload))
" "$TWEET_TEXT" "${MEDIA_IDS[@]+"${MEDIA_IDS[@]}"}")

# OAuth 서명 생성 (트윗 게시용)
TWEET_URL="https://api.x.com/2/tweets"
AUTH_HEADER=$(generate_oauth_header "POST" "$TWEET_URL")

# API 호출
RESPONSE=$(curl -s -w "\n%{http_code}" -X POST "$TWEET_URL" \
  -H "Authorization: ${AUTH_HEADER}" \
  -H "Content-Type: application/json" \
  -d "$TWEET_JSON")

HTTP_CODE=$(echo "$RESPONSE" | tail -1)
BODY=$(echo "$RESPONSE" | sed '$d')

if [[ "$HTTP_CODE" == "201" ]]; then
  TWEET_ID=$(echo "$BODY" | python3 -c "import sys,json; print(json.loads(sys.stdin.read())['data']['id'])" 2>/dev/null || echo "unknown")
  echo "SUCCESS: 트윗이 게시되었습니다!"
  echo "URL: https://x.com/i/status/${TWEET_ID}"
  echo "ID: ${TWEET_ID}"
else
  echo "ERROR: 트윗 게시 실패 (HTTP ${HTTP_CODE})"
  echo "응답: ${BODY}"
  exit 1
fi
