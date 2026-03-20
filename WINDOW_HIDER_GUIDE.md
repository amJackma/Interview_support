# Tushar - Window Hider Implementation Guide

## Overview
Your Tauri project now includes window-hiding functionality similar to Invisiwind. This allows users to hide specific windows from screen captures (for screen sharing on Zoom, Teams, etc.) while still being able to interact with them normally.

## What Was Added

### Backend (Rust)

#### New Module: `src-tauri/src/window_hider.rs`
This module provides the core functionality for hiding/unhiding windows using Windows API.

**Key Functions:**
- `get_all_windows() -> Result<Vec<WindowInfo>, String>` - Lists all visible windows with their HWND handles
- `hide_window(hwnd: u64) -> HideWindowResponse` - Hides a window from screen captures
- `unhide_window(hwnd: u64) -> HideWindowResponse` - Restores a window to normal visibility in captures

**Key Types:**
```rust
pub struct WindowInfo {
    pub hwnd: u64,           // Window handle (can be used to hide/unhide)
    pub title: String,       // Window title shown to user
    pub is_hidden: bool,     // Current hidden state
}

pub struct HideWindowResponse {
    pub success: bool,
    pub message: String,
}
```

#### Updated: `src-tauri/src/lib.rs`
Added three new Tauri commands:

1. **`get_windows`** - Retrieves list of all visible windows
   ```rust
   #[tauri::command]
   fn get_windows() -> Result<Vec<WindowInfo>, String>
   ```

2. **`hide_selected_window`** - Hides a specific window from capture
   ```rust
   #[tauri::command]
   fn hide_selected_window(hwnd: u64) -> HideWindowResponse
   ```

3. **`unhide_selected_window`** - Restores a hidden window
   ```rust
   #[tauri::command]
   fn unhide_selected_window(hwnd: u64) -> HideWindowResponse
   ```

#### Updated: `src-tauri/Cargo.toml`
Added dependencies:
- `windows = "0.54"` - For Windows API bindings
- `parking_lot = "0.12"` - For thread-safe mutex operations

### How It Works

The implementation uses Windows API's `SetWindowDisplayAffinity` function:
- Sets the `WDA_EXCLUDEFROMCAPTURE` flag (value 17) to hide windows from capture
- Sets `WINDOW_DISPLAY_AFFINITY(0)` to restore normal visibility
- Maintains a list of visible windows by calling `EnumWindows`

## Using From Frontend

### Example TypeScript Usage

```typescript
import { invoke } from "@tauri-apps/api/core";

// Get list of windows
const windows = await invoke("get_windows") as Array<{hwnd: number, title: string, is_hidden: boolean}>;

// Hide a window
const result = await invoke("hide_selected_window", { hwnd: window_handle });

// Unhide a window
const result = await invoke("unhide_selected_window", { hwnd: window_handle });
```

### Example HTML UI

```html
<div>
  <h2>Window Hider</h2>
  <button onclick="loadWindows()">Refresh Windows</button>
  <ul id="window-list"></ul>
</div>

<script>
async function loadWindows() {
  const windows = await invoke("get_windows");
  const list = document.getElementById("window-list");
  list.innerHTML = "";
  
  for (const win of windows) {
    const li = document.createElement("li");
    li.innerHTML = `
      ${win.title}
      <button onclick="hideWindow(${win.hwnd})">Hide</button>
      <button onclick="showWindow(${win.hwnd})">Show</button>
    `;
    list.appendChild(li);
  }
}

async function hideWindow(hwnd) {
  const result = await invoke("hide_selected_window", { hwnd });
  console.log(result);
  loadWindows();
}

async function showWindow(hwnd) {
  const result = await invoke("unhide_selected_window", { hwnd });
  console.log(result);
  loadWindows();
}
</script>
```

## Building & Running

### Development
```bash
# In the project root
npm run tauri dev
```

### Build for Release
```bash
npm run tauri build
```

## Platform Support

- **Windows**: Full support (Windows 10 v2004 or above)
- **macOS/Linux**: Not supported (compile time feature gates in place)

## Important Notes

1. **Windows 10 v2004+**: The feature requires Windows 10 version 2004 or later
2. **Screen Sharing**: This hides windows from screen captures, allowing you to share your screen without showing sensitive windows
3. **No Automatic Re-hiding**: If new instances of an application start, they are NOT automatically hidden
4. **Ongoing Access**: You can still interact with hidden windows normally; only the screen capture is affected

## Building & Testing

The code has been tested with `cargo check` and compiles without warnings. To build:

```bash
cd src-tauri
cargo build --release
```

## Future Enhancements

Consider adding:
1. A hotkey system to hide/unhide windows (like Ctrl+J in Invisiwind)
2. Persistent settings to remember which windows should be hidden
3. AutoHotkey script integration for hotkey support
4. Better UI to display windows with icons/thumbnails

---

**Version**: 1.0  
**Built for**: Tushar Tauri Project  
**Based on**: Invisiwind concept by radiantly
