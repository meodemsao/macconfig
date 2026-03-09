#!/bin/bash

# ==============================================================================
# Raycast Configuration - Replace Spotlight
# ==============================================================================

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Disable Spotlight keyboard shortcut (Cmd+Space)
print_warning "Disabling Spotlight keyboard shortcut..."

# Disable Spotlight shortcut via defaults
# This unchecks "Show Spotlight search" in System Settings → Keyboard → Keyboard Shortcuts → Spotlight
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 64 "<dict><key>enabled</key><false/><key>value</key><dict><key>parameters</key><array><integer>65535</integer><integer>49</integer><integer>1048576</integer></array><key>type</key><string>standard</string></dict></dict>"

print_success "Spotlight keyboard shortcut disabled"

# Optionally disable Spotlight indexing to save resources
echo ""
echo "  Do you also want to disable Spotlight indexing?"
echo "  (This saves CPU/battery, but you lose Spotlight search entirely)"
echo ""
read -p "  Disable Spotlight indexing? (y/n) " -n 1 -r
echo

if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Disabling Spotlight indexing..."
    sudo mdutil -a -i off &>/dev/null
    print_success "Spotlight indexing disabled"
else
    print_warning "Keeping Spotlight indexing enabled (only shortcut disabled)"
fi

# Activate settings changes
/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u &>/dev/null || true

echo ""
print_success "Raycast configured as Spotlight replacement"
echo ""
echo -e "  ${CYAN}⚠️  Manual step required:${NC}"
echo "  1. Open Raycast (it should auto-start after install)"
echo "  2. Go to Raycast Preferences (Cmd+,)"
echo "  3. In General tab, click 'Record Hotkey'"
echo "  4. Press Cmd+Space to set it as the Raycast hotkey"
echo ""
