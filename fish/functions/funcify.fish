function funcify --description 'Slightly higher-level function editing'

    # Those steps:
    # 
    # 1) funced <name-of-new-function>
    # 2) funcify <name-of-new-function>

    set -l options 'h/help' 'c/commit='
    argparse --name funcify $options -- $argv
    or return

    if set -q _flag_help || not set -q argv[1]
        echo "Usage: funcify [-c <commit-message>] <name-of-new-function>"
        echo
        echo "To be used after `funced <name-of-new-function>`"
        echo
        echo "OPTIONS"
        echo
        echo "-c If a commit message is specified with the -c option, funcify will commit all open changes in the `dot-to-dot` repo with that message, then push to my GitHub."
        echo
        echo "EXAMPLES"
        echo
        echo "funcify -h                                  # View this help text."
        echo "funcify somefunc                            # Save somefunc without making a git commit."
        echo "funcify -c \"added somefunc 🤓\" somefunc     # Commit and push somefunc."
        return 0
    end

    echo Saving $argv
    funcsave $argv

    if set -q _flag_c
        cdf
        git add .
        git commit -m $_flag_c
        git push
        echo "Committed function `$argv` with message \"$_flag_c\""
    end
end
