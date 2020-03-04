#!/usr/bin/sh

#script om alle Test-schematrons op bijgeleverde xml-bestanden uit te voeren

echo "Dit script draait op de TestTPOD tests"

for dir in Test*
do
	cd Ant
	for schemaFile in ../${dir}/*.sch
	do
		ant compile -q -DschemaFile="${schemaFile}"
		for xmlFile in ../${dir}/*.xml
		do
		  if test -f "${xmlFile}"; then
		      ant validate -q -DxmlFile="${xmlFile}"
		  fi
		done
		for gmlFile in ../${dir}/*.gml
		do
		  if test -f "${gmlFile}"; then
		      ant validate -q -DxmlFile="${gmlFile}"
		  fi
		done
		ant cleanup -q
	done
	cd ..
done
