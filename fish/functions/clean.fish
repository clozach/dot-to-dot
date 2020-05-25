function clean --description 'For rapid organization of Downloads, Desktop, etc.'
    set -l opts "t (trash) e (Evernote) p (Photos) m (move/rename) v (view) s (show) q (quicklook [default]) h (help)"
    echo "Let's get cleaning!

    #
    # `clean` is inspired by Tiago Forte's Weekly Review
    # → https://www.youtube.com/playlist?list=PLVNXAaej57W63yyOFiJtdrZR6lpODnKrW
    #

Options: d o r a $opts
"
    set -l files (ls)

    function process --description "Handle cleaning process for a single file"
        set -l processing_file true
        set -l help_text $argv[1]
        set -l f $argv[2]

        while $processing_file
            echo (set_color brblack)$f(set_color normal)
            read -P "[doratepmvsQ]? " user_input

            # Print Help
            if string match -qi h $user_input
                echo $help_text

                # Move to Due
            else if string match -qi d $user_input
                # echo (set_color green)Due(set_color normal) ← $f
                dora d $f
                set processing_file false

                # Move to Ongoing
            else if string match -qi o $user_input
                # echo (set_color green)Ongoing(set_color normal) ← $f
                dora o $f
                set processing_file false

                # Move to Research
            else if string match -qi r $user_input
                # echo (set_color green)Research(set_color normal) ← $f
                dora r $f
                set processing_file false

                # Move to Archives
            else if string match -qi a $user_input
                # echo (set_color green)Archives(set_color normal) ← $f
                dora a $f
                set processing_file false

                # Trash 🗑
            else if string match -qi t $user_input
                echo (set_color red)Trash(set_color normal) ← $f
                trash $f
                set processing_file false

                # Copy to Evernote, trash original
            else if string match -qi e $user_input
                open -a "Evernote" $f
                trash $f
                set processing_file false

                # Copy to Photos, trash original
            else if string match -qi p $user_input
                open -a "Photos" $f
                sleep 3
                trash $f
                set processing_file false

                # Move/Rename
            else if string match -qi m $user_input
                read -P "Enter a new name or path for $f: " dest
                mv -i $f $dest
                set f $dest

                # View in default application
            else if string match -qi v $user_input
                open $f

                # Show in Finder
            else if string match -qi s $user_input
                open -R $f

                # Open with QuickLook
            else if string match -q "" $user_input || string match -qi q $user_input
                ql $f

                # Invalid Input
            else
                echo (set_color red)Invalid input. Try agian.(set_color normal)
            end
        end
    end

    for file in $files
        process $opts $file
    end
end
