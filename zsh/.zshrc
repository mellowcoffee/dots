### FZF ###
source <(fzf --zsh)

### COMPLETION ###
zstyle ':completion:*' menu select # tab opens cmp menu
zstyle ':completion:*' special-dirs true # force . and .. to show in cmp menu
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} ma=0\;33 # colorize cmp menu
zstyle ':completion:*' file-list true # more detailed list
zstyle ':completion:*' squeeze-slashes false # explicit disable to allow /*/ expansion

### OPTIONS ###
setopt append_history inc_append_history share_history # better history
# on exit, history appends rather than overwrites; history is appended as soon as cmds executed; history shared across sessions
setopt auto_menu menu_complete # autocmp first menu match
setopt autocd # type a dir to cd
setopt auto_param_slash # when a dir is completed, add a / instead of a trailing space
setopt no_case_glob no_case_match # make cmp case insensitive
setopt globdots # include dotfiles
setopt extended_glob # match ~ # ^
setopt interactive_comments # allow comments in shell
unsetopt prompt_sp # don't autoclean blanklines
unsetopt BEEP
stty stop undef # disable accidental ctrl s

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
HISTCONTROL=ignoreboth # consecutive duplicates & commands starting with space are not saved

### KEYBINDINGS ###
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^u" kill-line
bindkey "^b" backward-word
bindkey "^[[1;5D" backward-word
bindkey "^l" forward-word
bindkey "^[[1;5C" forward-word
bindkey "^J" history-search-forward
bindkey "^K" history-search-backward

### ALIASES ###
alias mdv="~/scripts/preview_markdown.sh"
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

### PROMPT ###
NEWLINE=$'\n'
# PROMPT="${NEWLINE} %K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} %* %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k%F{#504945}%f " # warmer theme
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
echo -e "\x1b[38;5;137m\x1b[48;5;0m it's $(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme

### PATH ###
PATH="$HOME/.cargo/bin:$PATH"
PATH="$HOME/.ghcup/bin:$PATH"
PATH="$HOME/.config/emacs/bin:$PATH"
PATH="$HOME/.local/bin:$PATH"

### ENVIRONMENT ###
EDITOR="nvim"
VISUAL="nvim"

### PLUGINS ###
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### OCAML / OPAM ###
[[ ! -r "$HOME/.opam/opam-init/init.zsh" ]] || source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2> /dev/null

### YAZI ###
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}
