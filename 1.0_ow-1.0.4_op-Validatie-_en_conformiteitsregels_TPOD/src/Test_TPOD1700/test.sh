#!/usr/bin/sh


        rm -f -r Validaties/Opdracht
        mkdir Validaties
        mkdir Validaties/Opdracht
        cp -R ../../Validaties .
        cp ../TestData_OW/*.xml Validaties/Opdracht
        cp TPOD1700.sch Validaties/validaties.sch
        cp ../abstract_pattern_error.sch .
        cp ../abstract_pattern_warning.sch .
        cp *.xml Validaties/Opdracht
        rm Validaties/Opdracht/stcrt-2019-56288-produktie.xml
        cd Validaties/
        ./validate.sh
        cd ..
        rm -f -r Validaties
        rm abstract_pattern_error.sch
        rm abstract_pattern_warning.sch
