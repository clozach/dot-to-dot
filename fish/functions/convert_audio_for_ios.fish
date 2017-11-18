function convert_audio_for_ios --argument source_filename target_filename
    if begin isPresent $source_filename; and isPresent $target_filename; end
        afconvert $source_filename $target_filename -d ima4 -f caff -v
    else
	echo "I used this to prep the `short_circuit.wav` sound for Jrnl notifications"
        echo "Don't have the stackoverflow link anymore, but according to this…"
        echo "https://www.raywenderlich.com/69367/audio-tutorial-ios-converting-recording-2014-edition"
	echo "…it looks like the script you're about to use is strictly for sound effects."
	echo ""
        echo "Usage: convert_audio_for_ios <source_filename> <target_filename>"
    end
end
