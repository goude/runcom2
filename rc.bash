#!/usr/bin/env bash

if [[ -d $HOME/.pyenv/bin ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  #export PATH="$HOME/.pyenv/bin:$PATH"
  #eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

source $HOME/.homesick/repos/runcom2/rc.common

source $HOMESHICK_REPOS/homeshick/completions/homeshick-completion.bash
source $RUNCOM2_PATH/utils/bash_colors

source $RUNCOM2_PATH/rc.common-post

# Workarounds
source $RUNCOM2_PATH/utils/fix_alias_completion.bash

# Define prompt
bpr="$RUNCOM2_ICON "
bpr+="\[$IRed\]\u\[$CReset\]"
bpr+="\[$IBlack\]@\[$CReset\]"
bpr+="\[$IGreen\]\h\[$CReset\]"
bpr+=" \[$IBlack\]\[$CReset\] "
export PS1=$bpr
unset bpr

if command_exists starship; then
  eval "$(starship init bash)"
fi

# Deduplicate PATH
dedup_pathvar PATH

# fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash