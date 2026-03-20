@echo off
REM Build script for Tushar installer
REM Prerequisites: Inno Setup installed at C:\Program Files (x86)\Inno Setup 6\

setlocal enabledelayedexpansion

echo.
echo ============================================
echo  Tushar Installer Build Script
echo ============================================
echo.

REM Check if Inno Setup is installed
if not exist "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" (
    echo ERROR: Inno Setup not found at default location
    echo Please install Inno Setup from: https://jrsoftware.org/isdl.php
    echo.
    pause
    exit /b 1
)

REM Check if we're in the right directory
if not exist "tushar_installer.iss" (
    echo ERROR: tushar_installer.iss not found in current directory
    echo Please run this script from the Tushar root directory
    echo.
    pause
    exit /b 1
)

REM Build the Rust binary
echo.
echo [1/3] Building Rust binary...
echo.
cd src-tauri
call cargo build --release
if errorlevel 1 (
    echo ERROR: Cargo build failed
    cd ..
    pause
    exit /b 1
)
cd ..

REM Create output directory
echo.
echo [2/3] Creating output directory...
if not exist "releases\installer" mkdir releases\installer

REM Compile the installer
echo.
echo [3/3] Compiling Inno Setup installer...
echo.
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" /F"Tushar-2.0.0-Installer" /O"releases\installer" tushar_installer.iss

if errorlevel 1 (
    echo.
    echo ERROR: Inno Setup compilation failed
    pause
    exit /b 1
)

echo.
echo ============================================
echo  Build Complete!
echo ============================================
echo.
echo Installer created at: releases\installer\Tushar-2.0.0-Installer.exe
echo.
echo You can now distribute this installer file.
echo.
pause
