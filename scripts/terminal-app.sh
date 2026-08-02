#!/bin/bash

# ==============================================================================
# Terminal.app Font - Set Nerd Font for all profiles
# ==============================================================================
#
# Terminal.app khong doc config tu dotfiles, font nam trong
# com.apple.Terminal.plist duoi dang NSFont da archive nen phai set qua
# AppleScript. Ghostty/WezTerm da co font trong config rieng cua chung.
#
# Dung ban "Nerd Font Mono" (NFM): Terminal.app yeu cau monospace nghiem ngat,
# ban thuong co glyph rong gap doi se bi cat hoac render sai.
#
# Override font bang: TERMINAL_APP_FONT="FiraCodeNFM-Reg" ./install.sh
# Bo qua buoc nay bang: SKIP_TERMINAL_APP_FONT=true ./install.sh
#
# Phai dung PostScript name, khong phai ten hien thi, va ten nay khong doan duoc
# (JetBrainsMono la "...NFM-Regular" nhung FiraCode la "...NFM-Reg"). Tra cuu bang:
#   system_profiler SPFontsDataType | grep -B 20 "Family: <ten family>"

if [ "$SKIP_TERMINAL_APP_FONT" = "true" ]; then
    print_success "Skipping Terminal.app font (SKIP_TERMINAL_APP_FONT=true)"
    return 0 2>/dev/null || exit 0
fi

TERMINAL_APP_FONT="${TERMINAL_APP_FONT:-JetBrainsMonoNFM-Regular}"

# Map PostScript name -> file name de bao loi som cho 2 font repo nay cai san.
# Font khac thi bo qua buoc nay, doan set ben duoi van tu xac nhan lai.
case "$TERMINAL_APP_FONT" in
    JetBrainsMonoNFM-Regular) FONT_FILE="JetBrainsMonoNerdFontMono-Regular.ttf" ;;
    FiraCodeNFM-Reg)          FONT_FILE="FiraCodeNerdFontMono-Regular.ttf" ;;
    *)                        FONT_FILE="" ;;
esac

if [ -n "$FONT_FILE" ] && \
   [ ! -f "$HOME/Library/Fonts/$FONT_FILE" ] && \
   [ ! -f "/Library/Fonts/$FONT_FILE" ]; then
    print_error "Font $TERMINAL_APP_FONT chua duoc cai (khong tim thay $FONT_FILE)"
    print_warning "Chay scripts/brew.sh truoc de cai Nerd Fonts"
    return 0 2>/dev/null || exit 0
fi

print_warning "Setting Terminal.app font to $TERMINAL_APP_FONT..."

# Set font cho tat ca profiles, giu nguyen font size rieng cua tung profile
# Luu y: khong dung dau nhay don trong AppleScript nay (vi du "AppleScript's")
# vi heredoc nam trong $(...) se bi bash parse nham thanh mo chuoi.
OSA_RESULT=$(osascript <<EOF 2>&1
set applied to 0
set failedNames to ""
tell application "Terminal"
    repeat with s in settings sets
        -- Terminal.app am tham bo qua font khong hop le va van bao thanh cong,
        -- nen phai doc lai gia tri de xac nhan thuc su da duoc set.
        set okFlag to false
        try
            set font name of s to "$TERMINAL_APP_FONT"
            if (font name of s) is "$TERMINAL_APP_FONT" then set okFlag to true
        end try
        if okFlag then
            set applied to applied + 1
        else if failedNames is "" then
            set failedNames to name of s
        else
            set failedNames to failedNames & ", " & (name of s)
        end if
    end repeat
end tell
if failedNames is "" then
    return "OK:" & applied
else
    return "PARTIAL:" & applied & ":" & failedNames
end if
EOF
)

case "$OSA_RESULT" in
    OK:*)
        print_success "Terminal.app font set for ${OSA_RESULT#OK:} profile(s)"
        print_warning "Mo cua so Terminal moi (Cmd+N) de thay thay doi"
        ;;
    PARTIAL:*)
        REST="${OSA_RESULT#PARTIAL:}"
        print_warning "Terminal.app font set for ${REST%%:*} profile(s)"
        print_error "Khong set duoc cho: ${REST#*:}"
        print_warning "Kiem tra lai PostScript name cua $TERMINAL_APP_FONT (xem chu thich dau file)"
        ;;
    *)
        # Thuong gap: loi -1743 khi app dang chay chua duoc cap quyen Automation
        print_error "Khong set duoc font cho Terminal.app"
        echo "  $OSA_RESULT"
        print_warning "Cap quyen tai System Settings > Privacy & Security > Automation,"
        print_warning "hoac set thu cong: Terminal > Settings > Profiles > Font > Change"
        ;;
esac
