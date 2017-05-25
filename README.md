# dot-to-dot
My personal dot-file/application/system setup automation for macOS

## Usage

Nothing fancy in these scripts. They assume they're being run from within the dot-to-dot directory and will probably break if run from a different location.

### Easy install

This installation assumes that you do not yet have your machine "hooked up" to github. As such, the first parameter to the install script is an arbitrary string used to create a new `key_name` and `key_name.pub` in ~/.ssh. The following example would create a key pair called `keyname` if they don't already exist, then, with a bit of manual instruciton along the way, clones the dot-to-dot repo to the user's Desktop.

    bash <(curl -s https://raw.githubusercontent.com/clozach/dot-to-dot/master/install.sh) key_name ~/Desktop
    ./first-run.sh

### If brew already installed on machine from another macOS user account

    ./fix-brew-permissions-on-shared-machine.sh
