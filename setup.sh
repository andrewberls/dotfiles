# Set up dotfiles for a Vagrant user
# Note: this script WILL override any existing files in your home directory

dir=`pwd`

if [[ $dir = $HOME ]]; then
  echo "ERR: setup needs to be run from within the dotfiles directory, exiting ..."
  exit 1
fi

files=(
  ".vimrc"
  ".vim"
  ".ackrc"
  ".sh_aliases"
  ".bash_profile"
  ".bashrc"
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

chown -R vagrant:vagrant ./* ./.*

echo "Setup complete; reload your terminal to changes to take effect."
