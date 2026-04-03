install:
# Install Brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Install Personal tools
brew install lazygit fzf fd neovim ripgrep stow tree-sitter-cli
# stow config
stow . --target=$HOME --restow --adopt
# Install Web tools
brew install node swiftformat
# Install xcodebuild.nvim dependency
brew install xcp xcode-build-server xcbeautify pipx rg jq coreutils
pipx install pymobiledevice3
#Install brew casks
brew install --cask claude claude-code colemak-dhk cursor gcloud-cli ghostty
