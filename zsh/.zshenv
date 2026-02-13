export ZDOTDIR=$HOME/.config/zsh # you need to symlink this file from ~/.zshenv

### ENVIRONMENT ###
export EDITOR=nvim
export VISUAL=nvim
export TERMINAL=foot

### PATH ###
typeset -U path
path=(
    "$HOME/scripts"
    "$HOME/.cargo/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/.local/bin"
    $path
)

### XDG BASE DIRECTORY SPECIFICATION ###
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
