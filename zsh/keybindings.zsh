### KEYBINDINGS ###
autoload edit-command-line
zle -N edit-command-line

bindkey -v

bindkey "^?" backward-delete-char
bindkey "^H" backward-delete-char
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^u" kill-line
bindkey "^b" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^l" forward-word
bindkey "^[[1;5C" forward-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward
bindkey '^X^E' edit-command-line
