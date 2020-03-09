@echo off

cd ..
for /D %%i in (Test_*) do (
	set __var=%%i
	cd Tests
    set _var=%__var:~-8,8%
	test_nummer.bat %_var%
	cd ..
)
cd Tests