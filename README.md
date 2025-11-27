# rele

개인 사이드 프로젝트를 위한 Skills 마켓플레이스입니다.

## 설치 방법

### 방법 1: Plugin Marketplace로 설치 (권장)

```bash
# Claude Code에서 마켓플레이스 추가
/plugin marketplace add youkchansim/rele

# 스킬 설치
/plugin install ios-fastlane-deploy@rele
```

### 방법 2: 직접 스킬 복사

개인 스킬로 설치 (모든 프로젝트에서 사용):
```bash
cp -r ~/rele/ios-fastlane-deploy ~/.claude/skills/
```

프로젝트 스킬로 설치 (팀 공유):
```bash
cp -r ~/rele/ios-fastlane-deploy ./.claude/skills/
git add .claude/skills/ios-fastlane-deploy
git commit -m "Add ios-fastlane-deploy skill"
```

## 사용 가능한 Skills

| Skill | 설명 |
|-------|------|
| [ios-fastlane-deploy](./ios-fastlane-deploy) | iOS 앱 자동 배포 (App Store, TestFlight) |

## 라이선스

MIT
