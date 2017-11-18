function print_bool --argument arg
# Displays the result of evaluating the first-and-only argument (passed in as a string)
	if eval $arg
echo "true"
else
echo "false"
end
end
