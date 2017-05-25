function cd --description 'List after every directory change'
	builtin cd "$argv[1]"; echo; ls -a; echo;
end
