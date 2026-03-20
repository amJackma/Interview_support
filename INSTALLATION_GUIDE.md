# Tushar Installation Guide

## For End Users

### Option 1: Portable Version (No Installation)

**Fastest & simplest way to use Tushar:**

1. **Download files** from [releases/v2.0.0/](releases/v2.0.0/):
   - `tushar.exe` - Main application
   - `tushar_launcher.ahk` - Keyboard launcher

2. **Install AutoHotkey v2** (one-time):
   - Download from [autohotkey.com](https://www.autohotkey.com/v2/)
   - Run the installer
   - Restart your computer (recommended)

3. **Start using Tushar:**
   - Double-click `tushar_launcher.ahk`
   - Press `CTRL + J` to hide windows
   - Press `CTRL + K` to show them
   - Press `CTRL + Q` to exit

### Option 2: Windows Installer (Recommended)

**Step-by-step installation:**

1. **Download the installer:**
   - Get `Tushar-2.0.0-Installer.exe` from [releases/installer/](releases/installer/) (when compiled)

2. **Run the installer:**
   - Double-click `Tushar-2.0.0-Installer.exe`
   - Follow the setup wizard
   - Choose installation location (default: `C:\Program Files\Tushar`)

3. **Complete installation:**
   - Accept AutoHotkey v2 requirement dialog
   - Create desktop shortcut (optional)
   - Launch Tushar

4. **Key shortcuts:**
   - `CTRL + J` → Hide active window
   - `CTRL + K` → Show hidden windows  
   - `CTRL + Q` → Exit launcher

### System Requirements

- Windows 10 or later
- 64-bit system (x86_64)
- 2 MB free disk space
- AutoHotkey v2 (installed by setup wizard or manually)

### Uninstalling

**Windows Installer version:**
1. Go to Settings → Apps → Apps & features
2. Find "Tushar" in the list
3. Click Uninstall

**Portable version:**
- Simply delete the files

---

## For Developers

### Building the Installer

**Prerequisites:**
- [Inno Setup](https://jrsoftware.org/isdl.php) (free, community edition works)
- Visual Studio Build Tools (for Rust compilation)
- Rust toolchain

**Build steps:**

1. **Clone the repository:**
   ```bash
   git clone https://github.com/amJackma/tushar.git
   cd tushar
   ```

2. **Build the Rust binary:**
   ```bash
   cd src-tauri
   cargo build --release
   cd ..
   ```

3. **Compile the installer:**
   - Open Inno Setup IDE
   - File → Open → Select `tushar_installer.iss`
   - Build → Compile
   - Output goes to `releases/installer/Tushar-2.0.0-Installer.exe`

**Alternative: Command-line compilation**
```bash
"C:\Program Files (x86)\Inno Setup 6\ISCC.exe" tushar_installer.iss
```

### Installer Configuration

Edit `tushar_installer.iss` to customize:

```ini
#define MyAppName "Tushar"           # Application name
#define MyAppVersion "2.0.0"         # Version number
#define MyAppPublisher "amJackma"    # Your name/organization
#define MyAppURL "https://github.com/amJackma/tushar"  # Repository URL
```

### Distribution

**Publish releases:**
1. Build the installer (see above)
2. Create a GitHub Release
3. Upload `Tushar-2.0.0-Installer.exe` to the release
4. Share the download link

**Installer features:**
- ✅ Automatic AutoHotkey v2 requirement detection
- ✅ Desktop shortcut creation (optional)
- ✅ Start on login option (optional)
- ✅ Clean uninstall
- ✅ 64-bit Windows 10+ support

---

## Troubleshooting

### "tushar_launcher.ahk" won't run
- Install AutoHotkey v2 from [autohotkey.com](https://www.autohotkey.com/v2/)
- Restart Windows after installation
- Right-click script → "Run with AutoHotkey"

### "tushar.exe" not found error
- Verify both files are in the same directory
- Update the path in `tushar_launcher.ahk` if needed:
  ```ahk
  executable := "C:\path\to\tushar.exe"
  ```

### Keyboard shortcuts not working
- Check AutoHotkey is running (look for tray icon "H")
- Try running launcher as administrator
- Verify CTRL+J and CTRL+K aren't bound to other apps

### Installation fails
- Run installer as administrator
- Ensure 2 MB free disk space
- Disable antivirus temporarily (false positive)
- Check Windows 10+ is installed

---

## Support

- GitHub Issues: [github.com/amJackma/tushar/issues](https://github.com/amJackma/tushar/issues)
- Repo: [github.com/amJackma/tushar](https://github.com/amJackma/tushar)
