# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.qADUhN/work.fish @ line 2
function work --description 'Quick launch of coding projects'

    # Set local `options` with a default of h/help to support -h and --help
    set -l options 'h/help' 'i/init' 'c/chaos'

    # Parse incoming args into `options`
    # E.g., `argparse -n myfunc $options -- $argv
    #   -> If parsing fails, exit
    argparse -n work $options -- $argv
    or return

    # Print help if requested
    #   -q == "query", i.e., check for this value
    #   _flag_ is a special prefix. Below tests for either -h or --help
    if set -q _flag_help
        echo "The `work` function helps me focus as I switch context from one
project to another. It does this with two basic strategies:

    1. Quitting (almost) all open applications and closing Chrome browser tabs
    2. Running a file called `work.eqg`, if one can be found in the current
       working directory (default), or, if provided, in a directory given as
       an argument.
    
There's also an `--init` option to make it trivial to create a new, `work.eqg`
script in the current working directory.

Example workflow:
    
    cd ~/projects/newproj
    work --init   # Creates and opens the `work.eqg` file so you can add
                  # your startup instrutions. Currently idiosyncratic: opens
                  # in VS Code.
    work          # Quits open applications, clears browser tabs, and
                  # runs the `work.eqg` script.
    work --chaos  # In order to train me to focus on one thing at a time, `work` uses
                  # my QuitAll.app Automator workflow to create a clean
                  # work space. The `--chaos` flag skips this step.
"

        return 0
    end

    if set -q argv[1]
        set loc $argv[1]
    else
        set loc .
    end

    set -l start_script $loc/work.eqg

    if set -q _flag_init
        if [ ! -e $start_script ]
            echo "#!/usr/local/bin/fish" >$start_script
        end

        if [ ! -x $start_script ]
            chmod +x $start_script
        end

        code $start_script
    else
        if ! set -q _flag_chaos
            open ~/Library/Mobile\ Documents/com\~apple\~Automator/Documents/QuitAll.app
            sleep 3
        end

        if [ -e $start_script ]
            echo Launching $start_script
            $start_script
        end
    end

    # The goal of this script is to strip away the inertia of getting back into an old project by making it easy to dive right back in.
    #
    # The work.eqg file is just a shell script that this `work` function can reference if there's a server to start, or any other prep to get back into the swing of things.
end
