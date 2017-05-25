function addpaths
	echo "Modifying PATH: $PATH"
        set -U fish_user_paths $fish_user_paths $argv
        echo "Updated PATH: $PATH"
end
