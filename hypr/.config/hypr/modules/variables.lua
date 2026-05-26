-- Shared variables

local M = {}

-- Programs
M.terminal       = "wezterm"
M.editor         = "emacs"
M.fileManager    = "dolphin"
M.browser        = "brave"
M.launcherDaemon = "vicinae server"
M.menu           = "vicinae toggle"
M.polkit         = "/usr/lib/polkit-kde-authentication-agent-1"
M.idleDaemon     = "swayidle"
M.screenShot     = "flameshot"

-- Main modifier
M.mainMod        = "ALT"

-- Status bar variables bindings
local dms = {
   cmd = "dms run",
   ipc = "dms ipc call",
}
local noctalia = {
   cmd = "qs -c noctalia-shell --no-duplicate",
   ipc = "qs -c noctalia-shell ipc call",
}

M.sb = {
   [dms.cmd] = {
      ["SUPER + S"]                  = dms.ipc .. " settings toggle",
      [ M.mainMod .. " + F12"]       = dms.ipc .. " lock lock",
      ["SUPER + I"]                  = dms.ipc .. " inhibit toggle",
      ["SUPER + F9"]                 = dms.ipc .. " wallpaper next",
      ["SUPER + SHIFT + F9"]         = dms.ipc .. " wallpaper prev",
      ["SUPER + W"]                  = dms.ipc .. " dankdash wallpaper",
      ["SUPER + N"]                  = dms.ipc .. " notifications toggle",
      ["SUPER + O"]                  = dms.ipc .. " notepad toggle",
      [ M.mainMod .. " + SHIFT + Q"] = dms.ipc .. " powermenu toggle",
   },
   
   [noctalia.cmd] = {
      ["SUPER + S"]                  = noctalia.ipc .. " settings toggle",
      [ M.mainMod .. " + F12"]       = noctalia.ipc .. " lockScreen lock",
      ["SUPER + I"]                  = noctalia.ipc .. " idleInhibitor toggle",
      ["SUPER + W"]                  = noctalia.ipc .. " wallpaper toggle",
      ["SUPER + N"]                  = noctalia.ipc .. " notifications toggleHistory",
      [ M.mainMod .. " + SHIFT + Q"] = noctalia.ipc .. " sessionMenu toggle",
   },
}

-- Preferred status bar
M.statusBar      = dms.cmd

-- Layout variables
M.layoutTable  = { "dwindle", "master", "scrolling", "monocle" }
M.index        = 1

M.layoutColors = {
        dwindle   = "rgb(bd93f9)",
        master    = "rgb(ffb86c)",
        scrolling = "rgb(00ffd5)",
        monocle   = "rgb(ff79c6)",
}

-- azerty keyboard support 
M.azerty = {"ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave"}

return M
