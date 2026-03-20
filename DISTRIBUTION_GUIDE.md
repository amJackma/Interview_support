# Tushar .exe Distribution & Deployment Guide

This guide explains how to build and distribute your Tushar Window Hider application to other systems.

---

## 🎯 Quick Overview

| Method | File | Size | Installation | Best For |
|--------|------|------|--------------|----------|
| **Portable** | `tushar.exe` | ~10MB | Copy & run | Quick testing, USB drive |
| **Installer** | `tushar.exe` (MSI/NSIS) | ~15MB | Run installer | End users, distribution |
| **Release Build** | `tushar.exe` | ~5-10MB | Manual deployment | Direct distribution |

---

## 📦 Step 1: Build Release .exe

### Build for Production

```bash
# From project root (d:\try\tushar)
npm run tauri build
```

**What this does**:
- Compiles Rust backend in release mode (optimized)
- Bundles TypeScript frontend
- Creates installer and portable versions
- Generates signing certificates (if needed)

### Build Time
- First build: 2-3 minutes (slow)
- Subsequent builds: 30-60 seconds (cached)

---

## 📂 Output Locations

After building, your files are here:

### Windows Release Builds
```
src-tauri/target/release/
├── tushar.exe                    # Standalone executable
├── bundle/
│   ├── msi/
│   │   └── Tushar_1.0.0_x64.msi # Windows installer
│   ├── nsis/
│   │   └── Tushar_1.0.0_x64.exe # NSIS installer
│   └── nsis/
│       └── Tushar-1.0.0-setup.exe
└── ...
```

### Find the Files
```powershell
# List all built executables
Get-ChildItem -Path "src-tauri\target\release\bundle\" -Recurse -Filter "*.exe" -o File

# Find the main exe
Get-ChildItem -Path "src-tauri\target\release\tushar.exe"
```

---

## 🚀 Option 1: Standalone .exe (Easiest)

### Copy the Executable
```
src-tauri/target/release/tushar.exe
```

### To Run on Another System

**Requirements on target machine:**
- Windows 10 v2004 or later (or Windows 11)
- Nothing else needs to be installed!

**Steps:**
1. Copy `tushar.exe` to any folder on the target machine
2. Right-click → "Run as Administrator" (may be needed for window APIs)
3. Application launches instantly

### Create a Zip for Distribution
```powershell
# Create portable package
$files = @("src-tauri\target\release\tushar.exe")
Compress-Archive -Path $files -DestinationPath "Tushar-Portable.zip"

# Send Tushar-Portable.zip to users
# Users just extract and double-click tushar.exe
```

### Shareware Distribution
```
Distribution Steps:
1. Copy tushar.exe to USB drive
2. Send a download link to tushar.exe
3. Share in a cloud folder (Google Drive, OneDrive, etc.)
4. Users run directly with no installation
```

---

## 📦 Option 2: Installer (MSI) - Recommended for Users

### Located At
```
src-tauri/target/release/bundle/msi/
├── Tushar_1.0.0_x64.msi
└── Tushar_1.0.0_x64.exe (NSIS alternative)
```

### To Run on Another System

**Requirements on target machine:**
- Windows 10 v2004 or later
- Admin rights to install (usually required)
- ~50MB free disk space

**Steps:**
1. Send `Tushar_1.0.0_x64.msi` to users
2. Users double-click the MSI file
3. Standard Windows installer wizard appears
4. Users click "Next" → "Install"
5. Application installed to: `C:\Program Files\Tushar\`
6. Desktop shortcut and Start Menu entry created
7. Launch from Start Menu or desktop icon

### MSI Installer Advantages
- ✅ Standard Windows installation process
- ✅ Creates shortcuts (desktop + Start Menu)
- ✅ Easy uninstall via "Add or Remove Programs"
- ✅ Can be deployed via Group Policy (enterprise)
- ✅ Installation path tracked in registry

---

## 🔥 Option 3: NSIS Installer (Alternative)

### Located At
```
src-tauri/target/release/bundle/nsis/
├── Tushar-1.0.0-setup.exe
└── Tushar Setup 1.0.0.exe
```

### Similar to MSI
- Standard Windows installer wizard
- Creates shortcuts and registry entries
- Users run setup and click "Next"
- Slightly smaller file size than MSI

---

## 📋 Distribution Checklist for Each Method

### ✅ For Portable .exe
- [ ] File size: ~10MB
- [ ] Name: `tushar.exe`
- [ ] Location: `src-tauri/target/release/`
- [ ] Works on: Windows 10 v2004+, Windows 11
- [ ] No installation needed
- [ ] Can be run directly or from USB

### ✅ For MSI Installer
- [ ] File size: ~15MB
- [ ] Name: `Tushar_1.0.0_x64.msi`
- [ ] Location: `src-tauri/target/release/bundle/msi/`
- [ ] Works on: Windows 10 v2004+, Windows 11
- [ ] Installs to: `C:\Program Files\Tushar\`
- [ ] Creates shortcuts
- [ ] Can be uninstalled

### ✅ For NSIS Installer
- [ ] File size: ~12-15MB
- [ ] Name: `Tushar-1.0.0-setup.exe`
- [ ] Location: `src-tauri/target/release/bundle/nsis/`
- [ ] Works on: Windows 10 v2004+, Windows 11
- [ ] Similar install process to MSI

---

## 🖥️ System Requirements for Target Machine

### Minimum Requirements
```
OS:       Windows 10 v2004 or later
          (Windows 11 recommended)
RAM:      2GB (512MB minimum to run)
Storage:  50MB free disk space
          (100MB during installation)
```

### NOT Required on Target Machine
- ❌ Node.js
- ❌ Rust
- ❌ Visual C++ Build Tools
- ❌ Python
- ❌ Any development tools

Everything is bundled in the .exe!

---

## 🔗 Distribution Methods

### Method 1: Direct File Copy
```powershell
# Copy to external drive
Copy-Item -Path "src-tauri\target\release\tushar.exe" `
          -Destination "E:\Tushar\tushar.exe"

# User: Connects drive, double-clicks tushar.exe
```

### Method 2: Email
```
Subject: Tushar Window Hider Application

Attached: tushar.exe (10MB)

To use:
1. Download tushar.exe
2. Right-click → Run as Administrator
3. Done!
```

### Method 3: Cloud Storage
```
- Upload tushar.exe to Google Drive
- Generate shareable link
- Send link to users
- Users download and run
```

### Method 4: GitHub Releases
```bash
# Create a release on GitHub
# Upload tushar.exe or .msi
# Users download from releases page
# Versions tracked and durable
```

### Method 5: Windows Store (Advanced)
```
(Optional future enhancement)
- Package as appx
- Submit to Microsoft Store
- Users install from Store app
```

---

## 🔍 Verify Before Distribution

### Test the Executable
```powershell
# Test on current machine
.\src-tauri\target\release\tushar.exe

# Should:
# ✅ Launch window app
# ✅ Show UI interface
# ✅ Respond to clicks
# ✅ Close cleanly
```

### Test on Another Machine (Before Distribution)
1. Copy .exe to a test machine (USB or network)
2. Run it with different user accounts
3. Test with admin and non-admin
4. Verify all features work
5. Check error messages are helpful

### Antivirus Considerations
```
⚠️ Note: Some antivirus software may flag .exe files
   This is normal for downloaded executables

Solutions:
- Create digital signature (code signing certificate)
- Submit to antivirus vendors for whitelisting
- Provide users installation instructions
- Use trusted distribution channels (official website)
```

---

## 🔄 Different Versions & Architectures

### 64-bit vs 32-bit
Your current build is:
```
x64 (64-bit) - Modern Windows systems
```

For 32-bit support, build with:
```bash
npm run tauri build -- --target x86
```

### Versioning
The .exe includes the version from `Cargo.toml`:
```toml
[package]
version = "0.1.0"  # Shows as "1.0.0" in MSI/About
```

Update version before building:
```toml
version = "1.0.0"  # Users see this version
```

---

## 💾 File Size Optimization

### Current Sizes
- Release .exe: ~10MB
- MSI Installer: ~15MB
- NSIS Installer: ~12MB

### To Reduce Size
```bash
# Build with size optimizations
cd src-tauri
cargo build --release --opt-level z  # Maximum compression
```

### Size Comparison
```
Development build:   ~500MB (includes symbols, not for distribution)
Release build:       ~10MB (optimized, ready to distribute)
Minimal executable:  ~5MB (if all features removed)
```

---

## 🔐 Security Notes for Distribution

### Before Sharing the .exe

- [ ] **Test thoroughly** - Run it yourself first
- [ ] **Check for malware** - Scan with antivirus before sharing
- [ ] **Verify functionality** - All features work as expected
- [ ] **Document requirements** - Include Windows version info
- [ ] **Provide support** - Include error reporting instructions

### User Safety

When distributing, include:
```
System Requirements:
- Windows 10 version 2004 or later
- At least 2GB of RAM
- 50MB free disk space

Installation:
1. Download tushar.exe
2. Right-click → Run as Administrator
3. Follow the wizard (if using installer)

Support:
- For issues, see [WINDOW_HIDER_GUIDE.md]
- Contact: [your-email@example.com]
```

---

## 📋 Deployment Workflow

### For Users (End-to-End)

**Step 1: Get the File**
- Download from provided link
- Copy from USB drive
- Receive via email

**Step 2: Run the Application**
```
Option A (Standalone):
✓ Double-click tushar.exe
✓ App launches immediately

Option B (Installer):
✓ Double-click Tushar-1.0.0-setup.exe
✓ Follow wizard
✓ Click Finish
✓ Launch from Start Menu
```

**Step 3: Use the Application**
- Open the app
- See list of windows
- Click "Hide from Screenshot"
- Start screen sharing
- Hidden windows won't appear in capture

**Step 4: Uninstall (if needed)**
```
For standalone:
- Delete tushar.exe (no cleanup needed)

For installer:
- Settings → Apps → Apps & features
- Find "Tushar Window Hider"
- Click "Uninstall"
- Confirm
```

---

## 🎁 Create a Distribution Package

### Folder Structure
```
Tushar-v1.0.0/
├── tushar.exe                          # Portable version
├── Tushar_1.0.0_x64.msi               # Installer version
├── README.md                           # Quick start
├── SYSTEM_REQUIREMENTS.txt             # Requirements
└── SUPPORT.txt                         # Support info
```

### Compress for Distribution
```powershell
# Create zip file
Compress-Archive -Path "Tushar-v1.0.0" -DestinationPath "Tushar-v1.0.0.zip"

# Result: Tushar-v1.0.0.zip (~15-20MB)
```

---

## 📊 Distribution Comparison

| Aspect | Standalone .exe | MSI Installer | NSIS |
|--------|-----------------|---------------|------|
| **File Size** | ~10MB | ~15MB | ~12MB |
| **Installation** | None (just run) | Wizard | Wizard |
| **Shortcuts** | Manual or none | Automatic | Automatic |
| **Uninstall** | Delete file | Add/Remove Programs | Add/Remove Programs |
| **Admin Rights** | Optional | Usually required | Usually required |
| **Best For** | Testing, USB, direct share | Enterprise, end users | Alternative to MSI |
| **User Experience** | Fastest | Standard Windows | Standard Windows |

---

## 🚀 Quick Start for Distribution

### Build Step
```bash
npm run tauri build
```

### Choose Distribution Method

**Quick Testing:**
```
→ Share: src-tauri/target/release/tushar.exe
→ Users: Double-click to run
```

**Professional Distribution:**
```
→ Share: src-tauri/target/release/bundle/msi/Tushar_1.0.0_x64.msi
→ Users: Run installer → Done
```

**Both Options:**
```
→ Share: Both files
→ Users: Choose portable (.exe) or installer (.msi)
```

---

## ✅ Pre-Distribution Checklist

Before sending to users:

- [ ] `npm run tauri build` completed successfully
- [ ] Tested .exe on current machine
- [ ] Tested on another machine (if possible)
- [ ] Verified version number in Cargo.toml
- [ ] Confirmed Windows 10 v2004+ requirement
- [ ] Tested all window-hiding features
- [ ] No console errors when running
- [ ] File size reasonable (~10-15MB)
- [ ] Antivirus scan passed
- [ ] Documentation updated with version number
- [ ] Support contact information ready

---

## 📞 Common Distribution Questions

### Q: Can users run it without admin rights?
**A:** Usually yes, but may be required for some window APIs. Include "Run as Administrator" in instructions.

### Q: Do they need to install anything first?
**A:** No! Everything is bundled. No Node.js, Rust, or build tools needed.

### Q: How do I update the application?
Build a new version, increment version number in Cargo.toml, rebuild, and distribute the new .exe.

### Q: Can it run on Windows 7/8?
**A:** No, requires Windows 10 v2004 or later.

### Q: What if antivirus blocks it?
**A:** Normal for unsigned executables. Users can click "Allow" or "Run anyway". Consider code signing for professional distribution.

### Q: Can I put it on a USB drive?
**A:** Yes! Copy tushar.exe to USB, users plug in, double-click, it runs.

---

## 📝 Sample README for Users

Create `README.txt` or `README.md` with:

```
TUSHAR WINDOW HIDER v1.0.0
===========================

SYSTEM REQUIREMENTS:
- Windows 10 version 2004 or later
- Windows 11 (recommended)
- 2GB RAM minimum
- Administrator access (recommended)

INSTALLATION:
Option 1 - Portable (No Installation)
1. Double-click tushar.exe
2. Application launches immediately

Option 2 - Install
1. Double-click Tushar_1.0.0_x64.msi
2. Follow the installation wizard
3. Click Finish
4. Launch from Start Menu or desktop shortcut

USING THE APP:
1. Open Tushar Window Hider
2. Click "Refresh Windows List"
3. Select windows you want to hide
4. Click "Hide from Screenshot"
5. Start your screen share (Zoom, Teams, etc.)
6. Hidden windows won't appear in your capture

SUPPORT:
- For issues, see WINDOW_HIDER_GUIDE.md
- Contact: support@example.com

UNINSTALL:
- Portable: Delete tushar.exe
- Installed: Settings → Apps → Remove Tushar Window Hider
```

---

**Last Updated**: 2026-03-19  
**Version**: 1.0.0  
**Status**: Ready for Distribution
