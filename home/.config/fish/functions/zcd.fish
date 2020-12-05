function zcd
    cd (zktools list | fzf --ansi | awk -F" " '{print $NF}') && zls && nvim data.md
end
