#!/usr/bin/env bash
#
# macos-defaults.sh — macOS defaults write optimizations for developer productivity
#
# Target: Apple Silicon M4, macOS Tahoe (26.x) / Sequoia (15.x)
# Profile: Bioinformatics researcher, Warp terminal, Claude Code user
#
# Research sources:
#   - mathiasbynens/dotfiles (.macos)
#   - holman/dotfiles (set-defaults.sh)
#   - webpro/dotfiles (defaults.sh)
#   - macos-defaults.com
#   - brettterpstra.com (Sequoia key repeat fix)
#
# Usage:
#   Review each section, comment out anything you don't want, then:
#   chmod +x defaults.sh && ./defaults.sh
#
# IMPORTANT: Many settings require logout/restart to take effect.
# Some settings require Terminal/Warp to have Full Disk Access
# (System Settings > Privacy & Security > Full Disk Access).
#
# =============================================================================

set -euo pipefail

echo "Applying macOS defaults..."
echo "Some changes require logout/restart to take effect."
echo ""

# Close System Settings to prevent it from overriding changes
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true
sleep 1

###############################################################################
# SECTION 1: KEYBOARD — CRITICAL FOR DEVELOPER PRODUCTIVITY                  #
# Category: STILL RELEVANT                                                    #
###############################################################################

echo "==> Keyboard settings..."

# Disable press-and-hold for keys in favor of key repeat
# CRITICAL on Sequoia/Tahoe: defaults to true, which completely breaks key repeat
# Without this, holding a key shows diacritics popover instead of repeating
# Source: brettterpstra.com/2024/12/03/key-repeat-in-sequoia/
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Set blazing fast key repeat rate (lower = faster, default is 6, GUI minimum is 2)
# Value of 1 gives ~30 chars/sec repeat rate — essential for vim-style navigation
defaults write NSGlobalDomain KeyRepeat -int 1

# Set short delay before key repeat starts (lower = faster, default is 68, GUI min is 25)
# Value of 15 means almost instant repeat when holding a key
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Enable full keyboard access for all UI controls
# Tab through all controls in dialogs (buttons, lists, etc.) not just text fields
# NOTE: Changed from -int 3 to -int 2 in Sequoia/Tahoe
defaults write NSGlobalDomain AppleKeyboardUIMode -int 2

# Disable automatic capitalization — annoying when writing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes — they replace -- with em-dash, breaks code/cli
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution (double-space inserts period)
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes — they replace straight quotes with curly quotes, breaks code
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct — constantly fights technical terminology
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# SECTION 2: FINDER — FILE MANAGEMENT SPEED                                  #
# Category: STILL RELEVANT                                                    #
###############################################################################

echo "==> Finder settings..."

# Show all file extensions (security + clarity — see .app, .dmg, .sh, etc.)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show status bar (shows item count, disk space at bottom of Finder)
defaults write com.apple.finder ShowStatusBar -bool true

# Show path bar (breadcrumb path at bottom of Finder windows)
defaults write com.apple.finder ShowPathbar -bool true

# Show full POSIX path in Finder window title
# Incredibly useful — see /Users/scott/Code/project instead of just "project"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When searching, search the current folder by default (not "This Mac")
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Default to list view in Finder windows
# Four-letter codes: Nlsv (list), icnv (icon), clmv (column), glyv (gallery)
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# Avoid creating .DS_Store files on USB volumes
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable Finder animations (slightly faster window opening)
defaults write com.apple.finder DisableAllAnimations -bool true

# New Finder windows show home directory
# PfDe=Desktop, PfHm=Home, PfLo=custom path (set NewWindowTargetPath)
defaults write com.apple.finder NewWindowTarget -string "PfHm"

# Show hidden files by default (dotfiles, .git, etc.)
# Toggle with Cmd+Shift+. in Finder
defaults write com.apple.finder AppleShowAllFiles -bool true

###############################################################################
# SECTION 3: DOCK & MISSION CONTROL — SCREEN REAL ESTATE                     #
# Category: STILL RELEVANT                                                    #
###############################################################################

echo "==> Dock & Mission Control settings..."

# Auto-hide the Dock — reclaim screen space
defaults write com.apple.dock autohide -bool true

# Remove the auto-hide delay — Dock appears instantly on hover
defaults write com.apple.dock autohide-delay -float 0

# Speed up the Dock show/hide animation (0 = instant, default ~0.5)
defaults write com.apple.dock autohide-time-modifier -float 0.2

# Set Dock icon size to 36 pixels (smaller = more space)
defaults write com.apple.dock tilesize -int 36

# Don't show recent applications in Dock (wastes space)
defaults write com.apple.dock show-recents -bool false

# Minimize windows into their application's icon (cleaner Dock)
defaults write com.apple.dock minimize-to-application -bool true

# Use scale effect for minimizing (faster than genie effect)
defaults write com.apple.dock mineffect -string "scale"

# Don't automatically rearrange Spaces based on most recent use
# Prevents disorienting space reordering when switching apps
defaults write com.apple.dock mru-spaces -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Disable bouncing icon animation when launching apps
defaults write com.apple.dock launchanim -bool false

# Don't group windows by application in Mission Control
# Makes it easier to find specific windows
defaults write com.apple.dock expose-group-by-app -bool false

# Make hidden app icons translucent in the Dock
defaults write com.apple.dock showhidden -bool true

###############################################################################
# SECTION 4: WINDOW MANAGEMENT & ANIMATIONS — SPEED                          #
# Category: STILL RELEVANT                                                    #
###############################################################################

echo "==> Window & animation settings..."

# Speed up window resize animations (near-instant)
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Expand save panel by default (skip clicking the disclosure triangle)
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Disable the "Are you sure you want to open this application?" dialog
# Only do this if you trust yourself not to run random downloaded apps
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Disable the focus ring animation
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Set spring loading speed to instant (drag file over folder to open)
defaults write NSGlobalDomain com.apple.springing.delay -float 0

###############################################################################
# SECTION 5: SCREENSHOTS                                                     #
# Category: STILL RELEVANT (except PDF type — broken on Tahoe)               #
###############################################################################

echo "==> Screenshot settings..."

# Save screenshots to ~/Screenshots instead of cluttering Desktop
mkdir -p "${HOME}/Screenshots"
defaults write com.apple.screencapture location -string "${HOME}/Screenshots"

# Save screenshots in PNG format (lossless, good for code/UI screenshots)
# NOTE: PDF type is BROKEN on macOS Tahoe — avoid using "pdf"
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots (cleaner for documentation/bug reports)
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# SECTION 6: TRACKPAD                                                        #
# Category: STILL RELEVANT                                                   #
###############################################################################

echo "==> Trackpad settings..."

# Enable tap to click (more responsive than physical click)
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Increase trackpad tracking speed (default ~1.5, max 5.0)
# 3.0 is a good balance — fast without being twitchy
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 3.0

###############################################################################
# SECTION 7: SECURITY & PRIVACY                                              #
# Category: STILL RELEVANT                                                   #
###############################################################################

echo "==> Security settings..."

# Require password immediately after sleep or screen saver begins
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# SECTION 8: SAFARI (DEVELOPER TOOLS)                                        #
# Category: STILL RELEVANT for Safari debugging                              #
###############################################################################

echo "==> Safari developer settings..."

# Enable Safari Develop menu and Web Inspector
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add Web Inspector to context menu globally
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

# Show the full URL in the address bar
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Don't open "safe" files after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

###############################################################################
# SECTION 9: ACTIVITY MONITOR                                                #
# Category: STILL RELEVANT                                                   #
###############################################################################

echo "==> Activity Monitor settings..."

# Show CPU usage in Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# SECTION 10: MISC DEVELOPER-RELEVANT                                        #
# Category: STILL RELEVANT                                                   #
###############################################################################

echo "==> Miscellaneous developer settings..."

# TextEdit: default to plain text (not rich text)
defaults write com.apple.TextEdit RichText -int 0
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

# Prevent Time Machine from prompting to use new drives as backup volumes
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

# Help Viewer windows are non-floating (so they don't cover your work)
defaults write com.apple.helpviewer DevMode -bool true

###############################################################################
# SECTION 11: MAIL (if you use Apple Mail)                                   #
# Category: STILL RELEVANT                                                   #
###############################################################################

echo "==> Mail settings..."

# Disable send/reply animations
defaults write com.apple.mail DisableReplyAnimations -bool true
defaults write com.apple.mail DisableSendAnimations -bool true

# Copy email addresses as "user@example.com" not "Name <user@example.com>"
defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

###############################################################################
# RESTART AFFECTED APPLICATIONS                                              #
###############################################################################

echo ""
echo "==> Restarting affected applications..."

for app in "Activity Monitor" "Dock" "Finder" "Mail" "Safari" "SystemUIServer"; do
    killall "${app}" &>/dev/null || true
done

echo ""
echo "Done! Some changes require a logout/restart to take effect."
echo ""
echo "IMPORTANT: For key repeat changes, you MUST log out and back in (or restart)."
