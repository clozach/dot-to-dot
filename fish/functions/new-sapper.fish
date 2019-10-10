# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.eBxpB6/new-sapper.fish @ line 2
function new-sapper --description 'Minor keystroke savings when starting new Sapper projects from scratch'

    # Parse Arguments
    argparse --name=new-sapper --min-args=1 --max-args=1 'h/help' -- $argv
    or return

    set --local newAppName $argv[1]

    # Clone the sapper template
    npx degit "sveltejs/sapper-template#rollup" $newAppName
    builtin cd $argv[1]
    git init
    git add .
    git commit -m "npx degit \"sveltejs/sapper-template#rollup\" $newAppName"
    npm install
    git add .
    git commit -m "npm install"
    open http://localhost:3000
    npm run dev
end
