#!/usr/bin/sh

# Test alle tekst_nummer directories

cd ..
for d in Test_*; do
	echo "Running ${d:5}"
	cd "../Test_${d:5}"
	./test.sh
	cd -
done
