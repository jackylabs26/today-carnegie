#!/bin/bash
# 오늘의 카네기 원칙 — GitHub Pages 배포 마무리
set -e
cd "$(dirname "$0")"
REPO=jackylabs26/today-carnegie

echo "▶ 1/5  샌드박스가 남긴 git 잠금 파일 정리"
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true

echo "▶ 2/5  브랜치를 main 으로 정리하고 커밋"
git branch -M main
git add -A
git diff --cached --quiet || git commit -m "OG 메타를 github.io 주소로 수정"

echo "▶ 3/5  push"
git push -u origin main

echo "▶ 4/5  기본 브랜치를 main 으로 전환"
gh repo edit "$REPO" --default-branch main
git push origin --delete master 2>/dev/null || true

echo "▶ 5/5  GitHub Pages 활성화"
gh api -X POST "repos/$REPO/pages" --input - <<< '{"source":{"branch":"main","path":"/"}}' \
  || gh api -X PUT "repos/$REPO/pages" --input - <<< '{"source":{"branch":"main","path":"/"}}'

echo
echo "완료. 1~2분 뒤 아래 주소가 열립니다:"
echo "  https://jackylabs26.github.io/today-carnegie/"
