@echo off
setlocal enabledelayedexpansion

set "PBIN="

REM Check each Python binary
for %%i in (python3 python py) do (
    where %%i >nul 2>nul
    if !errorlevel! equ 0 (
        set "PBIN=%%i"
        goto :found
    )
)

REM Check PYTHON_RUNTIME_BIN environment variable
if defined PYTHON_RUNTIME_BIN (
    set "PBIN=%PYTHON_RUNTIME_BIN%"
    goto :found
)

echo Python not found in PATH and PYTHON_RUNTIME_BIN is not set
exit /b 1

:found
%PBIN% "%~dp0main.py" %*
