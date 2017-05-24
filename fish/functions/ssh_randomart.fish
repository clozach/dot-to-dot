function ssh_randomart --description 'Prints the random art for the given ssh key'
	ssh-keygen -lv -f $argv[1]
end
