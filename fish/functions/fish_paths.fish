function fish_paths
	echo $PATH | string split ' ' | column
end
