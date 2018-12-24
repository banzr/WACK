@ECHO OFF

Rem This file enables Powershell Scripts and runs WACK.
Rem Please run this file as administrato

goto check_Permissions

:check_Permissions
    echo Administrative permissions required. Detecting permissions...

    net session >nul 2>&1
    if %errorLevel% == 0 (
        powershell.exe -noexit -ExecutionPolicy ByPass -File wack.ps1
    ) else (
        echo Failure: Current permissions inadequate.
	echo Please run as administrator
    )

    pause >nul

