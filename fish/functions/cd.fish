# Defined in - @ line 2
function cd --description 'List after every directory change'
	builtin cd "$argv[1]"
    echo
    ls -A | grep -v ".DS_Store"
    echo
end
