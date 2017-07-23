function file_exists
    test -e $argv[1]
end

function directory_exists
    test -d $argv[1]
end
