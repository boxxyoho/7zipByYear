@ECHO OFF

set 7z=7za.exe
if not exist %7z% set /p 7z="Path to 7-zip executable? "

REM This sets name of the zip file
set /p choiceYear=What is the year of the files?

REM This sets the path of the file
set /p pathOfFiles=What is the path of the files on?

REM Use 7Zip to Zip files in folder c:\path and place the zip archive in C:\path

mkdir %UserProfile%\%choiceYear%
ECHO Zipping all files in %pathOfFiles% and moving archive to %UserProfile%\%choiceYear%\
for /f "tokens=5*" %%I in ('dir %pathOfFiles% ^| find "/%choiceYear%"') do move %pathOfFiles%\%%I %%J %choiceYear%

%7z% a -tzip %pathOfFiles%\%choiceYear%.zip %choiceYear% -mx5

PAUSE

ECHO Would you like to Delete the files in orginal folder?
PAUSE

ECHO File is now zipped

REM set /p I="I'm about to delete the %year% folder.  Hit Ctrl-C if this is a bad idea, or hit Enter to continue."
REM rmdir /q /s "%year%"

echo Done.