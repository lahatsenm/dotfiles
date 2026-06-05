---------------------
---- KEYBINDINGS ----
---------------------

local vars = require("modules.variables")
local utils = require("modules.utils")
require("modules.submaps")

-- Switch workspaces with mainMod + [0-9].
-- Move active window to a workspace with mainMod + SHIFT + [0-9].
for i = 1, 10 do
   local key = i % 10 -- 10 maps to key 0.
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- AZERTY workspace bindings.
for i, key in ipairs(vars.azerty) do
   hl.bind(vars.mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
   hl.bind(vars.mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Status bar bindings.
for key, cmd in pairs(vars.sb[vars.sb.name].binds.normal) do
   hl.bind(key, hl.dsp.exec_cmd(cmd))
end

-- Layout specific bindings.
for key, _ in pairs(vars.allLayoutKeys) do
   hl.bind(key, function()
              local cmd = vars.layouts[vars.currentLayout].binds.normal[key]

              if cmd then
                 hl.dispatch(cmd)
              end
   end)
end

-- Display current layout as a notification.
hl.bind("SUPER + L", function()
           utils.layoutNotify()
end)

-- Submaps bindings.
hl.bind("ALT + R",  hl.dsp.submap("main"))
hl.define_submap("main", function()
                    -- "resize"
                    hl.bind("R", hl.dsp.submap("resize"))

                    -- "layout"
                    hl.bind("L", hl.dsp.submap("layout"))

                    -- "sb" for status bar
                    hl.bind("B", hl.dsp.submap("sb"))
                    
                    -- "volume"
                    hl.bind("V", hl.dsp.submap("volume"))

                    -- "brightness"
                    hl.bind("ALT + B", hl.dsp.submap("brightness"))
end)

-- General keybindings that work for every layout.
hl.bind(vars.mainMod .. " + RETURN", hl.dsp.exec_cmd(vars.terminal))
hl.bind(vars.mainMod .. " + Q", hl.dsp.window.close())
hl.bind(vars.mainMod .. " + SPACE", hl.dsp.exec_cmd(vars.menu))
hl.bind(vars.mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(vars.mainMod .. " + ESCAPE", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind(vars.mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(vars.mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))

-- Be careful with this one as it doesn't ask and I might unintentionally press it.
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'"))

hl.bind(vars.mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(vars.mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

hl.bind(vars.mainMod .. " + SHIFT + K",    hl.dsp.window.move({ direction = "up" }))
hl.bind(vars.mainMod .. " + SHIFT + J",  hl.dsp.window.move({ direction = "down" }))

hl.bind("SUPER + UP",  hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
hl.bind("SUPER + DOWN",  hl.dsp.window.resize({ x = 0 , y = 100, relative = true }))
hl.bind("SUPER + PRIOR",  hl.dsp.window.cycle_next({ floating = true }))
hl.bind("SUPER + NEXT",  hl.dsp.window.cycle_next({ tiled = true }))

-- Scroll through existing workspaces with mainMod + scroll.
hl.bind(vars.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging.
hl.bind(vars.mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(vars.mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl.
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
