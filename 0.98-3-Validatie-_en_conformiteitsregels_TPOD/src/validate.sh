#!/usr/bin/sh

for dir in Test*
do
	cd ${dir}
	for file in *.sch
	do
		position=`expr index "${file}" .sch`
		filename="${file:0:position-1}"
		echo "${filename}"
		java -cp ../saxon9.9.1.5/saxon9he.jar net.sf.saxon.Transform -s:${file} -xsl:../saxon9.9.1.5/iso_svrl_for_xslt2.xsl -o:${filename}.xsl
		for xmlfile in *.xml
		do
		  echo "${xmlfile}"
		  position=`expr index "${xmlfile}" .sch`
		  filenamexml="${file:0:position-1}"
		  output="result_${filenamexml}.xml"
		  echo "${output}"
		  java -cp ../saxon9.9.1.5/saxon9he.jar net.sf.saxon.Transform -s:${xmlfile} -xsl:${filename}.xsl -o:${output}
		done
		for gmlfile in *.gml
		do
		  echo "${gmlfile}"
		done
		rm "${filename}.xsl"
	done
	cd ..
done
