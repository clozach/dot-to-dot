# These next two are from https://blog.hospodarets.com/fish-shell-the-missing-config

# REUSE ALIASES FROM ~/.bash_profile
egrep "^alias " ~/.bash_profile | while read e
        set var (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\1/")
        set value (echo $e | sed -E "s/^alias ([A-Za-z0-9_-]+)=(.*)\$/\2/")

        # remove surrounding quotes if existing
        set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    # evaluate variables. we can use eval because we most likely just used "$var"
        set value (eval echo $value)

    # set an alias
    alias $var="$value"
end

# REUSE ENVIRONMENT VARIABLES FROM ~/.bash_profile
egrep "^export " ~/.bash_profile | while read e
    set var (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\1/")
    set value (echo $e | sed -E "s/^export ([A-Z0-9_]+)=(.*)\$/\2/")

    # remove surrounding quotes if existing
    set value (echo $value | sed -E "s/^\"(.*)\"\$/\1/")

    if test $var = "PATH"
        # replace ":" by spaces. this is how PATH looks for Fish
        set value (echo $value | sed -E "s/:/ /g")

        # use eval because we need to expand the value
        eval set -xg $var $value

        continue
    end

    # evaluate variables. we can use eval because we most likely just used "$var"
    set value (eval echo $value)

    #echo "set -xg '$var' '$value' (via '$e')"

    if stringMatchesRegex $var '^\s*$'
        switch $value
            case '`*`'
                # executable
                set NO_QUOTES (echo $value | sed -E "s/^\`(.*)\`\$/\1/")
                set -x $var (eval $NO_QUOTES)
            case '*'
                # default
                set -xg $var $value
        end
    end
end

# Fix rbenv, per https://github.com/rbenv/rbenv/issues/195
set PATH $HOME/.rbenv/bin $PATH
set PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# Edit this file
alias fishc 'vim ~/.config/fish/config.fish'

# Serve the current directory with hot reloading
alias serve 'browser-sync start -s -f . --no-notify --host (ipconfig getifaddr en0) --port 9000'
                            # -s ⇒ local server
                            # -f ⇒ specify files
                            # --no-notify ⇒ Don't show the little "connected" badge

# Terminal Navigation
alias cdu 'cd ..'
alias cdh 'cd ~'

# Set aliases for faster `dora` interactions
alias d dora
alias d1 dd
alias d2 do
alias d3 dr
alias d4 da
alias da 'd a'
alias dd 'd d'
alias dl 'd l'
alias do 'd o'
alias dr 'd r'

# QuickLook
alias ql "qlmanage 2> /dev/null > /dev/null -p"

# Set aliases for faster `git` interactions
alias gs "git status"

# ANTLR4 SUPPORT
alias antlr4='java -jar /usr/local/lib/antlr-4.7.1-complete.jar'
alias antlr=antlr4
alias grun='java org.antlr.v4.gui.TestRig'
export CLASSPATH=".:/usr/local/lib/antlr-4.7.1-complete.jar:$CLASSPATH"

# Spacemacs
alias emacs="env HOME=$HOME/spacemacs emacs"

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
[ -f /Users/c/git/Ouroboros/graphcli/node_modules/tabtab/.completions/electron-forge.fish ]; and . /Users/c/git/Ouroboros/graphcli/node_modules/tabtab/.completions/electron-forge.fish

# Auto-load rbenv
# (from following instructions after `rbenv init fish`:
#  https://github.com/rbenv/rbenv/issues/869)
status --is-interactive; and source (rbenv init -|psub)

