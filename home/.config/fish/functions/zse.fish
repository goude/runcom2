function zse
    zktools ls | fzf --header 'Enter to edit file' --with-nth='1,3..' --tac --ansi --preview 'bat --style=grid -f {-1}' --bind 'enter:execute(nvim {-1})'
end
