function ssh_fingerprint
	echo "Generating fingerprint for ssh key: $argv\n"
  # See https://stackoverflow.com/questions/9607295/how-do-i-find-my-rsa-key-fingerprint
	ssh-keygen -E md5 -lf $argv[1]
end
