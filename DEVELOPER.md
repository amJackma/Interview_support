# Developer Documentation

## Project Setup

### Prerequisites

- **Rust** - [Install from rustup.rs](https://rustup.rs/)
- **Windows 10+** - 64-bit system
- **Visual Studio Build Tools** or **Visual Studio Community** (for linking)
- **AutoHotkey v2** (for testing the launcher)
- **Inno Setup** (for building installers) - [Download](https://jrsoftware.org/isdl.php)

### Initial Setup

```bash
# Clone the repository
git clone https://github.com/amJackma/tushar.git
cd tushar

# Build the project
cd src-tauri
cargo build          # Debug build
cargo build --release  # Optimized release build
```

## Project Structure

```
tushar/
├── .git/                    # Git repository
├── .gitignore              # Git ignore rules
├── .vscode/                # VS Code settings
├── README.md               # Project overview
├── INSTALLATION_GUIDE.md   # User installation guide
├── DEVELOPER.md            # This file
├── tushar_installer.iss    # Inno Setup script
├── build_installer.bat     # Installer build script
│
├── releases/
│   ├── v2.0.0/             # Release binaries
│   │   ├── tushar.exe
│   │   └── tushar_launcher.ahk
│   └── installer/          # Compiled installers
│
├── src-tauri/
│   ├── .cargo/
│   │   └── config.toml     # Cargo configuration
│   ├── build.rs            # Build script (icon compilation)
│   ├── Cargo.toml          # Dependencies manifest
│   ├── Cargo.lock          # Dependency lock file
│   │
│   ├── src/
│   │   └── main.rs         # CLI implementation
│   │
│   ├── tushar_launcher.ahk # AutoHotkey launcher
│   │
│   ├── icons/              # Application icons
│   │   ├── invicon.ico     # Windows icon
│   │   ├── icon.png        # 512x512 icon
│   │   └── ... (other sizes)
│   │
│   ├── capabilities/       # Tauri security (legacy)
│   ├── gen/                # Generated schemas (legacy)
│   └── target/             # Build output
│       ├── debug/          # Debug builds
│       └── release/        # Release builds
│
└── src_archived_vite/      # Old Tauri+TypeScript code (deprecated)
```

## Building

### Debug Build (Fast, for development)

```bash
cd src-tauri
cargo build
```

**Output:** `src-tauri/target/debug/tushar.exe` (~4-5 MB)

**Pros:** Fast compilation, full debugging symbols  
**Cons:** Larger file, slower execution  

### Release Build (Optimized, for distribution)

```bash
cd src-tauri
cargo build --release
```

**Output:** `src-tauri/target/release/tushar.exe` (~980 KB)

**Pros:** Minimal size, optimal performance, stripped symbols  
**Cons:** Slower compilation, no debug info  

### Rebuild Dependency Cache

```bash
cd src-tauri
cargo clean        # Remove all build artifacts
cargo build --release
```

## Code Overview

### Main CLI (`src-tauri/src/main.rs`)

The project is a simple Rust CLI with two commands:

```rust
Commands::Hide { pid }    // Hide window by process ID
Commands::Unhide { pid }  // Show window by process ID
```

**Key components:**
- `clap` - Command-line argument parsing
- `windows` crate - Windows API bindings
- `EnumWindows` - Enumerate all windows
- `ShowWindow` - Show/hide windows

### AutoHotkey Launcher (`src-tauri/tushar_launcher.ahk`)

Simple hotkey script for easy window hiding:

```ahk
^j::                    # CTRL+J → Hide
^k::                    # CTRL+K → Show
^q::                    # CTRL+Q → Exit
```

## Development Workflow

### 1. Making Changes

```bash
# Edit source code
code src-tauri/src/main.rs

# Test the changes
cd src-tauri
cargo run -- hide 1234    # Test hide command
cargo run -- unhide 1234  # Test unhide command
```

### 2. Testing

```bash
cd src-tauri

# Run tests (if any)
cargo test

# Check for issues without building
cargo check

# Lint and format
cargo clippy              # Linting
cargo fmt                 # Format code
```

### 3. Building Release

```bash
cd src-tauri

# Build optimized binary
cargo build --release

# Size check
ls -lh target/release/tushar.exe

# Verify it works
target/release/tushar.exe --help
```

### 4. Testing the AutoHotkey Launcher

```bash
# With the executable built, test the launcher
.\src-tauri\tushar_launcher.ahk

# Press CTRL+J to hide a window
# Press CTRL+K to show it
# Press CTRL+Q to exit
```

### 5. Building Installer

```bash
# Option 1: Use the automated script
.\build_installer.bat

# Option 2: Manual compilation
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" tushar_installer.iss

# Output: releases/installer/Tushar-2.0.0-Installer.exe
```

## Git Workflow

### First-time Setup

```bash
git clone https://github.com/amJackma/tushar.git
cd tushar
```

### Making Commits

```bash
# Check status
git status

# Stage changes
git add .

# Commit with descriptive message
git commit -m "Brief description of changes

Detailed explanation if needed:
- What changed
- Why it changed
- Any breaking changes"

# Push to remote
git push origin master
```

### Example Commits

```bash
# Bug fix
git commit -m "Fix window enumeration failure on Windows 11

- Handle edge case where hwnd is invalid
- Add additional debug logging

Fixes #42"

# Feature addition  
git commit -m "Add extended syntax support

New commands:
- hide-all: Hide all windows of an app
- show-all: Show all windows of an app

Note: Breaking change from -p to -pid"

# Maintenance
git commit -m "Update dependencies and optimize build

- Update windows crate to 0.55
- Enable LTO for smaller binary
- Reduce build time with parallel compilation"
```

## Dependencies

### Runtime Dependencies

| Crate | Version | Purpose |
|-------|---------|---------|
| `clap` | 4.5 | CLI argument parsing |
| `windows` | 0.54 | Windows API bindings |

### Build Dependencies

| Crate | Version | Purpose |
|-------|---------|---------|
| `winresource` | 0.1 | Compile .ico into .exe |

### Removed Dependencies

- `tauri` 2.0 - Big framework, not needed for CLI
- `tauri-plugin-opener` 2.0 - Unnecessary for window hiding
- `serde` + `serde_json` - Not used without Tauri
- TypeScript/Node.js ecosystem - Simplified to pure Rust CLI

## Troubleshooting

### Build fails with linker error

**Solution:** Install Visual Studio Build Tools via:
```bash
# Download from Microsoft
# Then navigate to installation
vs_buildtools.exe --add Microsoft.VisualStudio.Workload.VCTools
```

### Can't find Rust compiler

**Solution:** Reinstall Rust:
```bash
rustup update stable
rustup default stable
```

### AutoHotkey launcher fails

**Solution:** Install AutoHotkey v2:
```bash
# Download from https://www.autohotkey.com/v2/
# Run installer and restart
```

### Cargo build times are very slow

**Solution:** Use `cargo check` to verify without rebuilding:
```bash
cargo check  # ~1 second
cargo build  # ~30 seconds (if cache invalidated)
```

## Performance Targets

- **Binary Size:** < 1 MB (current: 980 KB) ✅
- **Compilation:** < 1 second from cache ✅
- **Start Time:** < 100ms ✅
- **Memory:** < 5 MB when running ✅

## Code Style

Follow Rust conventions:

```bash
# Format code
cargo fmt

# Fix common issues
cargo clippy --fix

# Check formatting
cargo fmt -- --check
```

## Adding New Features

### Example: Adding a new command

1. **Update CLI in `main.rs`:**
   ```rust
   #[derive(Subcommand)]
   enum Commands {
       Hide { pid: u32 },
       Unhide { pid: u32 },
       #[command(about = "List all hidden windows")]
       List,  // New command
   }
   ```

2. **Implement the functionality:**
   ```rust
   Commands::List => list_hidden_windows()?,
   ```

3. **Test it:**
   ```bash
   cargo run -- list
   ```

4. **Update documentation:**
   - Update README.md
   - Update INSTALLATION_GUIDE.md
   - Add commit message

5. **Commit:**
   ```bash
   git add .
   git commit -m "Add list command to show hidden windows"
   ```

## Release Process

### Creating a New Release

1. Update version in `src-tauri/Cargo.toml`:
   ```toml
   [package]
   version = "2.1.0"  # Increment version
   ```

2. Build release binary:
   ```bash
   cd src-tauri
   cargo build --release
   ```

3. Build installer:
   ```bash
   .\build_installer.bat
   ```

4. Create GitHub release:
   - Go to GitHub → Releases
   - Click "New release"
   - Tag: `v2.1.0`
   - Upload files:
     - `releases/v2.1.0/tushar.exe`
     - `releases/v2.1.0/tushar_launcher.ahk`
     - `releases/installer/Tushar-2.1.0-Installer.exe`

5. Commit and push:
   ```bash
   git add .
   git commit -m "Release v2.1.0"
   git push origin master
   ```

## Resources

- **Rust:** https://www.rust-lang.org/
- **Windows API:** https://microsoft.github.io/windows-docs-rs/
- **Clap CLI:** https://docs.rs/clap/
- **AutoHotkey v2:** https://www.autohotkey.com/v2/
- **Inno Setup:** https://jrsoftware.org/isinfo.php

## Contributing

See [README.md](README.md#contributing) for contribution guidelines.
