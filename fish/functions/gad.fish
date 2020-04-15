# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.WrrOvH/gad.fish @ line 2
function gad --description 'git add + status'
	if not set -q argv[1]
git add .
else
	git add $argv;
end
git status
end
