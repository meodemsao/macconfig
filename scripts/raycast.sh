#!/bin/bash

# ==============================================================================
# Raycast Setup
#
# Spotlight is left completely untouched here - neither its Cmd+Space shortcut
# nor its index. Raycast runs alongside it on its own hotkey.
# ==============================================================================

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ ! -d "/Applications/Raycast.app" ]; then
    print_error "Raycast.app not found in /Applications - install it first (scripts/brew.sh)"
    return 0 2>/dev/null || exit 0
fi

# Launch Raycast so the user lands in onboarding right away instead of having
# an installed app that was never opened and therefore has no hotkey.
open -a Raycast
print_success "Raycast launched"

echo ""
echo -e "  ${CYAN}Manual step:${NC} gán hotkey cho Raycast"
echo "  1. Hoàn tất onboarding của Raycast vừa mở"
echo "  2. Raycast Preferences (Cmd+,) → General → Record Hotkey"
echo "  3. Chọn tổ hợp KHÔNG trùng Spotlight, ví dụ Option+Space"
echo "     (Cmd+Space vẫn thuộc về Spotlight)"
echo "  4. Bật 'Launch Raycast at login' trong cùng tab General"
echo ""
