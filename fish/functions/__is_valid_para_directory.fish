function __is_valid_para_directory --description 'Used by `para`. Does what it says, the way you would expect.'
    set -l options 'h/help'
    argparse -n "Para Directory Validator" --min-args=1 --max-args=1 $options -- $argv
    or return

    set -l dir $argv[1]
    set -l contents (ls $dir)

    set -l p1 1-Projects
    set -l a2 2-Areas-of-Responsibility
    set -l r3 3-Resources
    set -l b4 4-Archives

    if contains $p1 $contents
        and contains $a2 $contents
        and contains $r3 $contents
        and contains $b4 $contents
        return 0
    else
        return 1
    end
end
