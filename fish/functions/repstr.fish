function repstr --description "Creates a repeating string from the input" --argument-names str num
    for i in (seq $num)
        printf $str
    end

    # See https://stackoverflow.com/questions/24859503/repeat-character-in-fish-shell
end
