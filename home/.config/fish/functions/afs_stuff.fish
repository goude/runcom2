function afs_stuff --on-variable PWD --description 'Do afs stuff'
  status --is-command-substitution; and return
  if test -e notes.md
    # bat --language="md" --style="plain" notes.md
    batcat notes.md
  end
  if test -e todo.txt
    batcat todo.txt
  end
end
