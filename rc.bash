#!/usr/bin/env bash
source $HOME/.homesick/repos/runcom2/rc.common

source $HOMESHICK_REPOS/homeshick/completions/homeshick-completion.bash
source $RUNCOM2_PATH/utils/bash_colors

source $RUNCOM2_PATH/rc.common-post

# Workarounds
source $RUNCOM2_PATH/utils/fix_alias_completion.bash

# Define prompt
#bpr="$RUNCOM2_ICON"
bpr="\[$IBlack\]\[$CReset\] "
export PS1=$bpr
unset bpr

# Deduplicate PATH
dedup_pathvar PATH

# fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash