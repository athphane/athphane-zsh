cool-freeze() {
  # Require clipboard tool first
  local clip_cmd=""
  if command -v wl-copy >/dev/null 2>&1; then
    clip_cmd="wl-copy --type image/png"
  elif command -v xclip >/dev/null 2>&1; then
    clip_cmd="xclip -selection clipboard -t image/png -i"
  elif command -v pngpaste >/dev/null 2>&1; then
    clip_cmd="pngpaste"
  else
    echo "❌ No clipboard utility found. Install one of: wl-clipboard, xclip, or pngpaste." >&2
    return 1
  fi

  local dir="${COOL_FREEZE_DIR:-$HOME/Pictures/freeze}"
  mkdir -p "$dir" || return

  local input
  if command -v fd >/dev/null 2>&1; then
    input=$(fd -t f . | gum filter --placeholder "Select a file to screenshot") || return
  else
    input=$(find . -type f | gum filter --placeholder "Select a file to screenshot") || return
  fi

  local stamp base out
  stamp="$(date +%Y%m%d-%H%M%S)"
  base="${${input##*/}%.*}"
  out="$dir/${base}-${stamp}.png"

  freeze "$input" \
    --theme dracula \
    --window \
    --border.radius 12 \
    --border.width 1 --border.color "#444" \
    --shadow.blur 20 --shadow.x 0 --shadow.y 12 \
    --padding 32,48 \
    --margin 40 \
    --background "#0f111a" \
    --font.family "JetBrains Mono" \
    --font.size 16 \
    --line-height 1.4 \
    --show-line-numbers \
    -o "$out" || return

  eval "$clip_cmd" < "$out"
  echo "✅ Saved → $out (copied to clipboard)"
}
