function cdl --description 'Long List after directory change'
	builtin cd "$argv[1]"; echo; ls -al; echo;
end
