function nt --description Opens\ a\ new\ tab\ in\ the\ current\ tab\'s\ current\ working\ directory.
	set d (pwd)
npx ttab -d $d
end
