#!/usr/bin/sh

# Test alle tekst_nummer directories

cd ..
for d in Test_*; do
	cd Tests
	./test_nummer.sh "${d:5}"
	cd ..
done