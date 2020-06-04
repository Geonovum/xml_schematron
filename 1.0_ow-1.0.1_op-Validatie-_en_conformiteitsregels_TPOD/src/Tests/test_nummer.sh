#!/usr/bin/sh

# Test een bepaalde directory aangegeven door een variabele met testnummer en voorvoegsel, bijvoorbeeld TPOD0230

if [ -z "$1" ]
then
      echo "Geef 1 nummer-variable gecombineerd met label op, bijvoorbeeld:TPOD0230"
else
      echo "Test uitvoeren met parameter: $1"
      
      cd ..
      if [ -d Test_$1 ]
      then
        cp -R Validaties Test_$1
        rm -f -r Test_$1/Validaties/Opdracht
        mkdir Test_$1/Validaties/Opdracht
        cp Test_$1/*.xml Test_$1/Validaties/Opdracht
        cp Test_$1/*.gml Test_$1/Validaties/Opdracht
        cp Test_$1/$1.sch Test_$1/Validaties/validaties.sch
        cd Test_$1/Validaties/
        ./validate.sh
        cd ../..
        rm -f -r Test_$1/Validaties
      else
        echo "Directory Test_$1 bestaat niet"
      fi
fi