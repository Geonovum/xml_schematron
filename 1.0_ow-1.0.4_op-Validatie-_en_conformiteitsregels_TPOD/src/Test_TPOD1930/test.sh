#!/usr/bin/sh


         rm -f -r ../Validaties
        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_OW/*.xml Validaties/Opdracht
        cp TPOD1930.sch Validaties/validaties.sch
        cp ../abstract_pattern_error.sch .
        cp ../abstract_pattern_warning.sch .
        cp Besluit.xml Validaties/Opdracht
        cp tpod1930.xml Validaties/Opdracht
        cd Validaties/
        ./validate.sh
        cd ..
        rm -f -r Validaties
        rm abstract_pattern_error.sch
        rm abstract_pattern_warning.sch
