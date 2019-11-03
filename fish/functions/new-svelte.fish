# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.tbWd4p/new-svelte.fish @ line 1
function new-svelte --description 'Minor keystroke savings when starting new Svelte projects from scratch'

    argparse --name=new-svelte --min-args=1 --max-args=1 'h/help' -- $argv
    or return

    set --local newAppName $argv[1]

    # Clone the svelte template
    npx degit sveltejs/template $newAppName
    builtin cd $argv[1]
    git init
    git add .
    git commit -m "npx degit sveltejs/template $newAppName"
    npm install
    git add .
    git commit -m "npm install"
    open http://localhost:5000
    npm run dev
end
