function pmv # Power Move (creates parent dir in path if it doesn't already exist)

    # Make sure the directory structure exists to receive the move
    set target_dir (dirname $argv[2])  # Note: for just the filename, use `basename`

    if not test -d $target_dir
        echo Creating parent directory/ies from $target_dir
        mkdir -p $target_dir

        # HACK: Give the directory a chance to exist before attempting the move
        sleep .2 &
        wait
    end

    # Perform the move
    set command "mv $argv[1] $argv[2]"
    echo Performing: $command
    eval $command
end
