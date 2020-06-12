#!/usr/bin/env bash
source $HOME/.homesick/repos/runcom2/rc.common

#GIT_PS1_SHOWDIRTYSTATE=1
#GIT_PS1_SHOWSTASHSTATE=1
#GIT_PS1_SHOWUNTRACKEDFILES=1
#GIT_PS1_SHOWCOLORHINTS=1

# Bash autocompletion
#source $rcfiles/utils/git-completion.bash
#source $rcfiles/utils/git-prompt.sh
source $HOMESHICK_REPOS/homeshick/completions/homeshick-completion.bash

source $rcfiles/utils/bash_colors

source $rcfiles/rc.common-post

# Workarounds
source $HOME/.homesick/repos/runcom/utils/fix_alias_completion.bash

# Define prompt
#bpr="$RUNCOM2_ICON"
bpr="\[$IBlack\]\[$CReset\] "
export PS1=$bpr
unset bpr

# Deduplicate PATH
dedup_pathvar PATH

# fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash