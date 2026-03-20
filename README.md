# Tushar - Lightweight Window Hiding Tool

A fast, lightweight CLI tool for Windows that hides and shows windows using keyboard shortcuts. Built with Rust for maximum performance and portability.

## Features

✅ **Lightweight** - Only 980 KB executable, minimal dependencies  
✅ **Fast** - Built in pure Rust with Windows API  
✅ **Portable** - Single standalone .exe file, no runtime dependencies  
✅ **Easy to Use** - Keyboard shortcuts via AutoHotkey launcher  
✅ **Open Source** - Full source code available on GitHub  

## Installation

### Option 1: Windows Installer (Recommended for End Users)

1. Download `Tushar-2.0.0-Installer.exe` from [releases/installer/](releases/installer/)
2. Run the installer and follow the setup wizard
3. AutoHotkey v2 will be required (installer will prompt)
4. Launch Tushar from the Start Menu or desktop shortcut

**See [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) for detailed instructions.**

### Option 2: Portable (No Installation Required)

1. Download from [releases/v2.0.0/](releases/v2.0.0/):
   - `tushar.exe` - Main CLI tool
   - `tushar_launcher.ahk` - AutoHotkey launcher

2. Install [AutoHotkey v2](https://www.autohotkey.com/) (one-time)

3. Double-click `tushar_launcher.ahk` to start

### Option 3: Build from Source

**Prerequisites:**
- [Rust](https://www.rust-lang.org/tools/install) (latest stable)
- Windows 10+

**Build:**
```bash
cd src-tauri
cargo build --release
```

Output: `target/release/tushar.exe`

## Usage

### Via Keyboard Shortcuts (Recommended)

After running `tushar_launcher.ahk`:

| Shortcut | Action |
|----------|--------|
| `CTRL + J` | Hide the active window |
| `CTRL + K` | Show hidden windows |
| `CTRL + Q` | Exit the launcher |

### Via Command Line

```bash
# Hide window by Process ID
tushar.exe hide 1234

# Show window by Process ID
tushar.exe unhide 1234

# Get help
tushar.exe --help
```

To find a process ID:
- Windows Task Manager → Process ID column
- PowerShell: `Get-Process processname | Select-Object Id`

## Downloads

### Version 2.0.0 - Lightweight CLI Edition

**Release Date:** March 20, 2026  
**Binary Size:** 980 KB  
**Build Time:** <1 second

**Files:**
- [`tushar.exe`](releases/v2.0.0/tushar.exe) - Main application
- [`tushar_launcher.ahk`](releases/v2.0.0/tushar_launcher.ahk) - Keyboard launcher

## Project Structure

```
tushar/
├── src-tauri/           # Rust source code
│   ├── src/main.rs      # CLI implementation
│   ├── Cargo.toml       # Dependencies
│   ├── build.rs         # Icon compilation
│   ├── tushar_launcher.ahk
│   └── icons/           # Application icons
├── releases/
│   └── v2.0.0/          # Compiled binaries
└── README.md
```

## Building Distribution Package

### Portable Binary

To create a standalone executable:

```bash
cd src-tauri
cargo build --release
```

Output: `target/release/tushar.exe` (fully portable, ready to distribute)

### Windows Installer

To build the Windows installer (requires [Inno Setup](https://jrsoftware.org/isdl.php)):

```bash
# 1. Build the Rust binary
cd src-tauri
cargo build --release
cd ..

# 2. Compile installer with Inno Setup
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" tushar_installer.iss
```

Output: `releases/installer/Tushar-2.0.0-Installer.exe`

See [INSTALLATION_GUIDE.md](INSTALLATION_GUIDE.md) for detailed build instructions.

## Technical Details

**Language:** Rust  
**Size:** 980 KB (uncompressed)  
**Dependencies:**
- `clap` 4.5 - Command-line argument parsing
- `windows` 0.54 - Windows API bindings
- `winresource` 0.1 - Icon compilation

**Supported Platforms:** Windows x86_64 (Windows 10+)

## License

This project is open source. See LICENSE for details.

## Contributing

Issues and pull requests are welcome on GitHub.

