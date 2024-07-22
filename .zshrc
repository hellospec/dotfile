export EDITOR=vi
export PATH="/usr/local/bin:$PATH"
export TERM=xterm-256color
export CLICOLOR=1

bindkey '^R' history-incremental-search-backward

# shell prompt
PS1="%F{153}%2~ %F{104}$ %F{255}"

# history size
HISTSIZE=5000
HISTFILESIZE=10000
HISTFILE=~/.zsh_history

alias gs='git status'
alias gb='git branch -v'
alias gc='git checkout'
alias gd='git diff .'
alias vimrc='vim ~/.vimrc'
alias xx='exit'
alias cls='clear'

if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden'
fi

# zsh auto autocomplete
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)
