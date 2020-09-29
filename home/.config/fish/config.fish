if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    #curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    curl https://raw.githubusercontent.com/jorgebucaran/fisher/main/fisher.fish --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

export HOMESHICK_REPOS=$HOME/.homesick/repos
source $HOMESHICK_REPOS/runcom2/localenv

if status --is-interactive
    pyenv init - | source
    pyenv virtualenv-init - | source

    fish_vi_key_bindings
    theme_gruvbox dark

    starship init fish | source

    source $HOMESHICK_REPOS/homeshick/homeshick.fish
    source $HOMESHICK_REPOS/homeshick/completions/homeshick.fish

    source $RUNCOM2_PATH/aliases
    source $RUNCOM2_PATH/aliases-linux
end
set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
