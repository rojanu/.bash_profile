#!/usr/bin/env bash
# 
# Bootstrap script for setting up a new OSX machine
# 
# To download the script
# curl --remote-name https://raw.githubusercontent.com/rojanu/.bash_profile/master/.bin/osx_bootstrap.sh
#
# This should be idempotent so it can be run multiple times.
#
# Some apps don't have a cask and so still need to be installed by hand. These
# include:
#
# - Twitter (app store)
# - Postgres.app (http://postgresapp.com/)
#
# Notes:
#
# - If installing full Xcode, it's better to install that first from the app
#   store before running the bootstrap script. Otherwise, Homebrew can't access
#   the Xcode libraries as the agreement hasn't been accepted yet.
#
# Reading:
#
# - https://gist.github.com/MatthewMueller/e22d9840f9ea2fee4716

echo "Starting bootstrapping"

# Check for Homebrew, install if we don't have it
if test ! $(which brew); then
    echo "Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew recipes
brew update

# Install GNU core utilities (those that come with OS X are outdated)
brew install coreutils
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnutls
brew install grep --with-default-names

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, g-prefixed
brew install findutils  --with-default-names

# Install Bash 4
brew install bash

echo "Installing brew cask..."
brew tap caskroom/cask

echo "Installing packages..."
brew install git
brew install git-crypt
brew install mysql@5.7
brew install nvm
brew install wget

echo "Tapping cask repos"
brew tap AdoptOpenJDK/openjdk

echo "Installing cask apps..."
brew cask install adoptopenjdk8
brew cask install visual-studio-code
brew cask install docker-toolbox
brew cask install iterm2
brew cask install slack
brew cask install intellij-idea
brew cask install mysqlworkbench

echo "Installing apps with dependencies on cask apps"
brew install sbt
brew install scala

echo "Cleaning up..."
brew cleanup

NODE_VERSION="6.10.0"

echo "Installing node version $NODE_VERSION"
if [[ -z $(grep "NVM_DIR" ~/.bash_profile) ]]; then
  mkdir ~/.nvm
  cat >> ~/.bash_profile <<EOL
export NVM_DIR="\$HOME/.nvm"
source \$(brew --prefix nvm)/nvm.sh
EOL
fi
source $(brew --prefix nvm)/nvm.sh
nvm install $NODE_VERSION
nvm alias default $NODE_VERSION

echo "Configuring OSX..."

# Set fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 0

# Require password as soon as screensaver or sleep mode starts
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Show filename extensions by default
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Enable tap-to-click
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

WORKSPACE="Workspace"
echo "Creating folder structure..."
[[ ! -d $WORKSPACE ]] && mkdir $WORKSPACE

echo "Bootstrapping complete"
