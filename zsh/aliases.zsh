### ALIASES ###
alias lsa="ls -o \
--almost-all \
--group-directories-first \
--human-readable"
alias man="batman"
alias tp="trash-put"
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias n='nnn -d -e'

alias vim='nvim'
alias hx='helix'

alias clangs='clang -std=c23 -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Wextra -Wpedantic \
-Wconversion \
-Wsign-conversion \
-Wshadow \
-Wstrict-prototypes \
-Wswitch-enum \
-Wimplicit-fallthrough \
-Wformat=2 \
-Wundef'
alias clango='clangs -O3 -flto=thin -fno-semantic-interposition'
