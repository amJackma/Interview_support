# Tushar - Lightweight Window Hiding Tool

A fast, lightweight CLI tool for Windows that hides and shows windows using keyboard shortcuts. Built with Rust for maximum performance and portability.

## Features

✅ **Lightweight** - Only 980 KB executable, minimal dependencies  
✅ **Fast** - Built in pure Rust with Windows API  
✅ **Portable** - Single standalone .exe file, no runtime dependencies  
✅ **Easy to Use** - Keyboard shortcuts via AutoHotkey launcher  
✅ **Open Source** - Full source code available on GitHub  

## Installation

### Option 1: Quick Start (Recommended)

1. Download the latest release from [releases/v2.0.0/](releases/v2.0.0/)
2. Extract the files:
   - `tushar.exe` - Main CLI tool
   - `tushar_launcher.ahk` - AutoHotkey launcher with keyboard shortcuts

3. Install [AutoHotkey v2](https://www.autohotkey.com/) (required once for keyboard shortcuts)

4. Double-click `tushar_launcher.ahk` to start

### Option 2: Build from Source

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

To create a portable distribution:

```bash
cd src-tauri
cargo build --release
```

The `target/release/tushar.exe` is fully portable and requires no installation.

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

