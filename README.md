# dot-to-dot
My personal dot-file/application/system setup automation for macOS

## Usage

Nothing fancy in these scripts. They assume they're being run from within the dot-to-dot directory and will probably break if run from a different location.

### Easy install

This installation assumes that you do not yet have your machine "hooked up" to github. As such, the first parameter to the install script is an arbitrary string used to create a new `key_name` and `key_name.pub` in ~/.ssh. The following example would create a key pair called `keyname` if they don't already exist, then, with a bit of manual instruciton along the way, clones the dot-to-dot repo to the user's Desktop.

    bash <(curl -s https://raw.githubusercontent.com/clozach/dot-to-dot/master/install.sh) key_name ~
    ./first-run.sh

#### Then…

    cd ~/dot-to-dot
    ./mac-os-prefs.sh
    sudo ./shell-tools.sh

> Note: The `sudo` is necessary for the `shell-tools` script to edit /etc/shells. Also, I found I had to run this manually because it asks for a password: `chsh -s /usr/local/bin/fish`. Sigh.

Make sure to read the output and follow the manual installation instructions for all the stuff I haven't figured out how to automate, yet. 🙄

### If brew already installed on machine from another macOS user account

    ./fix-brew-permissions-on-shared-machine.sh
