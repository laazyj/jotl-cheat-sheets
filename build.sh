#!/usr/bin/env bash
#
# Regenerate the JOTL cheat-sheet PDFs from src/jotl-cheat-sheets.html.
#
# Usage:
#   ./build.sh [output_dir]      # default: ./build
#
# Renders the four-page A4 document, then splits it into one PDF per
# character. Requires headless Google Chrome (or Chromium). PDF splitting
# uses poppler's `pdfseparate` if present, else falls back to Chrome page
# ranges. Print the results at 100% / Actual Size — never "fit to page".

set -euo pipefail
cd "$(dirname "$0")"

OUT="${1:-build}"
SRC="src/jotl-cheat-sheets.html"

# locate a Chrome/Chromium binary
CHROME=""
for c in \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Chromium.app/Contents/MacOS/Chromium" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)"; do
  if [ -n "$c" ] && [ -x "$c" ]; then CHROME="$c"; break; fi
done
if [ -z "$CHROME" ]; then
  echo "error: no Chrome/Chromium found — install it or edit CHROME in build.sh" >&2
  exit 1
fi

mkdir -p "$OUT"
COMBINED="$OUT/jotl-cheat-sheets.pdf"

echo "Rendering $SRC -> $COMBINED"
"$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
  --virtual-time-budget=5000 \
  --print-to-pdf="$COMBINED" "file://$PWD/$SRC" 2>/dev/null

# per-character page order must match the sheets in the HTML
NAMES=(
  "1-hatchet-scenario-setup"
  "2-red-guard-the-round"
  "3-voidwarden-the-reckoning"
  "4-demolitionist-levelling-up"
)

if command -v pdfseparate >/dev/null 2>&1; then
  pdfseparate "$COMBINED" "$OUT/page-%d.pdf"
  for i in "${!NAMES[@]}"; do
    mv "$OUT/page-$((i+1)).pdf" "$OUT/${NAMES[$i]}.pdf"
  done
else
  for i in "${!NAMES[@]}"; do
    "$CHROME" --headless=new --disable-gpu --no-pdf-header-footer \
      --virtual-time-budget=5000 --print-to-pdf-page-ranges="$((i+1))" \
      --print-to-pdf="$OUT/${NAMES[$i]}.pdf" "file://$PWD/$SRC" 2>/dev/null
  done
fi

echo "Done. Output in $OUT/"
ls -1 "$OUT"/*.pdf
