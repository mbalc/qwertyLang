grammar:
	~/.cabal/bin/bnfc -m -o src/grammar qwerty.cf
	(cd src/grammar; make)

