# Defined in /Users/c/.config/fish/functions/dora.fish @ line 2
function dora --description 'A Command Line Interface in support of my D.O.R.A. system.'
    set -l options 'h/help' 'g/go'
    argparse -n dora $options -- $argv
    or return

    # (Fish shell screws with comments if they're anywhere near the
    #  `function` line. Pretend the following lines are at the top
    #   of this file. 🙄)
    #
    # D.O.R.A. stands for
    #
    #   - Due: anything with a defined end state. What Tiago calls Projects
    #   - Ongoing: things of indeterminate length. What Tiago calls Areas
    #   - Research: spikes, tutorials, etc. What Tiago calls Resources
    #   - Archives: stuff I may refer to again someday…maybe
    #
    # See https://praxis.fortelabs.co/the-p-a-r-a-method-a-universal-system-for-organizing-digital-information

    set -l p1 1-Due
    set -l a2 2-Ongoing
    set -l r3 3-Research
    set -l b4 4-Archives

    set -l dest $argv[1]
    set -l paths $argv[2..-1]
    set -l pathCount (count $paths)

    set -l c (count $argv)

    if set -q _flag_help || [ $c = 0 ]
        echo
        echo USAGE: dora [COMMAND] [OPTIONS] [PATH...]
        echo
        echo (set_color -o blue)--------
        echo COMMANDS
        echo --------(set_color normal)
        echo
        echo • (set_color red)"init" (set_color brblack)"-> Example: `dora init`"(set_color normal)
        echo
        echo Creates the 4 D.O.R.A. folders in the current directory and sets DORA_ROOT to that directory.
        echo
        echo • (set_color red)"d | o | r | a"
        echo
        echo (set_color brblack)"Example 1: `dora r`"(set_color normal)
        echo "   Changes the current directory to the `3-Research` directory"
        echo
        echo (set_color brblack)"Example 2: `dora d foo`"(set_color normal)
        echo "   Moves `foo` to the 1-Due directory"
        echo
        echo • (set_color red)"l" (set_color brblack)"-> Example: dora l"(set_color normal)
        echo
        echo "   List all contents of the DOR directories. (Archives tend to become crowded, and are thus left out of the basic list command)"
        echo
        echo • (set_color red)"ll" (set_color brblack)"-> Example: dora ll"(set_color normal)
        echo
        echo "List all contents of (set_color -o)all 4(set_color normal) DORA directories."
        echo
        echo • (set_color red)"ll" (set_color brblack)"-> Example: dora ll"(set_color normal)
        echo
        echo "   List all contents of (set_color -o)all 4(set_color normal) DORA directories."
        echo
        echo • (set_color red)"root" (set_color brblack)"-> Example: `dora root`"(set_color normal)
        echo
        echo "   Sets the current directory as DORA_ROOT. Since `init` also does this, `dora root` is mainly just used for testing."
        echo
        echo (set_color -o blue)-------
        echo OPTIONS
        echo -------(set_color normal)
        echo
        echo • (set_color red)"-h/help" (set_color brblack)"-> Example: `dora -h`"(set_color normal)
        echo
        echo "   Display this help text"
        echo
        echo • (set_color red)"-g/go" (set_color brblack)"-> Example: `dora d --go foo`"(set_color normal)
        echo
        echo "   When used in conjunction with one or more PATHs, finishes by performing a `cd` into the target DORA directory. This example moves `foo` into 1-Due, then \"follows\" the moved item by changing the current directory to 1-Due."
        echo
        echo


        return 0
    end

    if test "$dest" = "root"
        # Usually this is just handled by `init`, but you can use `dora root` to swap between DORA dirs if you have the need…which I only do because of testing this CLI.
        set --universal DORA_ROOT $PWD
        return 0
    end

    if test "$dest" = "init"
        mkdir 1-Due
        mkdir 2-Ongoing
        mkdir 3-Research
        mkdir 4-Archives
        set --universal DORA_ROOT $PWD
        echo "You're all set to use D.O.R.A! See output of `ls` 👇."
        ls
        return 0
    end

    # Make sure we're in a valid DORA directory before actually responding to commands
    if set -q DORA_ROOT
        set base $DORA_ROOT
    else if __is_valid_dora_directory $PWD
        set base $PWD
    else if __is_valid_dora_directory (dirname $PWD)
        set base ..
    else
        set -l this_dir (basename $PWD)

        echo "Invalid D.O.R.A. context. Possible solutions:
        
        1. Run `dora init` to create the D.O.R.A. folders here in $this_dir.
        2. `cd` into a D.O.R.A. directory and (optionally) run `dora root`."
        return 0
    end

    function pathForFlag --argument-names destflag baseurl
        set -l flags d o r a
        set -l dirs 1-Due 2-Ongoing 3-Research 4-Archives

        if set -l index (contains -i -- $destflag $flags)
            # 👆 `set` won't modify $status, so this succeeds if `contains` succeeds
            echo $baseurl/$dirs[$index]
        else
            return 1
        end
    end

    function emojiForFlag --argument-names destflag
        set -l flags d o r a
        set -l emoji 🗓 👨‍👩‍👧 ⛰ 🌊

        if set -l index (contains -i -- $destflag $flags)
            # 👆 `set` won't modify $status, so this succeeds if `contains` succeeds
            echo $emoji[$index]
        else
            return 1
        end
    end

    function header --argument-names destflag baseurl
        set -l emoji (emojiForFlag $destflag)
        set -l dirname (basename (pathForFlag $destflag $baseurl))
        set -l l (string length $dirname)
        set -l dnl (math $l + 8) # Directory Name Length

        echo (repstr - $dnl)
        echo "  "$emoji: $dirname
        echo (repstr - $dnl)
    end

    if test "$dest" = "l"
        echo
        for f in d o r
            header $f $base
            # -G: Colorizes output, -p: post-fixes dirs with `/`
            ls -Gpc (pathForFlag $f $base)
            echo
        end
        echo
        return 0
    end

    if test "$dest" = "ll"
        echo
        for f in d o r a
            header $f $base
            # -G: Colorizes output, -p: post-fixes dirs with `/`
            ls -Gpc (pathForFlag $f $base)
            echo
        end
        echo
        return 0
    end

    set -l target (pathForFlag $dest $base)

    # Handle `dora <flag> .`, which moves the dir at $PWD to the target D.O.R.A. dir.
    if test "$paths" = "."
        set paths $PWD

        # In order to avoid a jarring context shift,
        # land us in the directory we just moved.
        set final_pwd (basename $PWD)
    else
        set final_pwd $target
    end

    if test $pathCount -gt 0
        # Got something like `dora b somefile.txt somedir`, so move `somefile.txt` and `somedir`.
        echo Moving $paths 👉 (basename $target)
        mv $paths $target
    end

    if set -q _flag_go || [ $c = 1 ]
        # Without the -g flag, moving projects DOES NOT trigger
        # a directory change. E.g.,
        #     dora d
        #     dora o -g some_project
        cd $final_pwd
    end

    return 0
end
