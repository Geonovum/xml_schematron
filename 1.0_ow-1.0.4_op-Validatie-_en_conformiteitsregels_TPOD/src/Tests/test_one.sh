#!/usr/bin/sh

# Test alle tekst_nummer directories

	echo "Running $1"
	cd "../Test_$1"
	./test.sh
	cd -
