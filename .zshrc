source ~/.bash_profile
autoload -Uz compinit && compinit
#if [ -f ~/.git-completion.zsh ]; then
#    . ~/.git-completion.zsh
#fi

# export PATH="/usr/local/bin:$PATH"
export TERM=xterm-256color
alias gs='git status'
alias gb='git branch -v'
alias gc='git checkout'
