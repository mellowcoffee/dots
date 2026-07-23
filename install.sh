#!/usr/bin/env bash
# install.sh
red='\033[1;31m'
green='\033[1;32m'
yellow='\033[1;33m'
blue='\033[1;34m'
nc='\033[0m'
log_info() {
    printf "${blue}info:${nc} %s\n" "$1"
}
log_warn() {
    printf "${yellow}warn:${nc} %s\n" "$1"
}
log_error() {
    printf "${red}error:${nc} %s\n" "$1"
}
log_success() {
    printf "${green}ok:${nc} %s\n" "$1"
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
    if [[ -e "$target" || -L "$target" ]]; then
        log_info "Backing up ${target}..."
        mv "$target" "${target}${backup_suffix}" || return 1
    fi
    return 0
}
make_link() {
    local source_path="$1"
    local target_path="$2"
    local label="$3"
    if [[ ! -e "$source_path" ]]; then
        log_error "Source '$label' does not exist in dotfiles."
        return 1
    fi
    if backup_config "$target_path"; then
        mkdir -p "$(dirname "$target_path")" || {
            log_error "Failed to create parent directory for $label. Aborting."
            return 1
        }
        log_info "Linking $label..."
        ln -s "$source_path" "$target_path" && log_success "$label installed."
    else
        log_error "Failed to backup existing config for $label. Aborting."
        return 1
    fi
}
link_config() {
    local source_path="$1"
    local name
    name=$(basename "$source_path")
    make_link "$source_path" "$config_dir/$name" "$name"
}
link_home() {
    local rel="$1"
    local name
    name=$(basename "$rel")
    make_link "$dots_dir/$rel" "$HOME/$name" "$name -> ~/$name"
}
link_to() {
    local rel_source="$1"
    local target="$2"
    make_link "$dots_dir/$rel_source" "$target" "$rel_source -> $target"
}
install_all() {
    log_info "Installing all dotfiles from $dots_dir..."
    for d in "$dots_dir"/*/; do
        [[ -d "$d" ]] || continue
        [[ "$d" != "$dots_dir/assets/" ]] || continue
        link_config "$(resolve_path "$d")"
    done
}
usage() {
    cat >&2 <<EOF
usage: $command [dotfile...]
       $command -a
       $command -f file...
       $command -l source target

Install dotfiles by symlinking them into the config dir.

  dotfile...        link top-level directories into $config_dir
  -a                install all top-level directories
  -f file...        link standalone files into \$HOME (e.g. .bashrc, .vimrc)
  -l source target  link source to an explicit target
                    (e.g. -l zsh/.zshenv \$HOME/.zshenv)
EOF
}
main() {
    if [[ $# -eq 0 ]]; then
        usage
        exit 1
    fi
    case "$1" in
        -a)
            install_all
            exit 0
            ;;
        -f)
            shift
            if [[ $# -lt 1 ]]; then
                log_error "-f requires at least one file."
                usage
                exit 1
            fi
            for arg in "$@"; do
                link_home "$arg"
            done
            exit 0
            ;;
        -l)
            shift
            if [[ $# -ne 2 ]]; then
                log_error "-l requires exactly a source and a target."
                usage
                exit 1
            fi
            link_to "$1" "$2"
            exit $?
            ;;
        -h | --help)
            usage
            exit 0
            ;;
    esac
    for arg in "$@"; do
        link_config "$dots_dir/$arg"
    done
}
main "$@"
