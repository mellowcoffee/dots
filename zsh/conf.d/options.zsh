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
