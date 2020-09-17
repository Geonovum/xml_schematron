#!/usr/bin/sh

        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp *.xml Validaties/Opdracht
        cp TPOD2050.sch Validaties/validaties.sch
        cp ../abstract_pattern_error.sch .
        cp ../abstract_pattern_warning.sch .
        cd Validaties/
        #alleen manifest-ow
        echo "alleen manifest-ow"
        rm Opdracht/manifest.xml
        ./validate.sh
        #manifest-ow + manifest
        echo "manifest-ow + manifest"
        cp ../*.xml Opdracht
        ./validate.sh
        #alleen manifest
        echo "alleen manifest"
        cp ../*.xml Opdracht
        rm Opdracht/manifest-ow.xml
        ./validate.sh
        cd ..
        rm -fr Validaties
        rm abstract_pattern_error.sch
        rm abstract_pattern_warning.sch
        
       