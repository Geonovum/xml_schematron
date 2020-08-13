#!/usr/bin/sh

        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_OW/*.xml Validaties/Opdracht
        cp TPOD2180.sch Validaties/validaties.sch
        cd Validaties/
        ./validate.sh
        rm Opdracht/regelinggebied.xml
        ./validate.sh
        cd ..
        rm -f -r Validaties
       