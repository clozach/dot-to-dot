# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.i1dz45/gpop.fish @ line 2
function gpop --description 'Apply a stash by name, popping it if -d/--delete included'
	set -l options 'd/delete'

	argparse -n gpop $options -- $argv

	if set -q _flag_delete
		git stash list | grep ": $argv" | tr -dc '0-9' | xargs git stash pop
	else
		git stash list | grep ": $argv" | tr -dc '0-9' | xargs git stash apply
	end

# Props to: Matsumoto Kazuya! https://stackoverflow.com/a/53929325/230615
end
