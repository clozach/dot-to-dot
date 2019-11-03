# See https://praxis.fortelabs.co/the-p-a-r-a-method-a-universal-system-for-organizing-digital-information

function para --description 'A Command Line Interface in support of Tiago Forte’s P.A.R.A. system.'

    # Note: Though the acronym's technically 'para', I substitute 'b' for
    # the 2nd 'a' in order to be able to enter, for instance, the command;
    # 'para b'. So type one of `p a r b`, but think, `p a r a`.

    set -l options 'h/help'
    argparse -n para --min-args=1 $options -- $argv
    or return

    set -l p1 1-Projects
    set -l a2 2-Areas-of-Responsibility
    set -l r3 3-Resources
    set -l b4 4-Archives

    set -l dest $argv[1]
    set -l paths $argv[2..-1]
    set -l pathCount (count $paths)

    if set -q _flag_help
        echo "Usage: para init

        Creates the 4 P.A.R.A. folders in the current directory and sets PARA_ROOT to that directory.

        "
        echo "Usage: para root <path-to-para-root>. Mainly used for testing."
        echo "Usage: para p|a|r|b [<path> ...<path>]

        Performs a `cd` to the appropriate 'parb' destination, unless paths are provided, in which case these are moved to the target destination before changing into the target P.A.R.A. directory."
        return 0
    end

    if test "$dest" = "root"
        # Usually this is just handled by `init`, but you can use `para root` to swap between PARA dirs if you have the need…which I only do because of testing this CLI.
        set --universal PARA_ROOT $PWD
        return 0
    end

    if test "$dest" = "init"
        mkdir 1-Projects
        mkdir 2-Areas-of-Responsibility
        mkdir 3-Resources
        mkdir 4-Archives
        set --universal PARA_ROOT $PWD
        echo "You're all set to use P.A.R.A! See output of `ls` 👇."
        ls
        return 0
    end

    # Make sure we're in a valid PARA directory before actually responding to commands
    if set -q PARA_ROOT
        set base $PARA_ROOT
    else if __is_valid_para_directory $PWD
        set base $PWD
    else if __is_valid_para_directory (dirname $PWD)
        set base ..
    else
        set -l this_dir (basename $PWD)

        echo "Invalid P.A.R.A. context. Possible solutions:
        
        1. Run `para init` to create the P.A.R.A. folders here in $this_dir.
        2. `cd` into a P.A.R.A. directory and (optionally) run `para root`."
        return 0
    end

    function pathForFlag --argument-names destflag baseurl
        set -l flags p a r b
        set -l dirs 1-Projects 2-Areas-of-Responsibility 3-Resources 4-Archives

        if set -l index (contains -i -- $destflag $flags)
            # 👆 `set` won't modify $status, so this succeeds if `contains` succeeds
            echo $baseurl/$dirs[$index]
        else
            return 1
        end
    end

    function emojiForFlag --argument-names destflag
        set -l flags p a r b
        set -l emoji 🗓 👨‍👩‍👧 ⛰ 🌊

        if set -l index (contains -i -- $destflag $flags)
            # 👆 `set` won't modify $status, so this succeeds if `contains` succeeds
            echo $emoji[$index]
        else
            return 1
        end
    end

    if test "$dest" = "l"
        echo
        for f in p a r b
            echo "-----------------------------"
            echo (emojiForFlag $f): (basename (pathForFlag $f $base))
            echo "-----------------------------"
            # -G: Colorizes output, -p: post-fixes dirs with `/`
            ls -Gp (pathForFlag $f $base)
            echo
        end
        echo
        return 0
    end

    set -l target (pathForFlag $dest $base)

    # Handle `para <flag> .`, which moves the dir at $PWD to the target P.A.R.A. dir.
    if test "$paths" = "."
        set paths $PWD

        # In order to avoid a jarring context shift,
        # land us in the directory we just moved.
        set final_pwd (basename $PWD)
    else
        set final_pwd $target
    end

    if test $pathCount -gt 0
        # Got something like `para b somefile.txt somedir`, so move `somefile.txt` and `somedir`.
        echo Moving $paths 👉 (basename $target)
        mv $paths $target
    end
    echo Your final destination: (basename $final_pwd)
    cd $final_pwd
    return 0
end
