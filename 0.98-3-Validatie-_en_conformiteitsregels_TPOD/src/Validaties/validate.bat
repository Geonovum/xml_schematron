echo off
echo 
echo =====================================
echo Dit script draait op de TestTPOD tests
echo Dit script moet vanuit de directory voor Opdracht worden opgestart
echo =====================================
echo 

mkdir tmp
ant -q all
del tmp\*.*
rmdir tmp
