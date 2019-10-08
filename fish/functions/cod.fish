# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.YelhGS/cod.fish @ line 2
function cod --description 'Open `pwd` in VS Code & SourceTree'
	code .

  stree .

  switch (echo $argv)
    case n
      # n, meaning "no npm" does nothing more.

    case '*'
      # Launch the app
      open http://localhost:5000
      npm run dev
  end
end
