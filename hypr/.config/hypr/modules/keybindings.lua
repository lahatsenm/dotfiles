---------------------
---- KEYBINDINGS ----
---------------------

local vars = require("modules.variables")
local utils = require("modules.utils")

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
   local key = i % 10 -- 10 maps to key 0
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- AZERTY workspace bindings
for i, key in ipairs(vars.azerty) do
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Status bar bindings
for key, cmd in pairs(vars.sb[vars.statusBar]) do
   hl.bind(key, hl.dsp.exec_cmd(cmd))
end

-- Toggling between scrolling/dwindle
hl.bind(vars.mainMod .. " + TAB", function()
           -- Get the current layout
           local layout = hl.get_config("general.layout")
           
           if layout == "scrolling" then
              hl.config({
                    general = { layout = "dwindle" }
              })
           else
              hl.config({
                    general = { layout = "scrolling" }
              })
           end

           -- Display the current layout
           utils.layoutSwitchNotify()
end)

-- Cycle layouts forward
hl.bind("MOD5 + TAB", function()
           -- get the current layout
           local layout = hl.get_config("general.layout")

           if layout ~= vars.layoutTable[vars.index] then
              hl.config({
                    general = { layout = vars.layoutTable[vars.index] }
              })
           end

           vars.index = vars.index + 1
           if vars.index > #vars.layoutTable then
              vars.index = 1
           end
           
           -- display the current layout
           utils.layoutSwitchNotify()
end)

-- Cycle layouts backward
hl.bind("MOD5 + SHIFT + TAB", function()
           -- get the current layout
           local layout = hl.get_config("general.layout")

           if layout ~= vars.layoutTable[vars.index] then
              hl.config({
                    general = { layout = vars.layoutTable[vars.index] }
              })
           end

           vars.index = vars.index - 1
           if vars.index < 1 then
              vars.index = #vars.layoutTable
           end
           
           -- display the current layout
           utils.layoutSwitchNotify()
end)

hl.bind(vars.mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.mainMod .. " + Q", hl.dsp.window.close())
hl.bind(vars.mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.menu))
hl.bind(vars.mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.mainMod .. " + ESCAPE", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind(vars.mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))
hl.bind(vars.mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Move focus with mainMod + HJKL keys
hl.bind(vars.mainMod .. " + H",  function()
           local layoutTable = {
              master = hl.dsp.layout("cycleprev"),
              scrolling = hl.dsp.layout("focus left"),
              monocle = hl.dsp.layout("cycleprev"),
           }

           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle" }
           local sharedDispatcher = hl.dsp.focus({ direction = "left" })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind(vars.mainMod .. " + L", function()
           local layoutTable = {
              master = hl.dsp.layout("cyclenext"),
              scrolling = hl.dsp.layout("focus right"),
              monocle = hl.dsp.layout("cyclenext"),
           }

           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle" }
           local sharedDispatcher = hl.dsp.focus({ direction = "right" })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind(vars.mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(vars.mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + HJKL keys
hl.bind(vars.mainMod .. " + SHIFT + H",  function()
           local layoutTable = {
              master = hl.dsp.layout("swapprev"),
              scrolling = hl.dsp.layout("swapcol l"),
           }

           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle" }
           local sharedDispatcher = hl.dsp.window.move({ direction = "left" })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind(vars.mainMod .. " + SHIFT + L", function()
           local layoutTable = {
              master = hl.dsp.layout("swapnext"),
              scrolling = hl.dsp.layout("swapcol r"),
           }

           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle" }
           local sharedDispatcher = hl.dsp.window.move({ direction = "right" })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind(vars.mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(vars.mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

-- Resize window
hl.bind("SUPER + LEFT",  function()
           local layoutTable = {
              scrolling = hl.dsp.layout("colresize -0.1"),
           }
           
           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle", "master" }
           local sharedDispatcher = hl.dsp.window.resize({ x = -100, y = 0, relative = true })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind("SUPER + RIGHT",  function()
           local layoutTable = {
              scrolling = hl.dsp.layout("colresize +0.1"),
           }
           
           -- use the same dispatcher for these layouts
           local sharedLayouts = { "dwindle", "master" }
           local sharedDispatcher = hl.dsp.window.resize({ x = 100, y = 0, relative = true })
           
           utils.action(layoutTable, sharedLayouts, sharedDispatcher)
end)

hl.bind("SUPER + UP",  hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind("SUPER + DOWN",  hl.dsp.window.resize({ x = 0 , y = 100, relative = true }))
hl.bind("MOD5 + O",  hl.dsp.window.cycle_next({ floating = true }))
hl.bind("MOD5 + P",  hl.dsp.window.cycle_next({ tiled = true }))

------------------------ SCROLLING ONLY ------------------------
-- Resize column 
hl.bind(vars.mainMod .. " + M", hl.dsp.layout("colresize +conf"))
hl.bind(vars.mainMod .. " + SHIFT + M", hl.dsp.layout("colresize -conf"))

-- Consume or expel column
hl.bind(vars.mainMod .. " + SHIFT + LEFT", hl.dsp.layout("consume_or_expel prev"))
hl.bind(vars.mainMod .. " + SHIFT + RIGHT", hl.dsp.layout("consume_or_expel next"))

-- Fit active column
hl.bind(vars.mainMod .. " + SHIFT + F", hl.dsp.layout("fit active"))
hl.bind(vars.mainMod .. " + CTRL + F", hl.dsp.layout("fit visible"))

-- Move column
hl.bind(vars.mainMod .. " + RIGHT", hl.dsp.layout("move +col"))
hl.bind(vars.mainMod .. " + LEFT", hl.dsp.layout("move -col"))

-----------------------------------------------------------------

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(vars.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- and this is the keyboard version
hl.bind(vars.mainMod .. " + PRIOR", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(vars.mainMod .. " + NEXT",  hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(vars.mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(vars.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
