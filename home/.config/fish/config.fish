export HOMESHICK_REPOS=$HOME/.homesick/repos
source $HOMESHICK_REPOS/runcom2/localenv

if status --is-interactive
    pyenv init - | source
    pyenv virtualenv-init - | source

    fish_vi_key_bindings
    theme_gruvbox dark medium

    starship init fish | source

    source $HOMESHICK_REPOS/homeshick/homeshick.fish
    source $HOMESHICK_REPOS/homeshick/completions/homeshick.fish

    source $RUNCOM2_PATH/aliases
    source $RUNCOM2_PATH/aliases-linux

    afs_stuff
    load_em
end

set -g fish_user_paths "/usr/local/opt/openjdk/bin" $fish_user_paths
