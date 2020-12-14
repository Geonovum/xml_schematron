#!/usr/bin/sh

        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp TPOD2140.sch Validaties/validaties.sch
        cp ../abstract_pattern_error.sch .
        cp ../abstract_pattern_warning.sch .
        cp *.xml Validaties/Opdracht
        cd Validaties/
        ./validate.sh
        cd ..
        rm -f -r Validaties
        rm abstract_pattern_error.sch
        rm abstract_pattern_warning.sch
       