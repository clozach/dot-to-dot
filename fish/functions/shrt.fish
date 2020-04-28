# Defined in /var/folders/7t/qn5djvd12cbf42936rdxpct40000gn/T//fish.02puHp/shrt.fish @ line 2
function shrt --description 'Shorten a URL'
	set -l options 'h/help'

  argparse -n shrt $options -- $argv
  or return

  if set -q _flag_help
    echo "Usage: `shrt https://example.com/some-longass-url`"
    echo ""
    echo "Behavior:"
    echo "  1. Generates a random, 4-letter short code"
    echo "  2. Prepends the short code + given URL to `~/git/eqg.me/_redirects`"
    echo "  3. Commits the change to `~/git/eqg.me/_redirects`"
    echo "  4. Pushes the change to my remote on BitBucket so that Netlify can see it"
    echo ""
    echo "For more on redirects, see: https://docs.netlify.com/routing/redirects/"
    return 0
  end

  if not set -q argv[1]
    read -P "Enter the URL to shorten: " user_input
    set argv $user_input
  end

  node ~/Documents/2-Ongoing/eqg.me/node_modules/.bin/netlify-shortener $argv
end
