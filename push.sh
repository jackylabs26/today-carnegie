#!/bin/bash
# 변경사항을 GitHub Pages 로 반영
set -e
cd "$(dirname "$0")"
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true
git add -A
git diff --cached --quiet && { echo "변경사항 없음"; exit 0; }
git commit -m "${1:-콘텐츠 업데이트}"
git push
echo
echo "1~2분 뒤 반영됩니다:  https://jackylabs26.github.io/today-carnegie/"
