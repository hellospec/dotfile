# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux
# fi

export PATH="$HOME/.rbenv/bin:/Users/woot/.rbenv/shims:$PATH"
eval "$(rbenv init -)"
export PATH="/usr/local/opt/postgresql@10/bin:$PATH"

export CLICOLOR=1
export TERM=xterm-256color

export PATH="$HOME/.cargo/bin:$PATH"
