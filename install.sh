set -ex

brew update

# Text search
brew install ack

# `find` alternative
brew install fd

# Editor
brew install neovim

# Jump to frequently used directories
brew install autojump

# Dotfiles management
brew install stow

# oh-my-zsh
set +x
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
set -x

stow ack
stow --dotfiles git # Expand special dot-gitignore file to .gitignore
stow neovim
stow ruby
stow shell
stow scripts
stow vim
