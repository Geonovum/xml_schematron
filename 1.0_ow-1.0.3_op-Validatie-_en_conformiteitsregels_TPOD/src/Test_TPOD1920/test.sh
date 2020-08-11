#!/usr/bin/sh


        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_Manifest_OW-OP/*.xml Validaties/Opdracht
        cp ../TestData_Manifest_OW-OP/*.gml /Validaties/Opdracht
        cp TPOD1920.sch Validaties/validaties.sch
        cd Validaties/
        ./validate.sh
        
        cp Opdracht/ActiviteitenFOUT.xml Opdracht/Activiteiten.xml
        ./validate.sh

        rm -f -r ../Validaties
