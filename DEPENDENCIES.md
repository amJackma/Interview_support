# Tushar - Dependency Quick Reference

## 🎯 Quick Setup (5 minutes)

```powershell
# 1. Check requirements (from REQUIREMENTS.md)
node --version          # Should be v18.17.0+
cargo --version         # Should be 1.70.0+

# 2. Install dependencies
npm install             # ~30 seconds
cd src-tauri && cargo check  # ~2 minutes

# 3. Run development
cd .. && npm run tauri dev   # ~45 seconds to startup
```

---

## ✅ Dependency Checklist

### System Requirements
- [ ] Windows 10 v2004+ (or Windows 11)
- [ ] Visual C++ Build Tools 2019+
- [ ] 2GB free disk space minimum

### Node.js/npm
- [ ] Node.js v18.17.0+ installed
- [ ] npm v9.0.0+ installed
- [ ] `npm install` completed (19 packages)

### Rust
- [ ] Rust 1.70.0+ installed
- [ ] Cargo package manager working
- [ ] `cargo check` passes without errors

### Tauri
- [ ] Tauri CLI installed: `npm install -g @tauri-apps/cli`
- [ ] `npm run tauri --version` works

### Project Setup
- [ ] `node_modules/` directory exists
- [ ] `src-tauri/target/debug/` built
- [ ] No errors in `cargo check`

---

## 📦 All Dependencies at a Glance

### Frontend (Node.js)
```json
{
  "dependencies": {
    "@tauri-apps/api": "^2",
    "@tauri-apps/plugin-opener": "^2"
  },
  "devDependencies": {
    "@tauri-apps/cli": "^2",
    "vite": "^6.0.3",
    "typescript": "~5.6.2"
  }
}
```

### Backend (Rust Crates)
```toml
[dependencies]
tauri = "2"
tauri-plugin-opener = "2"
serde = { version = "1", features = ["derive"] }
serde_json = "1"
parking_lot = "0.12"

[build-dependencies]
tauri-build = "2"

[target.'cfg(windows)'.dependencies]
windows = { version = "0.54", features = [
    "Win32_Foundation",
    "Win32_System_Memory",
    "Win32_UI_WindowsAndMessaging",
] }
```

---

## 🚀 Common Commands

### Development
```bash
npm run tauri dev          # Start dev server + app
npm run dev                # Vite only (frontend)
cd src-tauri && cargo check  # Only check backend
```

### Building
```bash
npm run tauri build        # Full optimized build
cd src-tauri && cargo build --release  # Backend only
```

### Maintenance
```bash
npm install                # Install/update deps
npm audit                  # Check security
npm outdated               # Check for updates
cd src-tauri && cargo update  # Update Rust deps
```

---

## 🔍 Verify Installation

Run this checklist:

```bash
# Node.js (Frontend)
node --version             # ✅ v18.17.0 or higher
npm --version              # ✅ v9.0.0 or higher
npm list vite              # ✅ vite@6.x.x
npm list @tauri-apps/cli   # ✅ @tauri-apps/cli@2.x.x

# Rust (Backend)
rustc --version            # ✅ 1.70.0 or higher
cargo --version            # ✅ latest
cd src-tauri
cargo check                # ✅ No errors
cd ..

# Project
npm run tauri --version    # ✅ Shows version
npm list                   # ✅ No missing packages
```

**If all pass**: ✅ Ready to develop!

---

## 📋 Dependency Graph

```
Tushar App
├── Frontend (Node.js)
│   ├── Vite (build tool)
│   ├── TypeScript (language)
│   ├── @tauri-apps/api (IPC bridge)
│   └── @tauri-apps/plugin-opener (URL opener)
│
└── Backend (Rust)
    ├── Tauri framework
    │   ├── serde (serialization)
    │   └── serde_json (JSON)
    ├── parking_lot (threading)
    └── Windows APIs
        ├── EnumWindows
        ├── SetWindowDisplayAffinity
        └── GetWindowTextA
```

---

## 🛠️ Troubleshooting Dependencies

### Issue: "vite is not recognized"
**Solution**: `npm install && npm run dev`

### Issue: "cargo not found"
**Solution**: Restart terminal + `rustup update`

### Issue: "Cannot find module"
**Solution**: `npm install`

### Issue: "Windows build tools not found"
**Solution**: Download from https://visualstudio.microsoft.com/downloads/
Install: "Desktop development with C++"

### Issue: "cargo check fails"
**Solution**:
```bash
cd src-tauri
cargo clean
cargo check
```

---

## 🎓 Documentation Index

| File | Purpose | Audience |
|------|---------|----------|
| **REQUIREMENTS.md** | System + global requirements | Everyone |
| **NODE_DEPENDENCIES.md** | Frontend npm packages | Frontend devs |
| **RUST_DEPENDENCIES.md** | Backend Rust crates | Rust devs |
| **setup.bat** | Automated setup script | Windows users |
| **IMPLEMENTATION_SUMMARY.md** | Feature overview | Product team |
| **WINDOW_HIDER_GUIDE.md** | API reference | API users |

---

## 🔐 Security Notes

### Dependency Security
- ✅ All from official registries (npm, crates.io)
- ✅ No known vulnerabilities (verified with `npm audit`)
- ✅ Locked versions in `Cargo.lock` and `package-lock.json`
- ✅ Regular updates recommended (check: `npm outdated`)

### Best Practices
1. Keep dependencies updated: `npm update`
2. Run security audits: `npm audit`
3. Review changes before major updates
4. Test after updating: `npm run tauri dev`

---

## 📊 Dependency Sizes

| Component | Count | Size | Load Time |
|-----------|-------|------|-----------|
| npm packages | 19 | ~200MB (node_modules) | - |
| Rust (debug) | 8 | ~500MB (target/debug) | 23.78s |
| Final binary | 1 | ~5-10MB | instant |

*Note: node_modules and target/ are in `.gitignore`*

---

## 🔄 Updating Dependencies

### Safe Update (patch versions)
```bash
npm update           # Updates within version ranges
cd src-tauri && cargo update
```

### Major Update (breaking changes - test thoroughly!)
```bash
npm install @tauri-apps/cli@3  # Example: Tauri 3 (when available)
npm run tauri build
npm run tauri dev
```

---

## 📝 Adding New Dependencies

### Frontend
```bash
npm install package-name
npm install -D dev-dependency  # Dev only
```

### Backend
```bash
cd src-tauri
cargo add package-name
cargo add --build build-dependency
```

Don't forget to commit `Cargo.lock` and `package-lock.json`!

---

## 🎯 Version Targets

| Component | Recommended | Minimum | Latest |
|-----------|-------------|---------|--------|
| Node.js | 20.x LTS | 18.17.0 | 22.x |
| npm | 10.x | 9.0.0 | Latest |
| Rust | Latest | 1.70.0 | Latest |
| Windows | 11 | 10 v2004 | Latest |

---

**Created**: 2026-03-19  
**Project**: Tushar Window Hider  
**Status**: ✅ All Dependencies Verified
