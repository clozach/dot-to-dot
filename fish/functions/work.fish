# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.qADUhN/work.fish @ line 2
function work --description 'Quick launch of coding projects'
	if set -q argv[1]
		set loc $argv[1]
	else
		set loc .
	end

	code $loc
	stree $loc

	set -l start_script $loc/work.eqg

	if [ -e $start_script ]
		echo Launching $start_script
		$start_script
	end

# The goal of this script is to strip away the inertia of getting back into an old project by making it easy to dive right back in.
#
# The work.eqg file is just a shell script that this `work` function can reference if there's a server to start, or any other prep to get back into the swing of things.
end
