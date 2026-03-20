# Tushar Node.js Dependencies

This file documents all Node.js/npm dependencies used in the Tushar project.

## Summary

- **Total Packages**: 19
- **Development Dependencies**: 3
- **Production Dependencies**: 2
- **Build Tool**: Vite 6.4.1
- **Frontend Framework**: Tauri 2.x

---

## Production Dependencies

These are required at runtime:

### @tauri-apps/api@^2
- **Version**: 2.x
- **Purpose**: Core Tauri API for invoking Rust commands from TypeScript
- **Usage**: Import main bridge between frontend and backend
- **GitHub**: https://github.com/tauri-apps/tauri/tree/dev/packages/api

### @tauri-apps/plugin-opener@^2
- **Version**: 2.x
- **Purpose**: Plugin to open URLs and files using system defaults
- **Usage**: Open external links in default browser
- **GitHub**: https://github.com/tauri-apps/plugins-workspace/tree/v2/plugins/opener

---

## Development Dependencies

These are required during development and building:

### @tauri-apps/cli@^2
- **Version**: 2.x
- **Purpose**: Command-line interface for Tauri development
- **Commands**:
  - `npm run tauri dev` - Start development environment
  - `npm run tauri build` - Build for production
- **GitHub**: https://github.com/tauri-apps/tauri/tree/dev/packages/cli

### vite@^6.0.3
- **Version**: 6.4.1 (installed)
- **Purpose**: Frontend build tool and dev server
- **Configuration**: `vite.config.ts`
- **Port**: 1420 (development)
- **Features**:
  - Lightning-fast HMR (Hot Module Replacement)
  - TypeScript support out-of-box
  - Optimized build output
- **Docs**: https://vitejs.dev

### typescript@~5.6.2
- **Version**: 5.6.2 (installed)
- **Purpose**: TypeScript language and compiler
- **Configuration**: `tsconfig.json`
- **Features**:
  - Type checking for `.ts` files
  - Type inference
  - Strict mode support
- **Docs**: https://www.typescriptlang.org/

---

## Dependency Tree

```
tushar@0.1.0
├── Production Dependencies (2)
│   ├── @tauri-apps/api@^2
│   └── @tauri-apps/plugin-opener@^2
│
└── Development Dependencies (3)
    ├── @tauri-apps/cli@^2
    ├── vite@^6.0.3
    └── typescript@~5.6.2

Total: 19 packages (including transitive dependencies)
```

---

## Installation & Updates

### Install All Dependencies
```bash
npm install
```

### Update Dependencies
```bash
npm update
```

### Check for Outdated Packages
```bash
npm outdated
```

### Audit Security Vulnerabilities
```bash
npm audit
npm audit fix  # Auto-fix vulnerabilities
```

### Current Audit Status
```
✅ 0 vulnerabilities found
✅ 7 packages interested in funding (run 'npm fund' for details)
```

---

## Version Compatibility

| Package | Current | Range | Status |
|---------|---------|-------|--------|
| @tauri-apps/api | 2.x | ^2 | ✅ Stable |
| @tauri-apps/plugin-opener | 2.x | ^2 | ✅ Stable |
| @tauri-apps/cli | 2.x | ^2 | ✅ Stable |
| vite | 6.4.1 | ^6.0.3 | ✅ Latest |
| typescript | 5.6.2 | ~5.6.2 | ✅ Fixed |

---

## Updating Major Versions

To update to next major versions (use with caution):

```bash
# Update Tauri to next major (3.x, when available)
npm install @tauri-apps/api@latest
npm install @tauri-apps/cli@latest
npm install @tauri-apps/plugin-opener@latest

# Then rebuild
npm run tauri build
```

---

## Common Tasks

### Install a New Package
```bash
npm install package-name
npm install -D package-name  # As dev dependency
```

### Remove a Package
```bash
npm uninstall package-name
```

### Clean Install (nuke node_modules)
```bash
rm -r node_modules package-lock.json
npm install
```

---

## Transitive Dependencies

The 19 total packages include transitive dependencies. Major ones:

- **esbuild** - Fast JavaScript bundler (used by Vite)
- **TypeScript compiler libs** - Type definitions
- **Tauri runtime libraries** - Communication and APIs

All are managed automatically by npm.

---

## Security Notes

- All dependencies are from official npm registry
- No vulnerable packages detected (last checked: 2026-03-19)
- Dependencies are pinned to specific versions in package-lock.json
- Regular security audits recommended: `npm audit`

---

## More Information

- **npm docs**: https://docs.npmjs.com/
- **Tauri docs**: https://tauri.app/
- **Vite docs**: https://vitejs.dev/
- **TypeScript docs**: https://www.typescriptlang.org/docs/

---

**Last Updated**: 2026-03-19  
**Total Packages**: 19  
**Security Status**: ✅ Safe
