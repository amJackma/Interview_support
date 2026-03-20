@echo off
REM Tushar Window Hider - Setup & Distribution Script
REM Advanced script for installation, building, and distribution

setlocal enabledelayedexpansion
color 0A
title Tushar Window Hider - Setup & Build

echo.
echo ============================================
echo   Tushar Window Hider - Setup Assistant
echo   Compact screen capture hider for sharing
echo ============================================
echo.

REM Check Node.js
echo [1/6] Checking Node.js...
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js not found!
    echo    Download from: https://nodejs.org/
    echo    Required: v18.17.0 or later
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('node --version') do set NODE_VER=%%i
    echo ✅ Node.js found: !NODE_VER!
)

REM Check npm
echo [2/6] Checking npm...
where npm >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ npm not found!
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('npm --version') do set NPM_VER=%%i
    echo ✅ npm found: !NPM_VER!
)

REM Check Rust
echo [3/6] Checking Rust...
where cargo >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Rust not found!
    echo    Install from: https://rustup.rs/
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('rustc --version') do set RUST_VER=%%i
    echo ✅ Rust found: !RUST_VER!
)

REM Check Visual C++ Build Tools
echo [4/6] Checking Visual C++ Build Tools...
where cl.exe >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ⚠️  Visual C++ Build Tools may not be installed
    echo    This is needed for Windows API access
    echo    Install from: https://visualstudio.microsoft.com/downloads/
    echo    Choose "Desktop development with C++"
)

REM Install project dependencies
echo [5/6] Installing project dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ npm install failed!
    pause
    exit /b 1
)

echo [6/6] Verifying Rust build...
cd src-tauri
call cargo check
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Cargo check failed!
    cd ..
    pause
    exit /b 1
)
cd ..

echo.
echo ============================================
echo   ✅ Setup Complete!
echo ============================================
echo.
echo NEXT STEPS:
echo.
echo Development:
echo   npm run tauri dev         - Start dev server
echo.
echo Production Build:
echo   npm run tauri build       - Create executables
echo.
echo After build, find distributions in:
echo   src-tauri\target\release\tushar.exe
echo   src-tauri\target\release\bundle\nsis\tushar_0.1.0_x64-setup.exe
echo   src-tauri\target\release\bundle\msi\tushar_0.1.0_x64_en-US.msi
echo.
echo FEATURES:
echo   ✓ Hide windows from screen captures
echo   ✓ Real-time 2s auto-refresh tabs
echo   ✓ Compact 480x600 window
echo   ✓ Works with Zoom, Teams, Discord
echo.
echo DOCUMENTATION:
echo   REQUIREMENTS.md          - System requirements
echo   DISTRIBUTION_GUIDE.md    - How to distribute
echo   ONBOARDING_CHECKLIST.md  - Launch checklist
echo.
pause
echo ============================================
echo.
pause
