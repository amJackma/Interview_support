#[cfg(target_os = "windows")]
use windows::Win32::Foundation::HWND;
#[cfg(target_os = "windows")]
use windows::Win32::UI::WindowsAndMessaging::{
    EnumWindows, IsWindowVisible, GetWindowTextA, SetWindowDisplayAffinity,
    WINDOW_DISPLAY_AFFINITY,
};
use serde::{Deserialize, Serialize};
use std::ffi::CStr;
use parking_lot::Mutex;
use std::sync::OnceLock;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct WindowInfo {
    pub hwnd: u64,
    pub title: String,
    pub is_hidden: bool,
}

#[derive(Debug, Serialize, Deserialize)]
pub struct HideWindowResponse {
    pub success: bool,
    pub message: String,
}

#[cfg(target_os = "windows")]
static WINDOW_LIST: OnceLock<Mutex<Vec<WindowInfo>>> = OnceLock::new();

#[cfg(target_os = "windows")]
fn get_window_list() -> &'static Mutex<Vec<WindowInfo>> {
    WINDOW_LIST.get_or_init(|| Mutex::new(Vec::new()))
}

#[cfg(target_os = "windows")]
unsafe extern "system" fn enum_window_proc(hwnd: HWND, _lparam: windows::Win32::Foundation::LPARAM) -> windows::Win32::Foundation::BOOL {
    use windows::Win32::Foundation::TRUE;
    
    if IsWindowVisible(hwnd).as_bool() {
        let mut title_bytes = [0u8; 256];
        let len = GetWindowTextA(hwnd, &mut title_bytes);
        
        let title = if len > 0 {
            match CStr::from_bytes_until_nul(&title_bytes[..len as usize + 1]) {
                Ok(c_str) => c_str.to_string_lossy().to_string(),
                Err(_) => String::from("[Invalid UTF-8]"),
            }
        } else {
            String::from("[No Title]")
        };

        if !title.is_empty() && title != "[No Title]" {
            let window_info = WindowInfo {
                hwnd: hwnd.0 as u64,
                title,
                is_hidden: false,
            };
            get_window_list().lock().push(window_info);
        }
    }
    
    TRUE
}

#[cfg(target_os = "windows")]
pub fn get_all_windows() -> Result<Vec<WindowInfo>, String> {
    let list = get_window_list();
    let mut lock = list.lock();
    lock.clear();
    
    unsafe {
        let result = EnumWindows(Some(enum_window_proc), windows::Win32::Foundation::LPARAM(0));
        
        if result.is_err() {
            return Err("Failed to enumerate windows".to_string());
        }
    }

    Ok(lock.clone())
}

#[cfg(target_os = "windows")]
pub fn hide_window(hwnd: u64) -> HideWindowResponse {
    let hwnd = HWND(hwnd as isize);
    
    // Try to set the window display affinity to exclude from capture
    unsafe {
        match SetWindowDisplayAffinity(hwnd, WINDOW_DISPLAY_AFFINITY(17)) {
            Ok(_) => {
                HideWindowResponse {
                    success: true,
                    message: "Window hidden successfully".to_string(),
                }
            }
            Err(e) => {
                HideWindowResponse {
                    success: false,
                    message: format!("Failed to hide window: {:?}", e),
                }
            }
        }
    }
}

#[cfg(target_os = "windows")]
pub fn unhide_window(hwnd: u64) -> HideWindowResponse {
    let hwnd = HWND(hwnd as isize);
    
    // Set the window display affinity back to normal
    unsafe {
        match SetWindowDisplayAffinity(hwnd, WINDOW_DISPLAY_AFFINITY(0)) {
            Ok(_) => {
                HideWindowResponse {
                    success: true,
                    message: "Window unhidden successfully".to_string(),
                }
            }
            Err(e) => {
                HideWindowResponse {
                    success: false,
                    message: format!("Failed to unhide window: {:?}", e),
                }
            }
        }
    }
}

#[cfg(not(target_os = "windows"))]
pub fn get_all_windows() -> Result<Vec<WindowInfo>, String> {
    Err("This feature is only available on Windows".to_string())
}

#[cfg(not(target_os = "windows"))]
pub fn hide_window(_hwnd: u64) -> HideWindowResponse {
    HideWindowResponse {
        success: false,
        message: "This feature is only available on Windows".to_string(),
    }
}

#[cfg(not(target_os = "windows"))]
pub fn unhide_window(_hwnd: u64) -> HideWindowResponse {
    HideWindowResponse {
        success: false,
        message: "This feature is only available on Windows".to_string(),
    }
}
