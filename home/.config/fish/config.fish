if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

theme_gruvbox dark soft

export HOMESHICK_REPOS=$HOME/.homesick/repos
source $HOMESHICK_REPOS/runcom2/localenv

source $HOMESHICK_REPOS/homeshick/homeshick.fish
source $HOMESHICK_REPOS/homeshick/completions/homeshick.fish

source $RUNCOM2_PATH/aliases
