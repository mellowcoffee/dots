export ZDOTDIR=$HOME/.config/zsh # you need to symlink this file from ~/.zshenv

### ENVIRONMENT ###
export EDITOR="nvim"
export VISUAL="nvim"

### PATH ###
typeset -U path
path=(
    "$HOME/.cargo/bin"
    "$HOME/.ghcup/bin"
    "$HOME/.config/emacs/bin"
    "$HOME/.local/bin"
    $path
)
