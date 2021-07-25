function zse
    zktools list | fzf --header 'read the snelling man fzf to extend this' --ansi --preview 'bat --style=grid -f {-1}/data.md'
end
