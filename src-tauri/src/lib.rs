mod window_hider;

use window_hider::{get_all_windows, hide_window, unhide_window, WindowInfo, HideWindowResponse};

// Learn more about Tauri commands at https://tauri.app/develop/calling-rust/
#[tauri::command]
fn greet(name: &str) -> String {
    format!("Hello, {}! You've been greeted from Rust!", name)
}

#[tauri::command]
fn get_windows() -> Result<Vec<WindowInfo>, String> {
    get_all_windows()
}

#[tauri::command]
fn hide_selected_window(hwnd: u64) -> HideWindowResponse {
    hide_window(hwnd)
}

#[tauri::command]
fn unhide_selected_window(hwnd: u64) -> HideWindowResponse {
    unhide_window(hwnd)
}

#[cfg_attr(mobile, tauri::mobile_entry_point)]
pub fn run() {
    tauri::Builder::default()
        .plugin(tauri_plugin_opener::init())
        .invoke_handler(tauri::generate_handler![
            greet,
            get_windows,
            hide_selected_window,
            unhide_selected_window
        ])
        .run(tauri::generate_context!())
        .expect("error while running tauri application");
}
