export EDITOR="vim"

bindkey -v
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^E" edit-command-line

getPrompt() {
  P='['
  P+='%{$fg[$NCOLOR]%}%B%n'

  if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
    P+='@%{$fg[yellow]%}%m%{$reset_color%}'
  fi

  P+='%b%{$reset_color%}'
  P+=':'
  P+='%{$fg[red]%}%30<...<%~%<<%{$reset_color%}'
  P+=']'
  P+='%(?.%{$fg[white]%}.%{$fg[red]%})%(!.#.$)%{$reset_color%}'
  P+=' '
  echo "$P"
}

export PROMPT="$(getPrompt)"

function zle-line-init zle-keymap-select {
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select
