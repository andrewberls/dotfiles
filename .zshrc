DISABLE_AUTO_UPDATE="true"
ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Disable autocorrect
unsetopt correct_all
unsetopt correct

# Set up history
#   - Don't share history between terminals
#   - Ignore duplicate lines
#   - Append to history, don't overwrite it
setopt no_share_history
unsetopt share_history
setopt hist_ignore_dups
setopt hist_ignore_space
setopt inc_append_history
HISTSIZE=1000
HISTFILESIZE=2000

export TERM=xterm-256color

# Set PATH
export PATH=/opt/homebrew/bin:/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH

# Ignore case and display colored output
export GREP_OPTIONS='-i --color=auto'

# STFU
setopt no_beep

# If numeric filesnames, sort numerically rather than lexicographically
setopt numericglobsort

# Don't exit on EOF, require exit or logout
setopt ignore_eof

# Allow clobbering (overwriting existing files)
setopt clobber

# Preferred editor for local and remote sessions
export EDITOR='vim'

# Set the prompt with the following format:
#   ~/Documents $
#   ~/code/someproject (master) $
function parse_git_branch {
  git branch 2> /dev/null | grep "*" | sed -e 's/* \(.*\)/ (\1)/g'
}
NORMAL=$'\033[0m'
function precmd() {
  export PROMPT="%{$FG[034]%}%~/%{$FG[207]%}%B$(parse_git_branch)%b%{$NORMAL%} $ "
}

# Load up autojump (if present)
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

[[ -f "$HOME/.sh_aliases" ]] && source "$HOME/.sh_aliases"
[[ -f "$HOME/.private_aliases" ]] && source "$HOME/.private_aliases"
