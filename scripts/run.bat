@echo off
setlocal

set build=False
set clear=False

:parse_flags
if "%1"=="" goto end_parse
if "%1"=="-b" (
    set build=True
) else if "%1"=="-c" (
    set clear=True
) else if "%1"=="-bc" (
    set build=True
    set clear=True
) else if "%1"=="-cb" (
    set build=True
    set clear=True
) else (
    exit /b 1
)
shift
goto parse_flags
:end_parse

if %build%==True (
    if %clear%==True (
        cls && call build.bat && cls && goto run
    ) else (
        call build.bat && goto run
    )
) else (
    if %clear%==True (
        cls
    )
    goto run
)
:end
endlocal
exit /b 0

:run
cd ../bin
Game
cd ../scripts
goto end
