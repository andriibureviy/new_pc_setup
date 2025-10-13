#!/usr/bin/env bash
set -euo pipefail

# =========================================================
#  YABAI + SKHD.ZIG Fresh Mac Setup
#  - Homebrew, jq
#  - yabai (koekeishiya/formulae)
#  - skhd-zig (jackielii/tap)
#  - Configs for ~/.config/yabai/yabairc and ~/.config/skhd/skhdrc
#  - Launch at login
#  - App hotkeys: Slack, Chrome, Telegram (Desktop), iTerm, RubyMine
# =========================================================

echo ">>> Checking Homebrew…"
if ! command -v brew >/dev/null 2>&1; then
  echo ">>> Installing Homebrew…"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # add brew to PATH for Apple Silicon
  if [[ -d /opt/homebrew/bin ]]; then
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi
fi

echo ">>> Ensuring taps and packages…"
brew tap koekeishiya/formulae
brew tap jackielii/tap
brew install jq
brew install koekeishiya/formulae/yabai
brew install jackielii/tap/skhd-zig

echo ">>> Creating config directories…"
mkdir -p "$HOME/.config/yabai" "$HOME/.config/skhd"

# ------------------ YABAI CONFIG ------------------
cat > "$HOME/.config/yabai/yabairc" <<'YABAI'
#!/usr/bin/env sh
# ---------- Basic tiling ----------
yabai -m config layout bsp
yabai -m config window_gap 12
yabai -m config top_padding 10
yabai -m config bottom_padding 10
yabai -m config left_padding 10
yabai -m config right_padding 10

# Focus/Mouse behavior
yabai -m config mouse_follows_focus on
yabai -m config focus_follows_mouse autoraise
yabai -m config window_placement second_child

# Optional aesthetics (supported for v7+)
# (Uncomment if you like borders; comment if your build doesn’t support these)
# yabai -m config active_window_border_color 0xffd75f00
# yabai -m config normal_window_border_color 0xff444444
# yabai -m config active_window_border_width 3
# yabai -m config window_border on

# ---------- float rules (common) ----------
yabai -m rule --add app="System Settings" manage=off
yabai -m rule --add app="System Preferences" manage=off
yabai -m rule --add app="App Store" manage=off
yabai -m rule --add app="Finder" manage=off
yabai -m rule --add app="Spotify" manage=off
yabai -m rule --add app="OBS" manage=off

# ---------- apply on load ----------
yabai -m signal --add event=display_added action="yabai -m config layout bsp"
yabai -m signal --add event=space_changed action="yabai -m config layout bsp"
YABAI

chmod +x "$HOME/.config/yabai/yabairc"

# ------------------ SKHD.ZIG CONFIG ------------------
# NOTE: skhd.zig expects literal keys and lower-case letters; avoid names like 'backslash'
cat > "$HOME/.config/skhd/skhdrc" <<'SKHD'
# =========================================
#              SKHD.ZIG CONFIG
# =========================================

# -------- Reload skhd --------
ctrl + alt - r : skhd --reload

# -------- Test hotkey (optional) --------
alt - t : echo "SKHD HOTKEY $(date)" >> "$HOME/skhd_test.log"

# -------- Focus windows (BSP) --------
alt - h : yabai -m window --focus west
alt - j : yabai -m window --focus south
alt - k : yabai -m window --focus north
alt - l : yabai -m window --focus east

# -------- Swap windows --------
shift + alt - h : yabai -m window --swap west
shift + alt - j : yabai -m window --swap south
shift + alt - k : yabai -m window --swap north
shift + alt - l : yabai -m window --swap east

# -------- Move/warp window within display --------
ctrl + alt - h : yabai -m window --warp west
ctrl + alt - j : yabai -m window --warp south
ctrl + alt - k : yabai -m window --warp north
ctrl + alt - l : yabai -m window --warp east

# -------- Toggle float / fullscreen --------
alt - space : yabai -m window --toggle float
alt - f     : yabai -m window --toggle zoom-fullscreen

# -------- Toggle split orientation (vertical <-> horizontal) --------
# Use a simple key to avoid parser issues (backslash key names vary)
alt - v : yabai -m window --toggle split

# -------- Move window between monitors (3 monitors) --------
# Prev/Next:
shift + alt - s : yabai -m window --display prev; yabai -m display --focus prev
shift + alt - g : yabai -m window --display next; yabai -m display --focus next

# Direct to display index (adjust if your indexes differ):
shift + alt - 1 : yabai -m window --display 1; yabai -m display --focus 1
shift + alt - 2 : yabai -m window --display 2; yabai -m display --focus 2
shift + alt - 3 : yabai -m window --display 3; yabai -m display --focus 3

# -------- Focus spaces (no window move) --------
ctrl + alt - 1 : yabai -m space --focus 1
ctrl + alt - 2 : yabai -m space --focus 2
ctrl + alt - 3 : yabai -m space --focus 3
ctrl + alt - 4 : yabai -m space --focus 4
ctrl + alt - 5 : yabai -m space --focus 5

# -------- App Focus / Launch --------
# Slack
alt - s : open -a "Slack"

# Chrome
alt - c : open -a "Google Chrome"

# Telegram (Desktop build fallback)
alt - t : (open -a "Telegram" || open -a "Telegram Desktop")

# iTerm
alt - i : open -a "iTerm"

# RubyMine
alt - r : open -a "RubyMine"

ctrl + alt - s : yabai -m display --focus prev
ctrl + alt - g : yabai -m display --focus next
ctrl + alt - 1 : yabai -m display --focus 1
ctrl + alt - 2 : yabai -m display --focus 2
ctrl + alt - 3 : yabai -m display --focus 3
SKHD

# ------------------ START SERVICES ------------------
echo ">>> Starting yabai (user launch agent)…"
yabai --stop-service >/dev/null 2>&1 || true
yabai --start-service

echo ">>> Starting skhd-zig as a login service…"
brew services stop jackielii/tap/skhd-zig >/dev/null 2>&1 || true
brew services start jackielii/tap/skhd-zig

# ------------------ OPTIONAL: SUDOERS FOR SA (commented) ------------------
# For full scripting-addition features (requires SIP disabled in Recovery), you may enable:
#   - Create sudoers.d entry so 'yabai --load-sa' runs without prompting.
#   - Then `killall Dock` to inject.
# Uncomment the block below IF you have disabled SIP and want SA.

: <<'OPT_SA'
echo ">>> Configuring sudoers for yabai --load-sa (requires sudo)…"
YABAI_BIN="$(which yabai)"
HASH="$(shasum -a 256 "$YABAI_BIN" | awk '{print $1}')"
LINE="$(whoami) ALL=(root) NOPASSWD: sha256:${HASH} ${YABAI_BIN} --load-sa"
echo "$LINE" | sudo tee /private/etc/sudoers.d/yabai >/dev/null
echo ">>> Loading scripting addition (will restart Dock)…"
sudo "$YABAI_BIN" --load-sa || true
killall Dock || true
OPT_SA

# ------------------ DONE ------------------
echo ""
echo "✅ Done! Next steps:"
echo "1) System Settings → Privacy & Security → Accessibility →"
echo "   - Add and enable: /opt/homebrew/bin/yabai"
echo "   - Add and enable: /opt/homebrew/opt/skhd-zig/bin/skhd"
echo "2) (Optional) Privacy & Security → Screen Recording → enable for your terminal if needed."
echo "3) Verify displays:  yabai -m query --displays | jq '.[].index'   (should be 1/2/3)"
echo "4) Reload skhd anytime with:  skhd --reload"
echo ""
echo "Try these:"
echo "  • alt+h/j/k/l  → focus windows"
echo "  • shift+alt+s/g → move window to prev/next monitor"
echo "  • shift+alt+1/2/3 → move window to a specific monitor"
echo "  • alt+v        → toggle split orientation"
echo "  • alt+s/c/t/i/r → Slack / Chrome / Telegram / iTerm / RubyMine"
