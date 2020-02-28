#!/usr/bin/sh

for dir in Test*
do
	cd ${dir}
	for file in *.sch
	do
		position=`expr index "${file}" .sch`
		echo ${position}
		#java -cp ../saxon9.9.1.5/saxon9he.jar net.sf.saxon.Transform -t -s:${file} -xsl:../saxon9.9.1.5/iso_svrl_for_xslt2.xsl -o:${file}.xsl
	done
	cd ..
done
