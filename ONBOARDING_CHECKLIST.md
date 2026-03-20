# Developer Onboarding Checklist

Use this checklist when setting up a new development environment for the Tushar project.

---

## ✅ Pre-Setup (5 minutes)

- [ ] Read the project README
- [ ] Understand the purpose (Window Hider for screen sharing)
- [ ] Review architecture: Rust backend + TypeScript frontend
- [ ] Check your system specs (Windows 10 v2004+, 2GB RAM free)

---

## ✅ System Setup (15 minutes)

### Downloads & Installation
- [ ] **Node.js with npm** 
  - Download: https://nodejs.org/
  - Verify: `node --version` (should be v18.17.0+)
  - Verify: `npm --version` (should be v9.0.0+)

- [ ] **Rust & Cargo**
  - Download: https://rustup.rs/
  - Run: `irm https://rustup.rs | iex` (PowerShell)
  - Verify: `rustc --version` (should be 1.70.0+)

- [ ] **Visual C++ Build Tools**
  - Download: https://visualstudio.microsoft.com/downloads/
  - Install: "Desktop development with C++"
  - Restart terminal after install

### System Verification
- [ ] `node --version` outputs v18.17.0+
- [ ] `npm --version` outputs v9.0.0+
- [ ] `rustc --version` outputs 1.70.0+
- [ ] `cargo --version` outputs latest
- [ ] Visual C++ tools installed (test: `cargo check` in any Rust project)

---

## ✅ Project Setup (10 minutes)

### Clone/Download Project
```bash
# If cloning from Git
git clone [repository-url] d:\try\tushar
cd d:\try\tushar
```

### Automated Setup (Recommended)
```powershell
# Run the setup script
.\setup.bat

# Wait for completion - should show "✅ Setup Complete!"
```

**OR** Manual Setup:
- [ ] `npm install` - Install frontend dependencies (2 min)
- [ ] `cd src-tauri && cargo check` - Build backend (3 min)
- [ ] `cd ..` - Return to project root

### Verify Setup
- [ ] `node_modules` directory exists
- [ ] `src-tauri/target/debug/` directory exists
- [ ] No error messages in console
- [ ] `npm run tauri --version` works

---

## ✅ IDE Setup (5 minutes)

### Visual Studio Code (Recommended)
- [ ] Download & install: https://code.visualstudio.com/
- [ ] Open the project folder

### Essential Extensions (install in order)
- [ ] **Rust Analyzer** (`rust-lang.rust-analyzer`)
  - Search in VS Code extensions
  - Click Install
  - Wait for activation (check status bar)

- [ ] **Tauri** (`tauri-apps.tauri`)
  - Tauri-specific commands and templates

- [ ] **Prettier** (`esbenp.prettier-vscode`)
  - Automatic code formatting
  - Optional: `npm install -D prettier`

- [ ] **Thunder Client** (`rangav.vscode-thunder-client`)
  - Test API endpoints

### IDE Verification
- [ ] VS Code opens without errors
- [ ] Extensions appear in sidebar
- [ ] Rust Analyzer shows status (check bottom bar)
- [ ] No red squiggly errors in `.ts` files
- [ ] No red squiggly errors in `src-tauri/src/lib.rs`

---

## ✅ First Run (5 minutes)

### Start Development Server
```bash
# From project root (d:\try\tushar)
npm run tauri dev
```

### Expected Output
- [ ] Console shows "VITE v6.x.x ready"
- [ ] Console shows "Building [====>]"
- [ ] Rust compilation completes without errors
- [ ] Window app opens and displays

### Test Basic Functionality
- [ ] Application window opens
- [ ] Page loads without errors
- [ ] Can see the UI
- [ ] No console errors (F12 to check)

### First App Run Success Check
```
✅ You see the Tushar window app running
✅ Frontend is served by Vite at http://localhost:1420
✅ Backend Rust is compiled and running
✅ Ready to start developing!
```

---

## ✅ Project Structure Understanding (10 minutes)

- [ ] Understand why files are split into `src/` (frontend) and `src-tauri/` (backend)
- [ ] Read: `WINDOW_HIDER_GUIDE.md` - Understand the feature
- [ ] Read: `IMPLEMENTATION_SUMMARY.md` - Understand what was built
- [ ] Run: `npm run tauri dev` and explore the app

---

## ✅ Development Workflow Setup (10 minutes)

### File Organization
- [ ] Understand: `src/` = TypeScript/HTML/CSS (frontend)
- [ ] Understand: `src-tauri/src/` = Rust code (backend)
- [ ] Understand: `src-tauri/Cargo.toml` = Rust dependencies

### Common Commands
- [ ] Test: `npm run tauri dev` - Start dev environment
- [ ] Test: `npm run tauri build` - Create release build
- [ ] Test: `cd src-tauri && cargo check` - Type check backend
- [ ] Bookmark: `DEPENDENCIES.md` for quick reference

### Git Setup (if using Git)
- [ ] Create a feature branch
- [ ] Make a small test change (e.g., update UI text)
- [ ] Test the change: `npm run tauri dev`
- [ ] Commit, push, create PR (if applicable)

---

## ✅ Documentation Review (15 minutes)

Read these files in order:

1. **REQUIREMENTS.md** (5 min)
   - [ ] System requirements
   - [ ] Global tools needed
   - [ ] Current setup verified

2. **DEPENDENCIES.md** (5 min)
   - [ ] Bookmark for reference
   - [ ] Understand quick setup
   - [ ] Know troubleshooting steps

3. **WINDOW_HIDER_GUIDE.md** (5 min)
   - [ ] Understand the feature
   - [ ] Know how APIs work
   - [ ] See code examples

---

## ✅ Security & Environment (5 minutes)

### Git Verification
- [ ] `.gitignore` includes `node_modules/`
- [ ] `.gitignore` includes `src-tauri/target/`
- [ ] `.gitignore` includes `Cargo.lock` (or tracked if shared)
- [ ] No secrets in tracked files

### Safety Checks
- [ ] Run: `npm audit` - Check for vulnerabilities (should show ✅)
- [ ] Run: `cd src-tauri && cargo audit` - Check Rust deps
- [ ] Understand: Never commit `node_modules/` or `target/`

---

## ✅ Team Handoff (5 minutes)

- [ ] Understand team communication channels
- [ ] Know who to ask for help
- [ ] Understand code review process
- [ ] Know branch/PR naming conventions
- [ ] Understand deployment process

---

## ✅ Quick Troubleshooting (If Needed)

**Everything stuck?**
- [ ] Read: **REQUIREMENTS.md** -> Troubleshooting section
- [ ] Read: **DEPENDENCIES.md** -> Troubleshooting section
- [ ] Try: `npm install && cd src-tauri && cargo check`
- [ ] Try: `.\setup.bat` to reset environment

**Specific Issues:**
- [ ] "vite is not recognized" → Run `npm install`
- [ ] "cargo not found" → Restart terminal
- [ ] "Build tools not found" → Install Visual C++
- [ ] "Module not found" → Run `npm install`

---

## ✅ Success Criteria Checklist

You're **ready to develop** when:

- [ ] ✅ System has Node.js, npm, Rust, Cargo
- [ ] ✅ Project folder has `node_modules/` and builds without errors
- [ ] ✅ `npm run tauri dev` opens an app window
- [ ] ✅ VS Code has Rust Analyzer and Tauri extensions
- [ ] ✅ You've read the main documentation files
- [ ] ✅ You understand the project architecture
- [ ] ✅ You know how to run/build the project
- [ ] ✅ You know how to ask for help
- [ ] ✅ You've made and tested a small change
- [ ] ✅ Security checks pass (`npm audit`, `cargo audit`)

---

## 📞 Next Steps After Onboarding

1. **Ask for assignment**: Get your first task from the team
2. **Create a branch**: `git checkout -b feature/your-feature`
3. **Make changes**: Update `src/` or `src-tauri/src/` as needed
4. **Test locally**: `npm run tauri dev`
5. **Commit & push**: Push to your branch
6. **Create PR**: Open a pull request for code review
7. **Iterate**: React to feedback and update
8. **Merge**: Team merges when approved

---

## 📋 Onboarding Completion

**Date Started**: _______________  
**Date Completed**: _______________  
**Mentor/Point Person**: _______________  

**Sign-off**: By checking below, you confirm:
- [ ] All checks above completed
- [ ] Development environment working
- [ ] Can run `npm run tauri dev` successfully
- [ ] Ready to start development work
- [ ] Contact person identified for questions

---

## 📚 Quick Reference

### Important Files to Bookmark
- **REQUIREMENTS.md** - System setup
- **DEPENDENCIES.md** - Dependency lookup
- **WINDOW_HIDER_GUIDE.md** - API reference
- **NODE_DEPENDENCIES.md** - Frontend deps
- **RUST_DEPENDENCIES.md** - Backend deps

### Common Commands
```bash
npm run tauri dev           # Start dev
npm run tauri build         # Build for release
npm install                 # Install deps
npm run dev                 # Frontend only
cd src-tauri && cargo check # Check backend
npm audit                   # Security check
```

### Key Directories
- **src/** - Frontend TypeScript/HTML/CSS
- **src-tauri/src/** - Backend Rust code
- **src-tauri/target/** - Build artifacts (auto-generated)
- **node_modules/** - npm dependencies (auto-generated)

### Quick Troubleshooting
1. Read relevant docs
2. Run `npm install` or `cargo clean && cargo check`
3. Restart terminal and IDE
4. Ask the team!

---

**🎉 Welcome to the Tushar Project! Good luck!**

Last Updated: 2026-03-19
