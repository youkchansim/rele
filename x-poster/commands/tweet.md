---
name: tweet
description: 커밋 기반 X 트윗 자동 생성 및 게시
arguments:
  - name: type
    description: "콘텐츠 유형 (bip, showcase, insight, tech, all)"
    required: false
  - name: days
    description: "분석할 커밋 기간 (기본: 2일)"
    required: false
---

커밋 히스토리를 분석하여 X 트윗을 자동 생성하고 게시하는 스킬을 실행합니다.

$ARGUMENTS
