-- Variables used across the configuration

local M = {}

-- Programs
M.hyprpm      = "hyprpm reload -n"
M.terminal    = "wezterm start --always-new-process"
M.editor      = "emacs"
M.fileManager = "dolphin"
M.browser     = "flatpak run com.brave.Browser"
M.menuDaemon  = "vicinae server"
M.menu        = "vicinae toggle"
M.polkit      = "/usr/lib/polkit-kde-authentication-agent-1"
M.idleDaemon  = ""
M.screenShot  = "flameshot"
M.statusBar   = "noctalia"

return M
