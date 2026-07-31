### ALIASES ###
alias ll="ls -o --almost-all --group-directories-first --human-readable"
alias tp="trash-put"
alias ls="ls --color=auto"
alias grep="grep --color=auto"
alias n="nnn -d -e"

alias vim="nvim"
alias hx="helix"

have() { command -v "$1" >/dev/null 2>&1; }

if have eza; then
    alias ls="eza -l --icons --group-directories-first --git"
    alias ll="eza -la --icons --group-directories-first --git"
fi

have bat    && alias cat="bat --style=plain --paging=never"
have procs  && alias ps="procs"
have dust   && alias du="dust"
have duf    && alias df="duf"
have batman && alias man="batman"

if have grc; then
    for c in ping dig mount netstat; do
        have "$c" && alias "$c"="grc $c"
    done
fi

alias clangs="clang -std=c23 -fsanitize=address,undefined -fno-omit-frame-pointer -Wall -Wextra -Wpedantic \
-Wconversion \
-Wsign-conversion \
-Wshadow \
-Wstrict-prototypes \
-Wswitch-enum \
-Wimplicit-fallthrough \
-Wformat=2 \
-Wundef"
alias clango="clangs -O3 -flto=thin -fno-semantic-interposition"
