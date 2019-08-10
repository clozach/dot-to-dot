function para --description 'A Command Line Interface in support of Tiago Forte’s P.A.R.A. system. https://praxis.fortelabs.co/the-p-a-r-a-method-a-universal-system-for-organizing-digital-information'
    set -l options 'h/help'
    argparse -n para --min-args=1 $options -- $argv
    or return

    set -l p1 1-Projects
    set -l a2 2-Areas-of-Responsibility
    set -l r3 3-Resources
    set -l b4 4-Archives

    if __is_valid_para_directory $PWD
        set base $PWD
    else if __is_valid_para_directory (dirname $PWD)
        set base ..
    else
        set -l this_dir (basename $PWD)

        echo "Invalid P.A.R.A. context. Possible solutions:
        
        1. Run `para init` to create the P.A.R.A. folders here in $this_dir.
        2. `cd` into a P.A.R.A. directory."
        return 0
    end

    set -l dest $argv[1]
    set -l paths $argv[2..-1]
    set -l pathCount (count $paths)

    if set -q _flag_help
        echo "Usage: para init

        Creates the 4 P.A.R.A. folders in the current directory.

        "
        echo "Usage: para p|a|r|b [<path> ...<path>]

        Performs a `cd` to the appropriate 'parb' destination, unless paths are provided, in which case these are moved to the target destination and the working directory remains unchanged."
        return 0
    end

    if test "$dest" = "init"
      mkdir 1-Projects
      mkdir 2-Areas-of-Responsibility
      mkdir 3-Resources
      mkdir 4-Archives
      echo "You're all set to use P.A.R.A! See output of `ls` 👇."
      ls
    end

    if test $pathCount -gt 0
        if test "$dest" = "p"
            mv $paths $base/1-Projects/
            return 0
        end

        if test "$dest" = "a"
            mv $paths $base/2-Areas-of-Responsibility/
            return 0
        end

        if test "$dest" = "r"
            mv $paths $base/3-Resources/
            return 0
        end

        if test "$dest" = "b"
            mv $paths $base/4-Archives/
            return 0
        end
    else
        if test "$dest" = "p"
            cd $base/1-Projects/
            return 0
        end

        if test "$dest" = "a"
            cd $base/2-Areas-of-Responsibility/
            return 0
        end

        if test "$dest" = "r"
            cd $base/3-Resources/
            return 0
        end

        if test "$dest" = "b"
            cd $base/4-Archives/
            return 0
        end
    end
end