function save --description 'Quick git save'
    git commit -a -m "$argv[1]"
    git push
end
