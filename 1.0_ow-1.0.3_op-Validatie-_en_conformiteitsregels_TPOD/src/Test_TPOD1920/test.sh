#!/usr/bin/sh


        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_Manifest_OW-OP/*.xml Validaties/Opdracht
        rm Validaties/Opdracht/manifest-ow_met_geometrie.xml
        cp TPOD1920.sch Validaties/validaties.sch
        cd Validaties/
        ./validate.sh
        
        cp Opdracht/ActiviteitenFOUT.xml Opdracht/Activiteiten.xml
        ./validate.sh

        rm -f -r ../Validaties
