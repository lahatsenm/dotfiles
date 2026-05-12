---------------------
---- KEYBINDINGS ----
---------------------

local vars = require("modules.variables")

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
-- hl.bind(vars.mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
-- hl.bind(vars.mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(vars.mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(vars.mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

-- Move window with mainMod + SHIFT + HJKL keys
-- hl.bind(vars.mainMod .. " + SHIFT + H",  hl.dsp.window.move({ direction = "left" }))
-- hl.bind(vars.mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(vars.mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(vars.mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

-- Resize window
hl.bind(vars.mainMod .. " + CTRL + LEFT",  hl.dsp.window.resize({ x = -30, y = 0, relative = true }))
hl.bind(vars.mainMod .. " + CTRL + RIGHT",  hl.dsp.window.resize({ x = 30, y = 0, relative = true }))
hl.bind(vars.mainMod .. " + CTRL + UP",  hl.dsp.window.resize({ x = 0, y = -30, relative = true }))
hl.bind(vars.mainMod .. " + CTRL + DOWN",  hl.dsp.window.resize({ x = 0 , y = 30, relative = true }))


-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
   local key = i % 10 -- 10 maps to key 0
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- AZERTY workspace bindings
local azerty = {"ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave"}
for i, key in ipairs(azerty) do
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

------------------------ SCROLLING ONLY ------------------------
-- Focus column
hl.bind(vars.mainMod .. " + H",  hl.dsp.layout("focus left"))
hl.bind(vars.mainMod .. " + L", hl.dsp.layout("focus right"))

-- Swap column
hl.bind(vars.mainMod .. " + SHIFT + H", hl.dsp.layout("swapcol l"))
hl.bind(vars.mainMod .. " + SHIFT + L", hl.dsp.layout("swapcol r"))

-- Resize column 
hl.bind(vars.mainMod .. " + M", hl.dsp.layout("colresize +conf"))
hl.bind(vars.mainMod .. " + SHIFT + M", hl.dsp.layout("colresize -conf"))
hl.bind("SUPER + LEFT",  hl.dsp.layout("colresize -0.1"))
hl.bind("SUPER + RIGHT",  hl.dsp.layout("colresize +0.1"))

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
hl.bind("MOD5 + O",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind("MOD5 + P",   hl.dsp.focus({ workspace = "e-1" }))

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
