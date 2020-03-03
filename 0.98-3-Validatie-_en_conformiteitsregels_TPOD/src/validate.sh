#!/usr/bin/sh

for dir in Test*
do
	cd Ant
	echo "${dir}"
	for schemaFile in ../${dir}/*.sch
	do
		echo "${schemaFile}"
		ant compile -q -DschemaFile="${schemaFile}"
		for xmlFile in ../${dir}/*.xml
		do
		  echo "${xmlFile}"
		  ant validate -q -DxmlFile="${xmlFile}"
		done
		for gmlFile in ../${dir}/*.gml
		do
		  echo "${gmlFile}"
		  ant validate -q -DxmlFile="${gmlFile}"
		done
		ant cleanup -q
	done
	cd ..
done
