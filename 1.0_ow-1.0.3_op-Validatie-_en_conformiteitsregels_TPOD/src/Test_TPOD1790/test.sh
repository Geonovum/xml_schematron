#!/usr/bin/sh


         rm -f -r ../Validaties
        cp -R ../../Validaties .
        rm -f -r Validaties/Opdracht
        mkdir Validaties/Opdracht
        cp ../TestData_OW/*.xml Validaties/Opdracht
        cp TPOD1790.sch Validaties/validaties.sch
        cp Besluit.xml Validaties/Opdracht
        rm Validaties/Opdracht/stcrt-2019-56288-produktie.xml
        cd Validaties/
        ./validate.sh
        rm -f -r ../Validaties

