#!/usr/bin/env bash
# install.sh

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
nc='\033[0m'

log_info() {
    printf "${blue}[INFO]${nc}  %s\n" "$1"
}

log_warn() {
    printf "${yellow}[WARN]${nc}  %s\n" "$1"
}

log_error() {
    printf "${red}[ERROR]${nc} %s\n" "$1"
}

log_success() {
    printf "${green}[OK]${nc}    %s\n" "$1"
}

command=$(basename "$0")
config_dir=$(realpath -- "${XDG_CONFIG_HOME:-$HOME/.config}")
dots_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)"
backup_suffix="_$(date +%Y%m%d_%H%M%S)"

resolve_path() {
    local target="$1"
    if [[ -d "$target" ]]; then
        cd "$target" && pwd
    else
        echo "$PWD/$target"
    fi
}

backup_config() {
    local target="$1"
    if [[ -e "$target" ]]; then
        log_info "Backing up ${target}..."
        mv "$target" "${target}${backup_suffix}" || return 1
    fi
    return 0
}

link_config() {
    local source_path="$1"
    local dir_name
    dir_name=$(basename "$source_path")
    local target_path="$config_dir/$dir_name"

    if [[ ! -d "$source_path" ]]; then
        log_error "Source directory '$dir_name' does not exist in dotfiles."
        return 1
    fi

    if backup_config "$target_path"; then
        log_info "Linking $dir_name..."
        ln -s "$source_path" "$target_path" && log_success "$dir_name installed."
    else
        log_error "Failed to backup existing config for $dir_name. Aborting."
        return 1
    fi
}

install_all() {
    log_info "Installing all dotfiles from $dots_dir..."
    for d in "$dots_dir"/*/; do
        [[ -d "$d" ]] || continue
        [[ "$d" != "$dots_dir/assets/" ]] || continue
        link_config "$(resolve_path "$d")"
    done
}

main() {
    if [[ $# -eq 0 ]] ; then
        >&2 echo "$command: install dotfiles"
        >&2 echo "usage: $command [DOTFILE(S)]"
        >&2 echo "       $command [-a INSTALL ALL]"
        exit 1
    fi

    if [[ "$1" = "-a" ]] ; then
        install_all
        exit 0
    fi

    for arg in "$@" ; do
        link_config "$dots_dir/$arg"
    done
}

main "$@"
