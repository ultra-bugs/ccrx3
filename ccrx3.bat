@echo off
setlocal enabledelayedexpansion

set "PBIN="

:: Check each Python binary by trying to execute a simple Python command
for %%i in (python3 python py) do (
    %%i -c "print('test')" >nul 2>nul
    if !errorlevel! equ 0 (
        set "PBIN=%%i"
        goto :found
    )
)

:: Check PYTHON_RUNTIME_BIN environment variable
if defined PYTHON_RUNTIME_BIN (
    %PYTHON_RUNTIME_BIN% -c "print('test')" >nul 2>nul
    if !errorlevel! equ 0 (
        set "PBIN=%PYTHON_RUNTIME_BIN%"
        goto :found
    )
)

echo No valid Python installation found in PATH or PYTHON_RUNTIME_BIN
exit /b 1

:found
%PBIN% "%~dp0main.py" %*
