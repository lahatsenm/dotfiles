-- Shared variables

local M = {}

-- Programs
M.hyprpm      = "hyprpm reload -n"
M.terminal    = "wezterm"
M.editor      = "emacs"
M.fileManager = "dolphin"
M.browser     = "brave"
M.menuDaemon  = "vicinae server"
M.menu        = "vicinae toggle"
M.polkit      = "/usr/lib/polkit-kde-authentication-agent-1"
M.idleDaemon  = "hypridle"
M.screenShot  = "flameshot"

-- Main modifier
M.mainMod     = "ALT"

-- azerty keyboard support table
M.azerty = {"ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave"}

-- Status bar table
M.sb = {
   -- Preferred status bar
   name = "noctaliaV5",
   
   dms = {
      cmd = "dms run",
      binds = {
         ["SUPER + S"]                  = "dms ipc call settings toggle",
         [ M.mainMod .. " + F12"]       = "dms ipc call lock lock",
         ["SUPER + I"]                  = "dms ipc call inhibit toggle",
         ["SUPER + F9"]                 = "dms ipc call wallpaper next",
         ["SUPER + SHIFT + F9"]         = "dms ipc call wallpaper prev",
         ["SUPER + W"]                  = "dms ipc call dankdash wallpaper",
         ["SUPER + N"]                  = "dms ipc call notifications toggle",
         ["SUPER + O"]                  = "dms ipc call notepad toggle",
         [ M.mainMod .. " + SHIFT + Q"] = "dms ipc call powermenu toggle",
      },
   },
   
   noctalia = {
      cmd = "qs -c noctalia-shell --no-duplicate",
      binds = {
         ["SUPER + S"]                  = "qs -c noctalia-shell ipc call settings toggle",
         [ M.mainMod .. " + F12"]       = "qs -c noctalia-shell ipc call lockScreen lock",
         ["SUPER + I"]                  = "qs -c noctalia-shell ipc call idleInhibitor toggle",
         ["SUPER + W"]                  = "qs -c noctalia-shell ipc call wallpaper toggle",
         ["SUPER + N"]                  = "qs -c noctalia-shell ipc call notifications toggleHistory",
         [ M.mainMod .. " + SHIFT + Q"] = "qs -c noctalia-shell ipc call sessionMenu toggle",
      },
   },

   noctaliaV5 = {
      cmd = "noctalia --daemon",
      binds = {
         ["SUPER + S"]                  = "noctalia msg settings-toggle",
         -- [ M.mainMod .. " + F12"]       = "noctalia msg screen-lock", -- I will be using this once v5 is stable
         [ M.mainMod .. " + F12"]       = "hyprlock",
         ["SUPER + I"]                  = "noctalia msg caffeine-toggle",
         ["SUPER + W"]                  = "noctalia msg panel-toggle wallpaper",
         ["PAUSE"]                      = "noctalia msg panel-toggle control-center",
         [ M.mainMod .. " + SHIFT + Q"] = "noctalia msg panel-toggle session",
      },
   },

   wayle = {
      daemon = "wayle panel start",
      cmd =  "wayle shell",
      binds = {
         ["SUPER + S"] = "wayle panel settings",
         ["SUPER + I"] = "wayle idle toggle",
      },
   },
}

-- Layouts table
M.layouts = {
   dwindle   = {
      color = "rgb(bd93f9)",
      binds = {
         [ M.mainMod .. " + H"]         = hl.dsp.focus({ direction = "left" }),
         [ M.mainMod .. " + L"]         = hl.dsp.focus({ direction = "right" }),
         [ M.mainMod .. " + SHIFT + H"] = hl.dsp.window.move({ direction = "left" }),
         [ M.mainMod .. " + SHIFT + L"] = hl.dsp.window.move({ direction = "right" }),
         ["SUPER + LEFT"]               = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
         ["SUPER + RIGHT"]              = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
      },
   },
   master    = {
      color = "rgb(ffb86c)",
      binds = {
         [ M.mainMod .. " + H"]         = hl.dsp.layout("cycleprev"),
         [ M.mainMod .. " + L"]         = hl.dsp.layout("cyclenext"),
         [ M.mainMod .. " + SHIFT + H"] = hl.dsp.layout("swapprev"),
         [ M.mainMod .. " + SHIFT + L"] = hl.dsp.layout("swapnext"),
         ["SUPER + LEFT"]               = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
         ["SUPER + RIGHT"]              = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
      },
   },
   scrolling = {
      color = "rgb(00ffd5)",
      binds = {
         [ M.mainMod .. " + H"]             = hl.dsp.layout("focus left"),
         [ M.mainMod .. " + L"]             = hl.dsp.layout("focus right"),
         [ M.mainMod .. " + SHIFT + H"]     = hl.dsp.layout("swapcol l"),
         [ M.mainMod .. " + SHIFT + L"]     = hl.dsp.layout("swapcol r"),
         ["SUPER + LEFT"]                   = hl.dsp.layout("colresize -0.1"),
         ["SUPER + RIGHT"]                  = hl.dsp.layout("colresize +0.1"),
         [ M.mainMod .. " + M"]             = hl.dsp.layout("colresize +conf"),
         [ M.mainMod .. " + SHIFT + M"]     = hl.dsp.layout("colresize -conf"),
         [ M.mainMod .. " + SHIFT + LEFT"]  = hl.dsp.layout("consume_or_expel prev"),
         [ M.mainMod .. " + SHIFT + RIGHT"] = hl.dsp.layout("consume_or_expel next"),
         [ M.mainMod .. " + SHIFT + F"]     = hl.dsp.layout("fit active"),
         [ M.mainMod .. " + CTRL + F"]      = hl.dsp.layout("fit visible"),
         [ M.mainMod .. " + LEFT"]          = hl.dsp.layout("move -col"),
         [ M.mainMod .. " + RIGHT"]         = hl.dsp.layout("move +col"),
      },
      
   },
   monocle = {
      color   = "rgb(ff79c6)",
      binds = {
         [ M.mainMod .. " + H"] = hl.dsp.layout("cycleprev"),
         [ M.mainMod .. " + L"] = hl.dsp.layout("cyclenext"),
      },
   },
}

-- hy3 plugin entry in layouts table
if hl.plugin.hy3 ~= nil then
   local hy3 = hl.plugin.hy3

   -- Fill the layouts table
   M.layouts["hy3"] = {
      color = "rgb(8be9fd)",
      binds = {
         [ M.mainMod .. " + RIGHT"]     = hy3.make_group("h"),
         [ M.mainMod .. " + DOWN"]      = hy3.make_group("v"),
         [ M.mainMod .. " + Z"]         = hy3.change_group("toggletab"),
         [ M.mainMod .. " + H"]         = hy3.move_focus("left"),
         [ M.mainMod .. " + L"]         = hy3.move_focus("right"),
         [ M.mainMod .. " + J"]         = hy3.move_focus("down"),
         [ M.mainMod .. " + K"]         = hy3.move_focus("up"),
         [ M.mainMod .. " + SHIFT + H"] = hy3.move_window("left"),
         [ M.mainMod .. " + SHIFT + L"] = hy3.move_window("right"),
         [ M.mainMod .. " + SHIFT + J"] = hy3.move_window("down"),
         [ M.mainMod .. " + SHIFT + K"] = hy3.move_window("up"),
         ["MOD5 + F"]                   = hy3.toggle_focus_layer(),
      },
   }

   -- workspace bindings
   -- These are not needed because hl.dsp.window.move() can be used on hy3 as well.
   -- So why am I still putting this here?? xD
   -- for i = 1, 10 do
   --    local key = i % 10
   --    M.layouts.hy3.binds[ M.mainMod .. " + SHIFT + " .. key ] = hy3.move_to_workspace(i)
   -- end
   -- -- azerty workspace bindings support
   -- for i, key in ipairs(M.azerty) do
   --    M.layouts.hy3.binds[ M.mainMod .. " + SHIFT + " .. key ] = hy3.move_to_workspace(i)
   -- end
end

-- For cycling layouts
M.layoutNames  = { "dwindle", "master", "scrolling", "monocle", "hy3"}
M.index        = 1

-- A helper table to easily call hl.bind()
-- before getting the current layout.
M.allLayoutKeys = {}

for layout, _ in pairs(M.layouts) do
   for key, _ in pairs(M.layouts[layout].binds) do
      M.allLayoutKeys[key] = true   -- This could be anything except nil
   end
end

return M
