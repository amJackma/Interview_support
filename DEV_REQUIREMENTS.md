# Development Requirements - Optional Tools

This file documents optional tools that enhance the development experience.

---

## 📝 Recommended IDE & Extensions

### Visual Studio Code (Recommended)
**Download**: https://code.visualstudio.com/

#### Essential Extensions
1. **Rust Analyzer** (`rust-lang.rust-analyzer`)
   - Advanced Rust language support
   - Go to definition, refactoring, inline docs
   - Essential for backend development

2. **Tauri** (`tauri-apps.tauri`)
   - Tauri project templates
   - Build/run commands
   - Project scaffolding

3. **TypeScript Vue Plugin** (`vue.vscode-typescript-vue-plugin`)
   - TypeScript support in Vue files
   - Type checking

4. **Prettier** (`esbenp.prettier-vscode`)
   - Code formatting
   - Setup: `npm install -D prettier`
   - Auto-format on save

5. **ESLint** (`dbaeumer.vscode-eslint`)
   - Code linting
   - Setup: `npm install -D eslint`

6. **Thunder Client** or **REST Client**
   - Test Tauri API endpoints
   - Make HTTP requests directly in editor

#### Helpful Extensions
- **Git Graph** - Git visualization
- **Thunder Client** - REST API testing
- **Better Comments** - Comment highlighting
- **Todo Tree** - Track TODOs in code

---

## 🔨 Development Tools

### Build & Compilation
```bash
# Already installed via npm
npm run tauri dev        # Dev build with hot reload
npm run tauri build      # Production release build
npm run build            # Frontend only
npm run preview          # Preview production build
```

### Code Quality

#### Linting (Optional)
```bash
npm install -D eslint @typescript-eslint/eslint-plugin
# Configure: .eslintrc.json
npm run lint
```

#### Formatting (Optional)
```bash
npm install -D prettier
# Configure: .prettierrc
npm run format
npm run format:check
```

#### Type Checking
```bash
npx tsc --noEmit       # Check types without building
```

---

## 🧪 Testing Tools (Optional)

### Frontend Testing
```bash
# Install Vitest (recommended for Vite)
npm install -D vitest @vitest/ui

# Run tests
npm run test
npm run test:ui        # UI dashboard
```

### Rust Testing
```bash
cd src-tauri
cargo test             # Run all tests
cargo test -- --nocapture  # Show output
```

---

## 📊 Profiling & Optimization

### Build Time Analysis
```bash
cd src-tauri
cargo build --timings  # See where time is spent
```

### Bundle Size Analysis
```bash
npm install -D vite-plugin-visualization
# Add to vite.config.ts, then build and open report
```

### Memory/CPU Profiling
- Use Chrome DevTools when running `npm run tauri dev`
- Press F12 in the app window

---

## 🐛 Debugging Tools

### Rust Debugging
```bash
cd src-tauri
cargo build
# Launch debugger in VS Code (requires CodeLLDB extension)
```

### LLDB Debugger
```bash
# Windows
# Install via Visual Studio or download from llvm.org
# Configure in VS Code: CodeLLDB extension
```

### Frontend Debugging
```bash
# DevTools in app window
F12                    # Open developer tools
Ctrl+Shift+I          # Alternative shortcut
```

### Logging & Tracing
```bash
# Rust logging (optional)
cargo add tracing tracing-subscriber
```

---

## 📚 Documentation Tools

### Generating Docs (Optional)
```bash
# Rust documentation
cd src-tauri
cargo doc --open

# TypeScript/JavaScript docs
npm install -D typedoc
npx typedoc --out docs src/
```

---

## 🚀 CI/CD & Automation

### GitHub Actions (Optional)
Create `.github/workflows/build.yml`:
```yaml
name: Build
on: [push, pull_request]
jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions-rs/toolchain@v1
      - uses: actions/setup-node@v3
      - run: npm install
      - run: npm run tauri build
```

### Local Automation
```bash
# pre-commit hook for code quality
npm install -D husky lint-staged
npx husky install
```

---

## 📦 Package Management

### npm Scripts Customization
Add to `package.json`:
```json
{
  "scripts": {
    "lint": "eslint src/",
    "format": "prettier --write \"src/**/*.{ts,tsx}\"",
    "type-check": "tsc --noEmit",
    "test": "vitest",
    "precommit": "npm run lint && npm run type-check"
  }
}
```

---

## 🔍 Monitoring & Analytics (Optional)

### Performance Monitoring
```bash
npm install -D @tauri-apps/plugin-window
# Add window performance tracking
```

### Crash Reporting (Optional)
```bash
npm install -D @tauri-apps/plugin-updater
# Automatic crash reporting
```

---

## 🔐 Security Tools

### Dependency Auditing
```bash
npm audit              # Find vulnerabilities
npm audit fix          # Auto-fix if possible

cd src-tauri
cargo audit            # Rust vulnerability check
```

### SBOM Generation (Optional)
```bash
npm install -D @cyclonedx/cyclonedx-npm
npx cyclonedx-npm -o sbom.xml
```

---

## 📋 Installation Checklist for Full Dev Setup

```bash
# Core (required)
npm install
cd src-tauri && cargo check

# Code Quality (recommended)
npm install -D eslint prettier typescript
npm install -D @typescript-eslint/eslint-plugin

# Testing (optional)
npm install -D vitest @vitest/ui

# Documentation (optional)
npm install -D typedoc

# VS Code Extensions (recommended)
# - Rust Analyzer
# - Tauri
# - Prettier
# - ESLint
# - Thunder Client
```

---

## 🎓 Learning Resources

### For Rust
- [The Rust Book](https://doc.rust-lang.org/book/)
- [Tauri Docs](https://tauri.app/)
- [Cargo Book](https://doc.rust-lang.org/cargo/)

### For TypeScript
- [TypeScript Handbook](https://www.typescriptlang.org/docs/)
- [Vite Guide](https://vitejs.dev/guide/)

### For Windows API
- [Windows API Documentation](https://learn.microsoft.com/en-us/windows/win32/apiindex/windows-api-list)
- [windows-rs Docs](https://microsoft.github.io/windows-docs-rs/)

---

## 🆚 Comparison: Essential vs Full Setup

| Feature | Essential | Recommended | Full |
|---------|-----------|-------------|------|
| Build | ✅ | ✅ | ✅ |
| Dev Server | ✅ | ✅ | ✅ |
| Linting | ❌ | ✅ | ✅ |
| Formatting | ❌ | ✅ | ✅ |
| Testing | ❌ | ⭐ | ✅ |
| Debugging | ❌ | ✅ | ✅ |
| Profiling | ❌ | ❌ | ✅ |
| CI/CD | ❌ | ❌ | ✅ |

---

## 📝 Quick Setup Commands

### Essential Setup (2 min)
```bash
npm install
cd src-tauri && cargo check
npm run tauri dev
```

### Recommended Setup (5 min)
```bash
npm install
npm install -D eslint prettier @typescript-eslint/eslint-plugin
cd src-tauri && cargo check
npm run tauri dev
```

### Full Dev Setup (10 min)
```bash
npm install
npm install -D eslint prettier vitest @vitest/ui typedoc
cd src-tauri && cargo check
# Install VS Code extensions (takes a few seconds each)
npm run tauri dev
```

---

## 🆘 Troubleshooting Optional Tools

### "ESLint not working"
```bash
npm install -D eslint
npm install -D @typescript-eslint/eslint-plugin @typescript-eslint/parser
npx eslint --init
```

### "Prettier conflicts with ESLint"
```bash
npm install -D eslint-config-prettier eslint-plugin-prettier
# Add to .eslintrc.json: "prettier"
```

### "Tests not running"
```bash
npm install -D vitest
npx vitest
```

---

**Last Updated**: 2026-03-19  
**Scope**: Optional development tools and configurations  
**Maintenance**: Update as new tools become available
