-- Shared variables

local M = {}

-- Programs
M.terminal    = "wezterm"
M.editor      = "emacs"
M.fileManager = "dolphin"
M.browser     = "brave"
M.menuDaemon  = "vicinae server"
M.menu        = "vicinae toggle"
M.polkit      = "/usr/lib/polkit-kde-authentication-agent-1"
M.idleDaemon  = "swayidle"
M.screenShot  = "flameshot"

-- Main modifier
M.mainMod     = "ALT"

-- Status bar bindings tables
local dms = {
   cmd = "dms run",
   ipc = "dms ipc call",
}
local noctalia = {
   cmd = "qs -c noctalia-shell --no-duplicate",
   ipc = "qs -c noctalia-shell ipc call",
}

M.sbBinds = {
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

-- Layout switching and color tables
M.layoutNames  = { "dwindle", "master", "scrolling", "monocle" }
M.index        = 1

M.layoutColors = {
        dwindle   = "rgb(bd93f9)",
        master    = "rgb(ffb86c)",
        scrolling = "rgb(00ffd5)",
        monocle   = "rgb(ff79c6)",
}

-- Layout specific bindings table
M.layoutBinds = {
   dwindle   = {
      [ M.mainMod .. " + H"] = hl.dsp.focus({ direction = "left" }),
      [ M.mainMod .. " + L"] = hl.dsp.focus({ direction = "right" }),
      [ M.mainMod .. " + SHIFT + H"] = hl.dsp.window.move({ direction = "left" }),
      [ M.mainMod .. " + SHIFT + L"] = hl.dsp.window.move({ direction = "right" }),
      ["SUPER + LEFT"] = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
      ["SUPER + RIGHT"] = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
   },
   master    = {
      [ M.mainMod .. " + H"] = hl.dsp.layout("cycleprev"),
      [ M.mainMod .. " + L"] = hl.dsp.layout("cyclenext"),
      [ M.mainMod .. " + SHIFT + H"] = hl.dsp.layout("swapprev"),
      [ M.mainMod .. " + SHIFT + L"] = hl.dsp.layout("swapnext"),
      ["SUPER + LEFT"] = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
      ["SUPER + RIGHT"] = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
   },
   scrolling = {
      [ M.mainMod .. " + H"] = hl.dsp.layout("focus left"),
      [ M.mainMod .. " + L"] = hl.dsp.layout("focus right"),
      [ M.mainMod .. " + SHIFT + H"] = hl.dsp.layout("swapcol l"),
      [ M.mainMod .. " + SHIFT + L"] = hl.dsp.layout("swapcol r"),
      ["SUPER + LEFT"] = hl.dsp.layout("colresize -0.1"),
      ["SUPER + RIGHT"] = hl.dsp.layout("colresize +0.1"),
      [ M.mainMod .. " + M"] = hl.dsp.layout("colresize +conf"),
      [ M.mainMod .. " + SHIFT + M"] = hl.dsp.layout("colresize -conf"),
      [ M.mainMod .. " + SHIFT + LEFT"] = hl.dsp.layout("consume_or_expel prev"),
      [ M.mainMod .. " + SHIFT + RIGHT"] = hl.dsp.layout("consume_or_expel next"),
      [ M.mainMod .. " + SHIFT + F"] = hl.dsp.layout("fit active"),
      [ M.mainMod .. " + CTRL + F"] = hl.dsp.layout("fit visible"),
      [ M.mainMod .. " + LEFT"] = hl.dsp.layout("move -col"),
      [ M.mainMod .. " + RIGHT"] = hl.dsp.layout("move +col"),
      
   },
   monocle   = {
      [ M.mainMod .. " + H"] = hl.dsp.layout("cycleprev"),
      [ M.mainMod .. " + L"] = hl.dsp.layout("cyclenext"),
   },
}

-- A helper table to easily call hl.bind()
-- before getting the current layout.
M.allLayoutKeys = {}

for _, binds in pairs(M.layoutBinds) do
   for key, _ in pairs(binds) do
      M.allLayoutKeys[key] = true   -- This could be anything except nil
   end
end

-- azerty keyboard support table
M.azerty = {"ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave"}

return M
