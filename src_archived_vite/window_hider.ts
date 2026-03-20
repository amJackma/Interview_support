import { invoke } from "@tauri-apps/api/core";

interface WindowInfo {
  hwnd: number;
  title: string;
  is_hidden: boolean;
}

interface HideResponse {
  success: boolean;
  message: string;
}

let windowsData: WindowInfo[] = [];

// Load and display all windows
async function loadWindows() {
  try {
    windowsData = (await invoke("get_windows")) as WindowInfo[];
    displayWindows();
  } catch (error) {
    console.error("Failed to load windows:", error);
    const listEl = document.querySelector("#window-list");
    if (listEl) {
      listEl.textContent = "Error loading windows: " + error;
    }
  }
}

// Display windows in the UI
function displayWindows() {
  const listEl = document.querySelector("#window-list");
  if (!listEl) return;

  if (windowsData.length === 0) {
    listEl.innerHTML = "<p>No windows found</p>";
    return;
  }

  listEl.innerHTML = windowsData
    .map(
      (win) => `
    <div class="window-item">
      <div class="window-title">${escapeHtml(win.title)}</div>
      <div class="window-handle">Handle: ${win.hwnd}</div>
      <div class="window-actions">
        <button onclick="hideWindow(${win.hwnd})" class="btn btn-hide">Hide from Screenshot</button>
        <button onclick="unhideWindow(${win.hwnd})" class="btn btn-show">Show in Screenshot</button>
      </div>
    </div>
  `
    )
    .join("");
}

// Hide a specific window
async function hideWindow(hwnd: number) {
  try {
    const response = (await invoke("hide_selected_window", {
      hwnd,
    })) as HideResponse;

    if (response.success) {
      showNotification("✓ " + response.message, "success");
    } else {
      showNotification("✗ " + response.message, "error");
    }
    loadWindows();
  } catch (error) {
    showNotification("Error: " + error, "error");
  }
}

// Show a specific window
async function unhideWindow(hwnd: number) {
  try {
    const response = (await invoke("unhide_selected_window", {
      hwnd,
    })) as HideResponse;

    if (response.success) {
      showNotification("✓ " + response.message, "success");
    } else {
      showNotification("✗ " + response.message, "error");
    }
    loadWindows();
  } catch (error) {
    showNotification("Error: " + error, "error");
  }
}

// Show notification
function showNotification(message: string, type: "success" | "error") {
  const notif = document.createElement("div");
  notif.className = `notification notification-${type}`;
  notif.textContent = message;

  const container = document.querySelector("#notifications");
  if (container) {
    container.appendChild(notif);
    setTimeout(() => {
      notif.remove();
    }, 3000);
  }
}

// Escape HTML to prevent XSS
function escapeHtml(text: string): string {
  const map: { [key: string]: string } = {
    "&": "&amp;",
    "<": "&lt;",
    ">": "&gt;",
    '"': "&quot;",
    "'": "&#039;",
  };
  return text.replace(/[&<>"']/g, (m) => map[m]);
}

// Initialize when DOM is ready
window.addEventListener("DOMContentLoaded", () => {
  const refreshBtn = document.querySelector("#refresh-btn");
  if (refreshBtn) {
    refreshBtn.addEventListener("click", loadWindows);
  }
  // Load windows immediately
  loadWindows();
  // Auto-refresh windows every 2 seconds for real-time tabs display
  setInterval(loadWindows, 2000);
});

// Make functions global for onclick handlers
(window as any).hideWindow = hideWindow;
(window as any).unhideWindow = unhideWindow;
(window as any).loadWindows = loadWindows;
