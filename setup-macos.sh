#!/bin/sh
# Sets up my macOS defaults.
#
# Run ./setup-macos.sh

set +e

disable_agent() {
	mv "$1" "$1_DISABLED" >/dev/null 2>&1 ||
		sudo mv "$1" "$1_DISABLED" >/dev/null 2>&1
}

unload_agent() {
	launchctl unload -w "$1" >/dev/null 2>&1
}

sudo -v

###############################################################################
# System                                                                      #
###############################################################################

echo ""
echo "› System:"

echo "  › # Set highlight color to green"
defaults write NSGlobalDomain AppleHighlightColor -string "0.764700 0.976500 0.568600"

echo "  › # Automatically quit printer app once the print jobs complete"
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

echo "  › # Trackpad: enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

echo "  › # Trackpad: map bottom right corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

echo "  › Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  › Use AirDrop over every interface (Wifi & Ethernet)"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

echo "  › Create the ~/projects folder"
mkdir ~/projects

echo "  › Create the ~/Screenshots folder and save as default location for screenshots"
mkdir ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

echo "  › Show the /Volumes folder"
sudo chflags nohidden /Volumes

echo "  › Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

echo "  › Enable text replacement almost everywhere"
defaults write -g WebAutomaticTextReplacementEnabled -bool true

echo "  › Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

echo "  › Require password 1min after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 6000

echo "  › Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "WhenScrolling"

echo "  › Disable Dashboard"
defaults write com.apple.dashboard mcx-disabled -bool true

echo "  › Increase the window resize speed for Cocoa applications"
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

echo "  › Disable smart quotes and smart dashes as they're annoying when typing code"
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

echo "  › Disable auto-correct"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

echo "  › Set up trackpad & mouse speed to a reasonable number"
defaults write -g com.apple.trackpad.scaling 2
defaults write -g com.apple.mouse.scaling 2.5

echo "  › Avoid the creation of .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

echo "  › Disable the 'Are you sure you want to open this application?' dialog"
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "  › Show battery percent"
defaults write com.apple.menuextra.battery ShowPercent -bool true

echo "  › Speed up wake from sleep to 24 hours from an hour"
sudo pmset -a standbydelay 86400

echo "  › Removing duplicates in the 'Open With' menu"
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister \
	-kill -r -domain local -domain system -domain user

###############################################################################
# Finder                                                                      #
###############################################################################

echo ""
echo "› Finder:"

echo "  › # Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons"
defaults write com.apple.finder QuitMenuItem -bool true

echo "  › Always open everything in Finder's list view"
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

echo "  › Set the Finder prefs for showing a few different volumes on the Desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

echo "  › Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true

echo "  › Set sidebar icon size to medium"
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

echo "  › Show status bar"
defaults write com.apple.finder ShowStatusBar -bool true

echo "  › Show path bar"
defaults write com.apple.finder ShowPathbar -bool true

echo "  › Disable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool false

echo "  › Save to disk by default, instead of iCloud"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

echo "  › Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

echo "  › Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

###############################################################################
# Hot corners                                                                 #
###############################################################################

echo ""
echo "› Hot corners"

echo "  › # Bottom right screen corner → Show desktop"
defaults write com.apple.dock wvous-br-corner -int 4
defaults write com.apple.dock wvous-br-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

echo ""
echo "› Safari and Webkit:"

echo "  › # Privacy: don’t send search queries to Apple"
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

echo "  › # Enable continuous spellchecking"
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true

echo "  › # Enable “Do Not Track"
defaults write com.apple.Safari SendDoNotTrackHTTPHeader -bool true

echo "  › # Update extensions automatically"
defaults write com.apple.Safari InstallExtensionUpdatesAutomatically -bool true

echo "  › Hide Safari's bookmark bar"
defaults write com.apple.Safari ShowFavoritesBar -bool false

echo "  › Set up Safari for development"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

echo "  › Disable the annoying backswipe in Chrome"
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false

###############################################################################
# Mac App Store                                                               #
###############################################################################

echo ""
echo "› Mac app store:"

echo "  › # Turn on app auto-update"
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

echo ""
echo "› Photos:"
echo "  › Disable it from starting everytime a device is plugged in"
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Dock                                                                        #
###############################################################################

echo ""
echo "› Dock"
echo "  › Setting the icon size of Dock items to 45 pixels for optimal size/screen-realestate"
defaults write com.apple.dock tilesize -int 45

echo "  › Speeding up Mission Control animations and grouping windows by application"
defaults write com.apple.dock expose-animation-duration -float 0.1
defaults write com.apple.dock "expose-group-by-app" -bool true

echo "  › Remove the auto-hiding Dock delay"
defaults write com.apple.dock autohide-delay -float 0

echo "  › Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

echo "  › Don't animate opening applications from the Dock"
defaults write com.apple.dock launchanim -bool false

###############################################################################
# Time machine                                                                #
###############################################################################

echo ""
echo "› Time Machine:"
echo "  › Prevent Time Machine from prompting to use new hard drives as backup volume"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

###############################################################################
# Media                                                                       #
###############################################################################

echo ""
echo "› Media:"

echo "  › Disable Spotify web helper"
disable_agent ~/Applications/Spotify.app/Contents/MacOS/SpotifyWebHelper

#############################

echo ""
echo "› Kill related apps"
for app in "cfprefsd" "Dock" "Finder" "Messages" "Safari" "SystemUIServer" \
	"Terminal" "Photos"; do
	killall "$app" >/dev/null 2>&1
done

###############################################################################
# Apps                                                                       #
###############################################################################

echo ""
echo "› Install apps:"

echo "  › Install Xcode Command Line Tools"
defaults write -g ApplePressAndHoldEnabled -bool false

echo "  › Install Homebrew"
curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh

echo "  › Install Homebrew formulae"
brew install git yarn zsh gh

echo "  › Install Homebrew-cask"
brew tap caskroom/homebrew-cask
brew install brew-cask

echo "  › Install Homebrew casks"
apps=(
  alfred
  1password
  cloudapp
  docker
  dropbox
  firefox
  focus
  google-chrome
  hyper
  notion
  ngrok
  mattermost
  muzzle
  sketch
  spotify
  tempo
  tower
  visual-studio-code
  whatsapp
  zeplin
)
brew cask install --appdir="~/Applications" ${apps[@]}

echo "  › Cleaning up"
brew cleanup

###############################################################################
# Other tooling                                                               #
###############################################################################

echo " > Install Node Version Manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh
nvm install node
nvm use node

echo " > Install CLI and Dev tools"
npm install -g netlify-cli gatsby-cli browser-sync

echo "  › Config Git"
git config --global user.name "Barry McGee"
git config --global user.email barry.mcgee@integralcode.co.uk

echo "Cloning common projects from Github"
cd ~/projects

git clone https://github.com/barrymcgee/react-components.git
cd react-components
git remote add upstream https://github.com/canonical-web-and-design/react-components.git
cd ../

git clone https://github.com/barrymcgee/jaas.ai
cd jaas.ai
git remote add upstream https://github.com/canonical-web-and-design/jaas.ai.git
cd ../

git clone https://github.com/barrymcgee/juju.is
cd juju.is
git remote add upstream https://github.com/canonical-web-and-design/juju.is.git
cd ../

git clone https://github.com/barrymcgee/jaas-dashboard
cd jaas-dashboard
git remote add upstream https://github.com/canonical-web-and-design/jaas-dashboard.git
cd ../

git clone https://github.com/barrymcgee/vanilla-framework
cd vanilla-framework
git remote add upstream https://github.com/canonical-web-and-design/vanilla-framework
cd ../

git clone https://github.com/barrymcgee/ubuntu.com
cd ubuntu.com
git remote add upstream https://github.com/canonical-web-and-design/ubuntu.com.git
cd ../

echo "Clone dotfiles and copy to root"
cd ~
git clone https://github.com/barrymcgee/dotfiles
mv dotfiles/* .
rm -rf dotfiles

echo "  › Unable to install these apps automatically: Paste, Magnet, Multipass, Luminar, Karibiner, Aurora"

echo "  › DONE!! 🚀🚀🚀"

#############################

set -e
