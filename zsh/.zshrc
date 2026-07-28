### SETUP ###
source $ZDOTDIR/.zshenv
for file in $ZDOTDIR/conf.d/*.zsh; do
    source "$file"
done

source "$ZDOTDIR/aliases.zsh"
source "$ZDOTDIR/functions.zsh"
source "$ZDOTDIR/keybindings.zsh"

### PROMPT & WELCOME ###
NEWLINE=$'\n'
# PROMPT="${NEWLINE} %K{#2E3440}%F{#E5E9F0}$(date +%_I:%M%P) %K{#3b4252}%F{#ECEFF4} %n %K{#4c566a} %~ %f%k ❯ " # nord theme
# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} $0 %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k ❯ " # warmer theme
 PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} %* %K{#3c3836}%F{#d5c4a1} %3~ %f%k ❯ "
# PROMPT="${NEWLINE}%K{#32302f}%F{#d5c4a1} %* %K{#3c3836}%F{#d5c4a1} %n %K{#504945} %~ %f%k%F{#504945}%f "
# PROMPT="${NEWLINE}%K{$COL0}%F{$COL1}$(date +%_I:%M%P) %K{$COL0}%F{$COL2} %n %K{$COL3} %~ %f%k ❯ " # pywal colors, from postrun script

# echo -e "${NEWLINE}\033[48;2;46;52;64;38;2;216;222;233m $0 \033[0m\033[48;2;59;66;82;38;2;216;222;233m $(uptime -p | cut -c 4-) \033[0m\033[48;2;76;86;106;38;2;216;222;233m $(uname -r) \033[0m" # nord theme
# echo -e "\x1b[38;5;137m\x1b[48;5;0m it's $(date +%_I:%M%P) \x1b[38;5;180m\x1b[48;5;0m $(uptime -p | cut -c 4-) \x1b[38;5;223m\x1b[48;5;0m $(uname -r) \033[0m" # warmer theme

zmodload -F zsh/datetime b:strftime
fetch() {
  local k=${XDG_RUNTIME_DIR:-/tmp}/.cpu now cpu=-- up
  local -i u n s i o r f x t d mt ma pt pd
  read -r up _ < /proc/uptime
  read -r _ u n s i o r f x _ < /proc/stat
  { read -r _ mt _; read -r _; read -r _ ma _ } < /proc/meminfo
  (( t = u+n+s+i+o+r+f+x, d = i+o, up = ${up%.*} ))
  [[ -r $k ]] && read -r pt pd < $k &&
    (( t > pt )) && printf -v cpu '%.0f%%' $(( 100.*(t-pt-d+pd)/(t-pt) ))
  print -r -- "$t $d" > $k
  strftime -s now '%a %Y-%m-%d %_I:%M%P' $EPOCHSECONDS
  printf '\e[48;5;0m\e[38;5;137m \U000F0954  %s   \e[38;5;180m\U000F0152  %dd %02dh %02dm   \e[38;5;216m\U000F061A  %s   \e[38;5;223m\U000F035B  %.1f/%.1fG \e[0m\n' \
    $now $((up/86400)) $((up%86400/3600)) $((up%3600/60)) $cpu \
    $(( (mt-ma)/1048576. )) $(( mt/1048576. ))
}
fetch
