@echo off
set TargetName=Unprotect
set ConfigurationName=Release
set base=%TargetName%
rem -%ConfigurationName%
set src=%TargetName%-Source


set out=S:\Sims3\Tools\sims3tools\builds\Unprotect\


set mydate=%date: =0%
set dd=%mydate:~0,2%
set mm=%mydate:~3,2%
set yy=%mydate:~8,2%
set mytime=%time: =0%
set h=%mytime:~0,2%
set m=%mytime:~3,2%
set s=%mytime:~6,2%
set suffix=%yy%-%mm%%dd%-%h%%m%








if x%ConfigurationName%==xRelease goto REL
set pdb=
goto noREL
:REL:
set pdb=-xr!*.pdb -xr!*.xml
:noREL:


rem there shouldn't be any to delete...
del /q /f %out%%TargetName%*%suffix%.*

pushd ..
7za a -r -t7z -mx9 -ms -xr!.?* -xr!*.suo -xr!zzOld -xr!bin -xr!obj -xr!Makefile -xr!*.Config "%out%%src%_%suffix%.7z" "Unprotect"
popd

pushd bin\%ConfigurationName%
echo %suffix% >%TargetName%-Version.txt
attrib +r %TargetName%-Version.txt


7za a -r -t7z -mx9 -ms -xr!.?* -xr!*vshost* -xr!*.Config %pdb% "%out%%base%_%suffix%.7z" *
del /f %TargetName%-Version.txt

popd

pause
