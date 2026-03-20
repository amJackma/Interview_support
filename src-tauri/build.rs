fn main() {
    // Build tauri resources
    tauri_build::build();

    // Windows icon compilation
    if cfg!(target_os = "windows") {
        let mut resources = winresource::WindowsResource::new();
        resources.set_icon("icons/invicon.ico");
        resources.compile().expect("Failed to compile Windows resources");
    }
}
