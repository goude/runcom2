function afs_stuff --on-variable PWD --description 'Do afs stuff'
  status --is-command-substitution; and return
  if test -e .afs_look
    bat --language="md" --style="plain" .afs_look
  end
end
