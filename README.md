These are the dotfiles I use to configure my development environment. Included are shell aliases/functions, neovim configuration + bundles, useful scripts, and more.

## Quick Start
A script is included to automatically symlink configuration files, which are managed with [GNU Stow](https://www.gnu.org/software/stow/). From your home directory, run:

```
git clone https://github.com/andrewberls/dotfiles.git
cd dotfiles && bash install.sh
```

You will need to reload your shell after running the script.

Note: the setup script creates symlinks into the cloned dotfiles repo - don't delete it afterwards!
