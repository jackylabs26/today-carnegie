#!/bin/bash
# 중단된 병합 마무리 + 푸시
set -e
cd "$(dirname "$0")"
find .git -name '*.lock' -delete 2>/dev/null || true
find .git/objects -name 'tmp_obj_*' -delete 2>/dev/null || true

git add -A
git commit --no-edit
git push origin main

echo
echo "커밋:       $(git rev-parse --short HEAD)"
echo "index.html: $(wc -c < index.html) bytes"
echo
echo "1~2분 뒤 반영:  https://carnegie.jackyailabs.com/"
