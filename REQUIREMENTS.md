# Tushar Project - System Requirements

## System Requirements

### Operating System
- **Windows 10** (v2004 or later) - **Required for window-hider feature**
- **Windows 11** - Fully supported
- macOS/Linux - Not fully supported (no window-hider feature)

### Runtime Requirements
- **Node.js**: v18.17.0 or later (includes npm v9.0.0+)
- **Rust**: 1.70.0 or later (via rustup)
- **Visual Studio Build Tools 2019 or later** (for Windows C++ toolchain compilation)

---

## Node.js Dependencies (Frontend)

### Development Dependencies
```
@tauri-apps/cli@^2
vite@^6.0.3
typescript@~5.6.2
```

### Runtime Dependencies
```
@tauri-apps/api@^2
@tauri-apps/plugin-opener@^2
```

**Install with:**
```bash
npm install
```

---

## Rust Dependencies (Backend)

### Core Dependencies
- **tauri** v2 - Desktop application framework
- **tauri-plugin-opener** v2 - Open URLs/files plugin
- **serde** v1 - JSON serialization
- **serde_json** v1 - JSON support
- **parking_lot** v0.12 - Thread-safe utilities

### Windows-Specific Dependencies
- **windows** v0.54 - Windows API bindings for:
  - `Win32_Foundation` - Core Win32 types
  - `Win32_System_Memory` - Memory management
  - `Win32_UI_WindowsAndMessaging` - Window and messaging APIs

### Build Dependencies
- **tauri-build** v2 - Tauri build scripts

**Install with:**
```bash
cd src-tauri
cargo build
```

---

## Global Tools Required

### For Development
```bash
# Node.js (includes npm)
npm --version  # Should be v9+

# Rust
rustc --version  # Should be 1.70.0+
cargo --version

# Tauri CLI
npm install -g @tauri-apps/cli@latest
```

### For Building
```bash
# Windows C++ Build Tools
# Download from: https://visualstudio.microsoft.com/downloads/
# Install "Desktop development with C++"
```

---

## Development Environment Setup

### 1. Install Node.js
- Download from https://nodejs.org/ (LTS recommended)
- Verify: `node --version` and `npm --version`

### 2. Install Rust
```powershell
# Windows PowerShell
irm https://rustup.rs | iex
```
- Verify: `rustc --version` and `cargo --version`

### 3. Install Visual C++ Build Tools
- Download: https://visualstudio.microsoft.com/downloads/
- Select: "Desktop development with C++"
- Install and restart

### 4. Clone/Setup Project
```bash
cd d:\try\tushar
npm install          # Install Node dependencies
cd src-tauri
cargo build          # Install Rust dependencies
cd ..
npm run tauri dev    # Start development
```

---

## Verification Checklist

Run these commands to verify everything is set up:

```bash
# Node.js
node --version          # v18.17.0 or later
npm --version           # v9.0.0 or later
npm list vite           # Should show vite installed
npm list @tauri-apps/cli  # Should show Tauri CLI

# Rust
rustc --version         # 1.70.0 or later
cargo --version         # Latest

# Tauri
npm run tauri --version # Should output version

# Project-specific
cd src-tauri
cargo check             # Should complete without errors
```

---

## Optional Tools

### For Better Development Experience
- **Visual Studio Code** - Recommended IDE
- **Rust Analyzer** (VSCode extension) - Rust language support
- **Tauri** (VSCode extension) - Tauri-specific tools
- **Dev Containers** (VSCode) - Isolated dev environment

---

## Quick Install Commands (Windows PowerShell)

```powershell
# 1. Install Node.js (if not already installed)
winget install OpenJS.NodeJS.LTS

# 2. Install Rust
irm https://rustup.rs | iex

# 3. Restart terminal and verify
node --version
cargo --version

# 4. Setup project
cd d:\try\tushar
npm install
cd src-tauri
cargo build

# 5. Run development
cd ..
npm run tauri dev
```

---

## Troubleshooting

### "vite is not recognized"
```bash
npm install
npm run dev
```

### "cargo not found"
- Restart your terminal after installing Rust
- Check Rust installation: `rustup --version`

### "Visual C++ Build Tools not found"
- Download from https://visualstudio.microsoft.com/downloads/
- Install "Desktop development with C++"
- Restart terminal and try again

### "Module not found in Tauri"
```bash
cd src-tauri
cargo check
```

---

## Production Build Requirements

To build for production/release:

```bash
npm run tauri build  # Builds optimized Rust + bundles frontend
```

**Output location:**
```
src-tauri/target/release/tushar.exe
```

**Size:** ~5-10MB (release binary)

---

## Version Compatibility Matrix

| Component | Version | Status |
|-----------|---------|--------|
| Node.js | 18.17.0+ | ✅ Required |
| npm | 9.0.0+ | ✅ Required |
| Rust | 1.70.0+ | ✅ Required |
| Tauri | 2.x | ✅ Current |
| Windows | 10 v2004+ | ✅ Minimum |
| TypeScript | 5.6.2 | ✅ Current |
| Vite | 6.0.3+ | ✅ Current |

---

**Last Updated**: 2026-03-19  
**Project**: Tushar Window Hider  
**Maintainer**: Tushar
