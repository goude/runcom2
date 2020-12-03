function afs_stuff --on-variable PWD --description 'Do afs stuff'
  status --is-command-substitution; and return
  if test -e .afs_look
    cat .afs_look
  end
  if test -e todo.txt
    bat todo.txt
  end
end
