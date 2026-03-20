@echo off
REM Tushar Project Setup Script for Windows
REM This script automates the installation of all project requirements

setlocal enabledelayedexpansion
color 0A
title Tushar Project Setup

echo.
echo ============================================
echo   Tushar Window Hider - Setup Assistant
echo ============================================
echo.

REM Check Node.js
echo [1/5] Checking Node.js...
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
echo [2/5] Checking npm...
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
echo [3/5] Checking Rust...
where cargo >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Rust not found!
    echo    Install from: https://rustup.rs/
    echo    Or run: irm https://rustup.rs ^| iex
    pause
    exit /b 1
) else (
    for /f "tokens=*" %%i in ('rustc --version') do set RUST_VER=%%i
    echo ✅ Rust found: !RUST_VER!
)

REM Check Tauri CLI
echo [4/5] Installing/Checking Tauri CLI...
npm list -g @tauri-apps/cli >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo    Installing Tauri CLI globally...
    npm install -g @tauri-apps/cli@latest
) else (
    echo ✅ Tauri CLI already installed
)

REM Install project dependencies
echo [5/5] Installing project dependencies...
call npm install
if %ERRORLEVEL% NEQ 0 (
    echo ❌ npm install failed!
    pause
    exit /b 1
)

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
echo Next steps:
echo   1. Run development server:
echo      npm run tauri dev
echo.
echo   2. Build for production:
echo      npm run tauri build
echo.
echo Documentation:
echo   - REQUIREMENTS.md      - System requirements
echo   - NODE_DEPENDENCIES.md - Frontend deps
echo   - RUST_DEPENDENCIES.md - Backend deps
echo.
echo ============================================
echo.
pause
