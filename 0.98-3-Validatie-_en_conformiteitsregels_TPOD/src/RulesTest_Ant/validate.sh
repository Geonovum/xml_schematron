#!/usr/bin/sh

#script om alle Test-schematrons op bijgeleverde xml-bestanden uit te voeren

echo ""
echo "====================================="
echo "Dit script draait op de TestTPOD tests"
echo "Dit script moet in de directory voor Test_Ant worden opgestart"
echo "====================================="
echo ""

for dir in Test*
do
    echo "====================================="
    cd "${dir}"
	for schemaFile in *.sch
	do
		ant -q -f ../RulesTest_Ant/build.xml compile -DschemaFile="${schemaFile}" -Dxml="`pwd`"
		for xmlFile in *.xml
		do
		  if test -f "${xmlFile}"; then
		      ant -q -f ../RulesTest_Ant/build.xml validate -DxmlFile="${xmlFile}" -Dxml="../${dir}"
		  fi
		done
		for gmlFile in *.gml
		do
		  if test -f "${gmlFile}"; then
		      ant -q -f ../RulesTest_Ant/build.xml validate -DxmlFile="${gmlFile}" -Dxml="../${dir}"
		  fi
		done
		ant -q -f ../RulesTest_Ant/build.xml cleanup
	done
	cd ..
done
cd Ant
