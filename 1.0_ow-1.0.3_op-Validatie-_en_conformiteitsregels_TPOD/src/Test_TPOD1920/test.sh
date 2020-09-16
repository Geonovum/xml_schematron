#!/usr/bin/sh


        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_Manifest_OW-OP/*.xml Validaties/Opdracht
        rm Validaties/Opdracht/manifest-ow_met_geometrie.xml
        cp TPOD1920.sch Validaties/validaties.sch
        cp ../abstract_pattern_error.sch .
        cp ../abstract_pattern_warning.sch .
        cd Validaties/
        ./validate.sh
        
        cp Opdracht/ActiviteitenFOUT.xml Opdracht/Activiteiten.xml
        ./validate.sh
        cd ..
        rm -f -r Validaties
        rm abstract_pattern_error.sch

        rm abstract_pattern_warning.sch
