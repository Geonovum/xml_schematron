@echo off


if [%1]==[] GOTO error

echo Test uitvoeren met parameter: %1 

goto exit

:Error
    echo Geef 1 nummer-variable gecombineerd met label op, bijvoorbeeld:TPOD0230
    
:exit

