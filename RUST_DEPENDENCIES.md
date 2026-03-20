# Tushar Rust Dependencies

This file documents all Rust crates used in the `src-tauri` backend.

## Summary

- **Total Direct Dependencies**: 8
- **Core Framework**: Tauri 2.x
- **Platform Specific**: Windows API bindings
- **Concurrency**: parking_lot mutex
- **Edition**: 2021

---

## Core Dependencies

### tauri@2
- **Purpose**: Desktop application framework
- **Features**: None (default Tauri features)
- **Usage**: Main framework for IPC, window management, system tray
- **Docs**: https://tauri.app/
- **GitHub**: https://github.com/tauri-apps/tauri

### tauri-plugin-opener@2
- **Purpose**: Plugin to open URLs and files
- **Features**: Default
- **Usage**: System integration for opening links/files
- **GitHub**: https://github.com/tauri-apps/plugins-workspace

### serde@1
- **Purpose**: Serialization/deserialization framework
- **Features**: `derive` - Procedural macros for serializing
- **Usage**: Serialize Rust structs to JSON for IPC
- **Example**:
  ```rust
  #[derive(Serialize, Deserialize)]
  pub struct WindowInfo {
      pub hwnd: u64,
      pub title: String,
  }
  ```
- **Docs**: https://serde.rs/
- **Crates.io**: https://crates.io/crates/serde

### serde_json@1
- **Purpose**: JSON support for Serde
- **Usage**: JSON parsing and generation for Tauri commands
- **Example**:
  ```rust
  let json = serde_json::json!({ "key": "value" });
  ```
- **Crates.io**: https://crates.io/crates/serde_json

### parking_lot@0.12
- **Purpose**: More efficient parking lot-based mutex
- **Features**: Default
- **Usage**: Thread-safe WINDOW_LIST storage
- **Why**: Faster and smaller than std::sync::Mutex
- **Comparison**:
  ```rust
  // Using parking_lot
  static WINDOW_LIST: OnceLock<Mutex<Vec<WindowInfo>>> = OnceLock::new();
  ```
- **Crates.io**: https://crates.io/crates/parking_lot

---

## Build Dependencies

### tauri-build@2
- **Purpose**: Build-time configuration for Tauri
- **Location**: `[build-dependencies]`
- **Usage**: Runs in `build.rs` to set up Tauri context
- **Docs**: https://tauri.app/

---

## Platform-Specific Dependencies

### windows@0.54 (Windows only)
- **Purpose**: Safe Rust bindings to Windows API
- **Platform**: Only compiled on Windows target (`target.'cfg(windows)'`)
- **Features Used**:
  - `Win32_Foundation` - Core types (HWND, LPARAM, BOOL, etc.)
  - `Win32_System_Memory` - Memory management APIs
  - `Win32_UI_WindowsAndMessaging` - Window and message APIs
    - `EnumWindows` - Enumerate all windows
    - `IsWindowVisible` - Check if window is visible
    - `GetWindowTextA` - Get window title
    - `SetWindowDisplayAffinity` - Hide window from capture
    - `WINDOW_DISPLAY_AFFINITY` - Enum for display affinity

- **Version**: 0.54 (recent stable)
- **Benefits**:
  - Type-safe Windows API
  - No unsafe code needed for bindings
  - Auto-generated from Windows SDK
  - Minimal binary size overhead

- **Example Usage**:
  ```rust
  use windows::Win32::UI::WindowsAndMessaging::SetWindowDisplayAffinity;
  
  unsafe {
      SetWindowDisplayAffinity(hwnd, WINDOW_DISPLAY_AFFINITY(17))?;
  }
  ```

- **Crates.io**: https://crates.io/crates/windows
- **Docs**: https://microsoft.github.io/windows-docs-rs/

---

## Dependency Tree

```
tushar (workspace)
├── src-tauri/
│   └── tushar@0.1.0
│       ├── [Dependencies]
│       │   ├── tauri@2
│       │   ├── tauri-plugin-opener@2
│       │   ├── serde@1 { features = ["derive"] }
│       │   ├── serde_json@1
│       │   └── parking_lot@0.12
│       │
│       ├── [Build Dependencies]
│       │   └── tauri-build@2
│       │
│       └── [Windows-Specific Dependencies]
│           └── windows@0.54 { features = [...] }
│
└── [Transitive Dependencies]
    ├── tokio (async runtime)
    ├── serde_json (JSON)
    ├── napi (Node-like APIs)
    └── ... (many others auto-resolved by Cargo)
```

---

## Version Overview

| Crate | Version | Status | Notes |
|-------|---------|--------|-------|
| tauri | 2.x | ✅ Stable | Latest stable 2.x |
| tauri-plugin-opener | 2.x | ✅ Stable | Matches Tauri version |
| tauri-build | 2.x | ✅ Stable | Must match tauri version |
| serde | 1.0 | ✅ Stable | De facto standard |
| serde_json | 1.0 | ✅ Stable | Works with serde |
| parking_lot | 0.12 | ✅ Stable | Recent update-to-date |
| windows | 0.54 | ✅ Stable | Frequent updates |

---

## Building & Compilation

### Development Build
```bash
cd src-tauri
cargo build          # Unoptimized, fastest compile
cargo check          # Type check only, very fast
```

### Release Build
```bash
cd src-tauri
cargo build --release     # Optimized, slower compile
```

### Clean Build
```bash
cd src-tauri
cargo clean          # Removes target/ folder
cargo build          # Rebuilds everything
```

### Update Dependencies
```bash
cd src-tauri
cargo update         # Updates to latest within version constraints
cargo outdated       # Shows what can be updated
```

---

## Adding New Dependencies

### From Command Line
```bash
cd src-tauri
cargo add serde_json     # Add with default features
cargo add -F features crate_name  # Add with specific features
```

### Manually in Cargo.toml
```toml
[dependencies]
new-crate = "1.0"
another-crate = { version = "2.0", features = ["feature1", "feature2"] }

[target.'cfg(windows)'.dependencies]
platform-specific = "1.0"
```

### After Adding
```bash
cargo check         # Verify it compiles
cargo build --release  # Full build
```

---

## Common Operations

### Lock Dependencies
All are pinned in `Cargo.lock` - commit this file!
```bash
git add Cargo.lock
git commit
```

### Check Unused Dependencies
```bash
cargo install cargo-udeps
cargo +nightly udeps
```

### Check Compilation Time
```bash
cargo build --timings
```

### Update All Dependencies Carefully
```bash
cd src-tauri
cargo update
cargo test
cargo build --release
```

---

## Security Considerations

- Dependencies are from official crates.io registry
- `Cargo.lock` ensures reproducible builds
- All dependencies are open-source (MIT/Apache2)
- No unsafe code in dependencies (except windows crate which handles it)

### Security Audit
```bash
cd src-tauri
cargo audit         # Check for known vulnerabilities
```

---

## Feature Flags

### tauri - No Features
```toml
tauri = { version = "2", features = [] }
```

To enable features:
```toml
tauri = { version = "2", features = ["cli", "system-tray", "updater"] }
```

### windows - Selective Bindings
```toml
windows = { version = "0.54", features = [
    "Win32_Foundation",
    "Win32_System_Memory",
    "Win32_UI_WindowsAndMessaging",
] }
```

Only including needed features keeps binary size small and improves compile time.

---

## Documentation Links

| Crate | Docs | Repo |
|-------|------|------|
| tauri | [tauri.app](https://tauri.app/) | [GitHub](https://github.com/tauri-apps/tauri) |
| serde | [serde.rs](https://serde.rs/) | [GitHub](https://github.com/serde-rs/serde) |
| parking_lot | [crates.io](https://crates.io/crates/parking_lot) | [GitHub](https://github.com/amanieu/parking_lot) |
| windows | [microsoft.github.io](https://microsoft.github.io/windows-docs-rs/) | [GitHub](https://github.com/microsoft/windows-rs) |

---

## Troubleshooting

### "Failed to build windows crate"
- Ensure Visual C++ Build Tools are installed
- Run: `rustup update`

### "Dependency not found"
- Run: `cargo update`
- Delete `Cargo.lock` and rebuild

### "Link error on Windows"
- Install Windows SDK development headers
- Reinstall Visual Studio Build Tools

---

**Last Updated**: 2026-03-19  
**Edition**: 2021  
**Total Direct Dependencies**: 8  
**MSRV (Minimum Supported Rust Version)**: 1.70.0
