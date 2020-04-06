# Defined in - @ line 2
function cd --description 'List after every directory change'
    builtin cd "$argv[1]"

    set -l dirname (basename $argv[1])
    set -l l (string length $dirname)
    set -l dnl (math $l + 4) # Directory Name Length

    echo (repstr - $dnl)
    echo "  "$dirname
    echo (repstr - $dnl)
    echo
    ls -Ap | grep -v ".DS_Store" | column
    echo

    # Note: ls -A lists dot files, and -p identifies directories with a trailing `/`
end
