#!/usr/bin/sh

# Test een bepaalde directory aangegeven door een variabele met testnummer en voorvoegsel, bijvoorbeeld 0230 OP-OmgevingVerordening

if ([ -z "$2" ] || [ -z "$1" ])
then
    echo "Geef nummer-variable gecombineerd met label op, en data-label, bijvoorbeeld:0230 OP-OmgevingVerordening"
else
    echo "Test uitvoeren met parameter: Test_TPOD$1 TestData_$2"
    
    cd ..
    if ([ -d Test_TPOD$1 ] && [ -d TestData_$2 ])
    then
        cp -R ../Validaties Test_TPOD$1
        rm -f -r Test_TPOD$1/Validaties/Opdracht
        mkdir Test_TPOD$1/Validaties/Opdracht
        cp TestData_$2/*.xml Test_TPOD$1/Validaties/Opdracht
        cp TestData_$2/*.gml Test_TPOD$1/Validaties/Opdracht
        cp Test_TPOD$1/TPOD$1.sch Test_TPOD$1/Validaties/validaties.sch
        cd Test_TPOD$1/Validaties/
        ./validate.sh
        cd ../..
        rm -f -r Test_TPOD$1/Validaties
    else
        if [ -d Test_TPOD$1 ]
        then
            echo "Directory TestData_$2 bestaat niet"
        fi
        if [ -d TestData_$2 ]
        then
            echo "Directory Test_TPOD$1 bestaat niet"
        fi
    fi  
fi