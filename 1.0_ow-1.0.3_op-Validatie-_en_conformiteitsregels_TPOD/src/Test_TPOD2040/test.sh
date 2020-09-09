#!/usr/bin/sh

        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp TPOD2040.sch Validaties/validaties.sch
        cp *.xml Validaties/Opdracht
        cd Validaties/
        ./validate.sh
        cd ..
        rm -f -r Validaties
       