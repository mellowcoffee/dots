# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# history
HISTFILE=~/.bash_history
HISTSIZE=100000
HISTFILESIZE=200000
HISTCONTROL=ignoreboth:erasedups
HISTTIMEFORMAT='%F %T '
HISTIGNORE='ls:ll:cd:pwd:exit:clear:history'
shopt -s histappend cmdhist lithist
PROMPT_COMMAND='history -a; history -n' # shared history: flush + reload on every prompt

# shell options
shopt -s checkwinsize globstar nocaseglob extglob autocd cdspell dirspell
set -o noclobber

# prompt
# if [[ -n ${SSH_CONNECTION} ]]; then hc='1;33'; else hc='1;32'; fi
# PS1='\[\e[2;37m\]\A \[\e[0m\]\[\e['"$hc"'m\]\u@\h\[\e[0m\] \[\e[1;34m\]\w\[\e[0m\] \$ '
# PS1='[\u@\h \W]\$ '
# PS1='[\t \W]\$ '
# PS2='> '

prompt() {
    local d=${PWD/#$HOME/'~'}
    local IFS=/ n
    read -ra n <<< "$d"
    (( ${#n[@]} > 3 )) && d="${n[-3]}/${n[-2]}/${n[-1]}"
    PS1="[\u@\h ${d}]$ "
}
PROMPT_COMMAND=prompt

# colors
export CLICOLOR=1
export LS_COLORS='di=1;34:ln=1;36:so=1;35:pi=33:ex=1;32:bd=1;33:cd=1;33:su=37;41:sg=30;43:tw=30;42:ow=34;42'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip -color=auto'
export GREP_COLORS='mt=1;31'
export LESS='-R -F -X -i -M'
# man page colors
export LESS_TERMCAP_md=$'\e[1;36m' LESS_TERMCAP_me=$'\e[0m' \
       LESS_TERMCAP_us=$'\e[1;32m' LESS_TERMCAP_ue=$'\e[0m' \
       LESS_TERMCAP_so=$'\e[1;44;37m' LESS_TERMCAP_se=$'\e[0m'

# env
export EDITOR=nvim VISUAL=nvim PAGER=less

alias ll="ls -o \
--almost-all \
--group-directories-first \
--human-readable"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.ghcup/bin:$PATH"

# readline
bind 'set editing-mode emacs'
bind 'set bell-style none'
bind 'set completion-ignore-case on'
bind 'set completion-map-case on'
bind 'set show-all-if-ambiguous on'
bind 'set show-all-if-unmodified on'
bind 'set colored-stats on'
bind 'set colored-completion-prefix on'
bind 'set visible-stats on'
bind 'set mark-symlinked-directories on'
bind 'set menu-complete-display-prefix on'
bind 'set page-completions off'
bind 'set skip-completed-text on'
bind 'set enable-bracketed-paste on'
bind 'set revert-all-at-newline on'

bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind 'Control-r: reverse-search-history'
bind 'Control-s: forward-search-history'
bind 'Control-h: backward-word'
bind 'Control-l: forward-word'
bind '"\e[1;5D": backward-word'
bind '"\e[1;5C": forward-word'
bind 'Control-w: backward-kill-word'
bind '"\e\C-?": backward-kill-word'
bind '"\ed": kill-word'
bind 'Control-k: previous-history'
bind 'Control-j: next-history'
bind 'TAB: menu-complete'
bind '"\e[Z": menu-complete-backward'

stty -ixon
