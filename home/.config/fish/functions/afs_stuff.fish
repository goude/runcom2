function afs_stuff --on-variable PWD --description 'Do afs stuff'
    status --is-command-substitution; and return

    if test -e notes.md
        # bat --language="md" --style="plain" notes.md
        bat notes.md
    end

    if test -e todo.txt
        bat todo.txt
    end

    if test -e notes.md
        echo
        lzt adage
    end
end
