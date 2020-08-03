@ECHO OFF

:: Change this accordingly
SET fileToMonitor=C:\Users\Fred\Workspace\com.ffc.advplstore.devops\.git\index

ECHO "Listening for file changes on %fileToMonitor%"

:loop
TIMEOUT -t 1 >nul
FOR %%i IN (%fileToMonitor%) DO ECHO %%~ai|FIND "a">nul || GOTO :loop
ECHO "Changes detected at %DATE% - %TIME%. Recompiling..."
CALL Compile.bat
ECHO "Listening for file changes on %fileToMonitor%"
ATTRIB -a %fileToMonitor%

GOTO :loop