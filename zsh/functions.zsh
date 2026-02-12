### FUNCTIONS ###

### YAZI ###
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

### UTILITY ###
function mcd() {
    mkdir -p $1;
    cd $1
}

function package_picker() {
    fzf --multi \
        --preview 'pacman -Sii {1} 2> /dev/null || paru -Sii {1}' \
        --preview-window=down:55% \
}

function pack() {
    local packages=$(pacman -Slq | package_picker)
    [[ -z "$packages" ]] && return
    echo "Packages: $(echo "$packages" | sed ':a;N;$!ba;s/\n/, /g')"
    echo "$packages" | xargs -ro sudo pacman -S
}

function aur() {
    local packages=$(paru -Slq | package_picker)
    [[ -z "$packages" ]] && return
    echo "Packages: $(echo "$packages" | sed ':a;N;$!ba;s/\n/, /g')"
    echo "$packages" | xargs -ro paru -S
}

function dpack() {
    local packages=$(pacman -Qeq | package_picker)
    [[ -z "$packages" ]] && return
    echo "Removing packages: $(echo "$packages" | sed ':a;N;$!ba;s/\n/, /g')"
    echo "$packages" | xargs -ro sudo pacman -Rs
}
