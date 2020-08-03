@ECHO OFF
SETLOCAL
SETLOCAL ENABLEDELAYEDEXPANSION

:: Change this accordingly
SET rootSrcFolder=C:\Users\Fred\Workspace\com.ffc.advplstore.devops\Examples
SET rpo=D:\TOTVS\Protheus\Protheus\apo\tttp120.rpo
SET environment=environment
SET appServer=D:\TOTVS\Protheus\Protheus\bin\appserver\appserver.exe
SET includeFolder=D:\TOTVS\Protheus\Protheus\include

ECHO "Duplicating %rpo%..."
CALL :GetPath rpoFolder "%rpo%"
CD /D %rpoFolder%
SET newRpoFolder=%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%
MKDIR %newRpoFolder%
COPY %rpo% %newRpoFolder%
CD /D %newRpoFolder%

ECHO "Updating appserver.ini to use the new RPO..."
CALL :GetPath appServerFolder "%appServer%"
CD /D %appServerFolder%
CALL :BackUpFile "appserver.ini"
CALL :UpdCfg "%rpoFolder%%newRpoFolder%"

ECHO "Compiling..."
CD /D %rootSrcFolder%
FOR /r %%i in (*.prw *.tlpp) do CALL :Compile %%i

ECHO "Cleaning up..."
CALL :CleanUp

EXIT /B %ERRORLEVEL%

:Compile
    %appServer% -compile -files=%~1 -includes=%includeFolder% -env=%environment% -src=%srcFolder%
EXIT /B 0

:CleanUp
    DEL /S *.errprw
    DEL /S *.erx_prw
    DEL /S *.ppx_prw
    DEL /S *.errtlpp
    DEL /S *.erx_tlpp
    DEL /S *.ppx_tlpp
EXIT /B 0

:GetPath
    SET "%1=%~dp2"
EXIT /b

:UpdCfg
    SET replaced="false"
    for /f %%a in (appserver.ini) do (
        SET s=%%a
        echo !s!|find "SourcePath" >nul
        if not errorlevel 1 (
            if !replaced! == "false" (
                SET s=SourcePath=%~1
                SET replaced="true"
            )
        )
        echo !s! >> appserver_temp.ini
    )

    type appserver_temp.ini > appserver.ini
    DEL /S appserver_temp.ini
EXIT /b

:BackUpFile
    COPY %~1 %~1.%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%%TIME:~0,2%%TIME:~3,2%%TIME:~6,2%.bak
EXIT /b