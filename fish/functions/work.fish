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
        echo "The work does 3 simple things:
				  1. Open the specified location (or current dir) in VS Code.
				  2. Open the specified location (or current dir) in SourceTree.
				  3. Runs the file `work.eqg` in that same directory, if there is one.
					
				Oh. And it can create a `work.eqg` file and make it executable, if you want.

				Example:
					
					cd ~/projects/newproj
					work --init   # Opens the `work.eqg` file so you can add your startup instrutions.
					              # Currently idiosyncratic: opens in VS Code.
					work          # Opens the dev environment and rurns the script.
                    work --chaos  # In order to train me to focus on one thing at a time, `work` uses
                                  # my QuitAll.app Automator workflow to create a clean work space.
                                  # The `--chaos` flag skips this step.
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
