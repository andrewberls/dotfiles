

These are the dotfiles I use to configure my development environment. Included are bash aliases/functions, vim configuration + bundles, useful scripts, and more!

## Quick Start
A script is included to automatically symlink configuration files for vim and bash. From your home directory, run:

```
git clone https://github.com/andrewberls/dotfiles.git
cd dotfiles && bash setup.sh
```

You will need to reload your shell after running the script - you can either restart your session or run
`. ~/.bashrc`.

Note: the setup script creates symlinks into the dotfiles repo you cloned - don't delete it when you're done!
