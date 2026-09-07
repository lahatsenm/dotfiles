---------------------
---- KEYBINDINGS ----
---------------------

local p = require("modules.programs")
local u = require("modules.utils")

-- Main modifier
local mainMod = "ALT"

-- Switch workspaces with mainMod + [0-9].
-- Move active window to a workspace with mainMod + SHIFT + [0-9].
for i = 1, 10 do
   local key = i % 10 -- 10 maps to key 0.
   hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
   hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end
-- AZERTY workspace bindings.
local azerty = {"ampersand", "eacute", "quotedbl", "apostrophe", "parenleft", "minus", "egrave", "underscore", "ccedilla", "agrave"}
for i, key in ipairs(azerty) do
   hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
   hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Layout specific bindings.
hl.bind(mainMod .. "+ H", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("focus left"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.focus({ direction = "left" }))
           elseif currentLayout == "master" or currentLayout == "monocle" then
              hl.dispatch(hl.dsp.layout("cycleprev"))
           end
end)

hl.bind(mainMod .. "+ L", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("focus right"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.focus({ direction = "right" }))
           elseif currentLayout == "master" or currentLayout == "monocle" then
              hl.dispatch(hl.dsp.layout("cyclenext"))
           end
end)

hl.bind(mainMod .. " + K",    function()
           local currentLayout = hl.get_active_workspace().tiled_layout
           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("focus up"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.focus({ direction = "up" }))
           end
end)
hl.bind(mainMod .. " + J",  function()
           local currentLayout = hl.get_active_workspace().tiled_layout
           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("focus down"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.focus({ direction = "down" }))
           end
end)

hl.bind(mainMod .. "+ SHIFT + H", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("swapcol l"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.window.move({ direction = "left"}))
           elseif currentLayout == "master" then
              hl.dispatch(hl.dsp.layout("swapprev"))
           end
end)

hl.bind(mainMod .. "+ SHIFT + L", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("swapcol r"))
           elseif currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.window.move({ direction = "right"}))
           elseif currentLayout == "master" then
              hl.dispatch(hl.dsp.layout("swapnext"))
           end
end)

hl.bind(mainMod .. " + SHIFT + K", function()
           local currentLayout = hl.get_active_workspace().tiled_layout
           
           if currentLayout == "scrolling" or currentLayout == "dwindle"  then
              hl.dispatch(hl.dsp.window.move({ direction = "up" }))
           end
end)
hl.bind(mainMod .. " + SHIFT + J", function()
           local currentLayout = hl.get_active_workspace().tiled_layout
           
           if currentLayout == "scrolling" or currentLayout == "dwindle" then
              hl.dispatch(hl.dsp.window.move({ direction = "down" }))
           end
end)

hl.bind("MOD5 + TAB", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("center"))
           end
end)

hl.bind(mainMod .. "+ M", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("colresize +conf"))
           end
end)

hl.bind(mainMod .. "+ SHIFT + M", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("colresize -conf"))
           end
end)

hl.bind(mainMod .. "+ SHIFT + LEFT", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("consume_or_expel prev"))
           end
end)

hl.bind(mainMod .. "+ SHIFT + RIGHT", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("consume_or_expel next"))
           end
end)

hl.bind(mainMod .. "+ SHIFT + F", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("fit active"))
           end
end)

hl.bind(mainMod .. "+ CTRL + F", function()
           local currentLayout = hl.get_active_workspace().tiled_layout

           if currentLayout == "scrolling" then
              hl.dispatch(hl.dsp.layout("fit visible"))
           end
end)

-- SUBMAPS
hl.define_submap("resize", function()
                    hl.bind("LEFT", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize -0.1"))
                               elseif currentLayout == "dwindle" or currentLayout == "master" then
                                  hl.dispatch(hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("RIGHT", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize +0.1"))
                               elseif currentLayout == "dwindle" or currentLayout == "master" then                             
                                  hl.dispatch(hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("UP", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "dwindle" or currentLayout == "master" then
                                  hl.dispatch(hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("DOWN", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "dwindle" or currentLayout == "master" then                             
                                  hl.dispatch(hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
                               end
                    end, { repeating = true, })

                    hl.bind("H", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize -0.1"))
                               elseif currentLayout == "dwindle" or currentLayout == "master" then
                                  hl.dispatch(hl.dsp.window.resize({ x = -100, y = 0, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("L", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize +0.1"))
                               elseif currentLayout == "dwindle" or currentLayout == "master" then                             
                                  hl.dispatch(hl.dsp.window.resize({ x = 100, y = 0, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("K", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "dwindle" or currentLayout == "master" then
                                  hl.dispatch(hl.dsp.window.resize({ x = 0, y = -100, relative = true }))
                               end
                    end, { repeating = true, })
                    
                    hl.bind("J", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               if currentLayout == "dwindle" or currentLayout == "master" then                             
                                  hl.dispatch(hl.dsp.window.resize({ x = 0, y = 100, relative = true }))
                               end
                    end, { repeating = true, })

                    -- Mouse resizing and dragging.
                    hl.bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
                    hl.bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("window_workspace", function()
                    hl.bind("H", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("focus left"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.focus({ direction = "left" }))
                               elseif currentLayout == "master" or currentlayout == "monocle" then
                                  hl.dispatch(hl.dsp.layout("cycleprev"))
                               end
                    end)

                    hl.bind("L", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("focus right"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.focus({ direction = "right" }))
                               elseif currentLayout == "master" or currentlayout == "monocle" then
                                  hl.dispatch(hl.dsp.layout("cyclenext"))
                               end
                    end)

                    hl.bind("K", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("focus up"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.focus({ direction = "up" }))
                               end
                    end)

                    hl.bind("J", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("focus down"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.focus({ direction = "down" }))
                               end
                    end)

                    hl.bind("SHIFT + H", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("swapcol l"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.window.move({ direction = "left" }))
                               elseif currentLayout == "master" then
                                  hl.dispatch(hl.dsp.layout("swapprev"))
                               end
                    end)
                    
                    hl.bind("SHIFT + L", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("swapcol r"))
                               elseif currentLayout == "dwindle" then
                                  hl.dispatch(hl.dsp.window.move({ direction = "right" }))
                               elseif currentLayout == "master" then
                                  hl.dispatch(hl.dsp.layout("swapnext"))
                               end
                    end)

                    hl.bind("SHIFT + K", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" or currentLayout == "dwindle"  then
                                  hl.dispatch(hl.dsp.window.move({ direction = "up" }))
                               end
                    end)
                    
                    hl.bind("SHIFT + J", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" or currentLayout == "dwindle"  then
                                  hl.dispatch(hl.dsp.window.move({ direction = "down" }))
                               end
                    end)
                    
                    hl.bind("M", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize +conf"))
                               end
                    end)

                    hl.bind("SHIFT + M", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("colresize -conf"))
                               end
                    end)

                    hl.bind("SHIFT + LEFT", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("consume_or_expel prev"))
                               end
                    end)

                    hl.bind("SHIFT + RIGHT", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("consume_or_expel next"))
                               end
                    end)

                    hl.bind("SHIFT + F", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("fit active"))
                               end
                    end)

                    hl.bind("CTRL + F", function()
                               local currentLayout = hl.get_active_workspace().tiled_layout
                               
                               if currentLayout == "scrolling" then
                                  hl.dispatch(hl.dsp.layout("fit visible"))
                               end
                    end)

                    hl.bind("F", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
                    
                    for i = 1, 10 do
                       local key = i % 10 -- 10 maps to key 0.
                       hl.bind(key,             hl.dsp.focus({ workspace = i }))
                       hl.bind("SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
                    end

                    local numpads = {"KP_End", "KP_Down", "KP_Next", "KP_Left", "KP_Begin", "KP_Right", "KP_Home", "KP_Up", "KP_Prior", "KP_Insert"}
                    for i, num in pairs(numpads) do
                       hl.bind(num,             hl.dsp.focus({ workspace = i }))
                       hl.bind("SHIFT + " .. num,     hl.dsp.window.move({ workspace = i }))
                    end
                    -- AZERTY workspace bindings.
                    for i, key in ipairs(azerty) do
                       hl.bind(key,             hl.dsp.focus({ workspace = i }))
                       hl.bind("SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
                    end
                    
                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("layout", function()
                    hl.bind("S", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "scrolling" }) end)
                    hl.bind("D", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "dwindle" }) end)
                    hl.bind("M", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "master" }) end)
                    hl.bind("O", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "monocle" }) end)

                    -- Display current layout as a notification.
                    hl.bind("N", function()
                               u.layoutNotify()
                    end)

                    -- Cycling layouts forward/backward.
                    local layoutNames  = { "dwindle", "master", "scrolling", "monocle" }
                    hl.bind("K", function()
                               u.cycleLayouts({ forward = true,
                                                layouts = layoutNames,
                               })
                    end)
                    hl.bind("J", function()
                               u.cycleLayouts({ forward = false,
                                                layouts = layoutNames,
                               })
                    end)

                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("status_bar", function()
                    hl.bind("S", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg settings-toggle"))
                               end
                               
                    end)
                    hl.bind("H", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg bar-toggle"))
                               end
                    end)
                    hl.bind("W", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle wallpaper"))
                               end
                    end)
                    hl.bind("C", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle control-center"))
                               end
                    end)
                    hl.bind("N", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle control-center notifications"))
                               end
                    end)
                    hl.bind("D", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle control-center calendar"))
                               end
                    end)
                    hl.bind("A", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle control-center audio"))
                               end
                    end)
                    hl.bind("Q", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle control-center session"))
                               end
                    end)

                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("volume", function()
                    hl.bind("K", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
                    hl.bind("SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("brightness", function()
                    hl.bind("K", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })

                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.bind("ALT + R",  hl.dsp.submap("main"))
hl.define_submap("main", function()
                    hl.bind("R", hl.dsp.submap("resize"))
                    hl.bind("W", hl.dsp.submap("window_workspace"))
                    hl.bind("L", hl.dsp.submap("layout"))
                    hl.bind("B", hl.dsp.submap("status_bar"))
                    hl.bind("V", hl.dsp.submap("volume"))
                    hl.bind("SHIFT + B", hl.dsp.submap("brightness"))
                    hl.bind("I", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg caffeine-toggle"))
                               end
                    end)
                    hl.bind("Q", function()
                               if p.statusBar == "noctalia" then
                                  hl.dispatch(hl.dsp.exec_cmd("noctalia msg panel-toggle session"))
                               end
                               hl.dispatch(hl.dsp.submap("reset"))
                    end)
                    
                    hl.bind("BackSpace", function()
                               u.previousSubmap()
                    end)
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- General keybindings that work for every layout.
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(p.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(p.menu))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
-- hl.bind("ALT + TAB", function()
--      This is for the overview.
-- end)

-- Be careful with this one as it doesn't ask and might be unnintentionally pressed.
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'"))

hl.bind("SUPER + PRIOR",  hl.dsp.window.cycle_next({ floating = true }))
hl.bind("SUPER + NEXT",  hl.dsp.window.cycle_next({ tiled = true }))

-- Scroll through existing workspaces with mainMod + scroll.
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging.
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

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
