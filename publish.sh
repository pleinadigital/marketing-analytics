#!/usr/bin/env bash
set -euo pipefail

SRC="$HOME/brands/kalamazoo/projects/mbr_v2/output/dashboard.html"
SITE_DIR="$HOME/brands/kalamazoo/projects/marketing-analytics"
DEST="$SITE_DIR/index.html"
LIVE_URL="https://pleinadigital.github.io/marketing-analytics/"

if [[ ! -f "$SRC" ]]; then
  echo "Error: source dashboard not found at $SRC" >&2
  exit 1
fi

cp "$SRC" "$DEST"
cd "$SITE_DIR"

if git diff --quiet -- index.html; then
  echo "No changes to publish — index.html already matches the latest dashboard."
  exit 0
fi

MSG="${1:-Publish dashboard $(date +%Y-%m-%d\ %H:%M)}"
git add index.html
git commit -m "$MSG"
git push origin main

echo
echo "Pushed. GitHub Pages will rebuild in ~30-60s."
echo "Live URL: $LIVE_URL"
echo "(CDN cache is 10 min — hard-refresh if you don't see updates.)"
