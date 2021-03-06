# Note: this script WILL override any existing files in your home directory

dir=`pwd`

if [[ $dir = $HOME ]]; then
  echo "ERR: setup needs to be run from within the dotfiles directory, exiting ..."
  exit 1
fi

# Install zsh and oh-my-zsh
apt-get install -y zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /bin/zsh vagrant
zsh

files=(
  ".vimrc"
  ".vim"
  ".ackrc"
  ".sh_aliases"
  ".zsh_profile"
  ".zshrc"
  ".git-completion.sh"
  ".git_aliases"
  ".inputrc"
  ".irbrc"
  ".profile"
)


for file in "${files[@]}"
do
  name=`basename $file`
  ln -sf "$dir/$file" "$HOME/$name"
done

ln -sf "$dir/bin" "$HOME/bin"
chmod a+x $HOME/bin/*

echo "Setup complete; reload your terminal to changes to take effect."
