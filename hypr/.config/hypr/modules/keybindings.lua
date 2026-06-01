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
for key, cmd in pairs(vars.sb[vars.sb.name].binds) do
   hl.bind(key, hl.dsp.exec_cmd(cmd))
end

-- Layout specific bindings
for key, _ in pairs(vars.allLayoutKeys) do
   hl.bind(key, function()
              local cmd = vars.layouts[vars.currentLayout].binds.normal[key]

              if cmd then
                 hl.dispatch(cmd)
              end
   end)
end

-- Display current layout as a notification
hl.bind("SUPER + L", function()
           utils.layoutNotify()
end)

-- Cycle scrolling/hy3 layouts
hl.bind(vars.mainMod .. " + TAB", function()
           utils.cycleLayouts({ general = false,
                                forward = true,
                                layouts = {
                                   "scrolling",
                                   "hy3",
                                },
           })
end)

-- Cycle workspace layouts forward
hl.bind("MOD5 + TAB", function()
           utils.cycleLayouts({ general = false,
                                forward = true,
                                layouts = vars.layoutNames,
           })
end)

-- Cycle workspace layouts backward
hl.bind("MOD5 + SHIFT + TAB", function()
           utils.cycleLayouts({ general = false,
                                forward = false,
                                layouts = vars.layoutNames,
           })
end)

--[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
   These bindings are useless in workspaces using
   workspace rules because they require removing
   these rules first and we don't have that feature yet.
   I hope I get a good answer to this problem here:
   https://github.com/hyprwm/Hyprland/discussions/14852
   Edit: workspace rules removal will be implemented in v0.56.0, Thanks Vaxry.
   https://github.com/hyprwm/Hyprland/issues/14876
   
   -- Cycle general layouts forward
   hl.bind("SUPER + TAB", function()
   utils.cycleLayouts({ general = true,
   forward = true,
   layouts = vars.layoutNames,
   
   })
   end)

   -- Cycle general layouts backward
   hl.bind("SUPER + SHIFT + TAB", function()
   utils.cycleLayouts({ general = true,
   forward = false,
   layouts = vars.layoutNames,
   
   })
   end)
   --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]]

-- Submaps bindings
hl.bind("ALT + R",  hl.dsp.submap("resize"))

-- "resize" submap
hl.define_submap("resize", function()
                    for key, _ in pairs(vars.allLayoutSubmapKeys) do
                       hl.bind(key, function()
                                  local cmd = vars.layouts
                                     and vars.layouts[vars.currentLayout]
                                     and vars.layouts[vars.currentLayout].binds
                                     and vars.layouts[vars.currentLayout].binds.submaps
                                     and vars.layouts[vars.currentLayout].binds.submaps["resize"]
                                     and vars.layouts[vars.currentLayout].binds.submaps["resize"][key]
                                  
                                  if cmd then
                                     hl.dispatch(cmd)
                                  end
                       end)
                    end
                    
                    hl.bind("catchall", hl.dsp.submap("reset"))
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
hl.bind("MOD5 + O",  hl.dsp.window.cycle_next({ floating = true }))
hl.bind("MOD5 + P",  hl.dsp.window.cycle_next({ tiled = true }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(vars.mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(vars.mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Same things as above but only with keyboard
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
