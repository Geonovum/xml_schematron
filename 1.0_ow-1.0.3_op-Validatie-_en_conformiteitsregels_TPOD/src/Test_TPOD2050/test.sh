#!/usr/bin/sh

cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_Manifest_OW-OP/*.xml Validaties/Opdracht
        cp TPOD2050.sch Validaties/validaties.sch
        cd Validaties/
        #alleen manifest-ow
        ./validate.sh
        #manifst-ow + manifest
        cp Opdracht/manifest-ow.xml Opdracht/manifest.xml
        ./validate.sh
        rm Opdracht/manifest-ow.xml
        #alleen manifest
        ./validate.sh

       