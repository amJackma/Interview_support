use clap::{Parser, Subcommand};
use windows::Win32::Foundation::{HWND, LPARAM};
use windows::Win32::UI::WindowsAndMessaging::*;
use std::error::Error;

#[derive(Parser)]
#[command(about = "Lightweight window hiding tool", long_about = None)]
struct Args {
    #[command(subcommand)]
    command: Commands,
}

#[derive(Subcommand)]
enum Commands {
    /// Hide a window by PID
    Hide {
        /// Process ID of the window to hide
        #[arg(value_name = "PID")]
        pid: u32,
    },
    /// Show a hidden window by PID
    Unhide {
        /// Process ID of the window to show
        #[arg(value_name = "PID")]
        pid: u32,
    },
}

unsafe extern "system" fn enum_windows_callback(hwnd: HWND, lparam: LPARAM) -> windows::Win32::Foundation::BOOL {
    let pid = lparam.0 as u32;
    
    let mut window_pid = 0u32;
    let _ = GetWindowThreadProcessId(hwnd, Some(&mut window_pid));
    
    if window_pid == pid {
        let _ = ShowWindow(hwnd, SW_HIDE);
        return windows::Win32::Foundation::BOOL(0);
    }
    
    windows::Win32::Foundation::BOOL(1)
}

unsafe extern "system" fn enum_windows_unhide_callback(hwnd: HWND, lparam: LPARAM) -> windows::Win32::Foundation::BOOL {
    let pid = lparam.0 as u32;
    
    let mut window_pid = 0u32;
    let _ = GetWindowThreadProcessId(hwnd, Some(&mut window_pid));
    
    if window_pid == pid {
        let _ = ShowWindow(hwnd, SW_SHOW);
        return windows::Win32::Foundation::BOOL(0);
    }
    
    windows::Win32::Foundation::BOOL(1)
}

fn hide_window(pid: u32) -> Result<(), Box<dyn Error>> {
    unsafe {
        EnumWindows(Some(enum_windows_callback), LPARAM(pid as isize))?;
    }
    println!("Window for PID {} hidden successfully", pid);
    Ok(())
}

fn unhide_window(pid: u32) -> Result<(), Box<dyn Error>> {
    unsafe {
        EnumWindows(Some(enum_windows_unhide_callback), LPARAM(pid as isize))?;
    }
    println!("Window for PID {} shown successfully", pid);
    Ok(())
}

fn main() -> Result<(), Box<dyn Error>> {
    let args = Args::parse();
    
    match args.command {
        Commands::Hide { pid } => hide_window(pid)?,
        Commands::Unhide { pid } => unhide_window(pid)?,
    }
    
    Ok(())
}

