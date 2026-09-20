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
local function layoutBind(bindTable)
   return function()
      local workspace = hl.get_active_special_workspace() or hl.get_active_workspace()

      if not workspace then
         return
      end

      local layout = workspace.tiled_layout
      local action = bindTable[layout]
      
      if action then
         if type(action) == "function" then
            action()
         else
            hl.dispatch(action)
         end
      end
   end
end

hl.bind(mainMod .. "+ H", layoutBind({
              scrolling = hl.dsp.layout("focus left"),
              dwindle   = hl.dsp.focus({ direction = "left" }),
              master    = hl.dsp.layout("cycleprev"),
              monocle   = hl.dsp.layout("cycleprev"),
}))
hl.bind(mainMod .. "+ L", layoutBind({
              scrolling = hl.dsp.layout("focus right"),
              dwindle   = hl.dsp.focus({ direction = "right" }),
              master    = hl.dsp.layout("cyclenext"),
              monocle   = hl.dsp.layout("cyclenext")
}))
hl.bind(mainMod .. "+ K", layoutBind({
              scrolling = hl.dsp.layout("focus up"),
              dwindle   = hl.dsp.focus({ direction = "up" })
}))
hl.bind(mainMod .. "+ J", layoutBind({
              scrolling = hl.dsp.layout("focus down"),
              dwindle   = hl.dsp.focus({ direction = "down" })
}))
hl.bind(mainMod .. "+ SHIFT + H", layoutBind({
              scrolling = hl.dsp.layout("swapcol l"),
              dwindle = hl.dsp.window.move({ direction = "left" }),
              master = hl.dsp.layout("swapprev")
}))
hl.bind(mainMod .. "+ SHIFT + L", layoutBind({
              scrolling = hl.dsp.layout("swapcol r"),
              dwindle = hl.dsp.window.move({ direction = "right" }),
              master = hl.dsp.layout("swapnext")
}))
hl.bind(mainMod .. " + SHIFT + K", layoutBind({
              scrolling = hl.dsp.window.move({ direction = "up" }),
              dwindle = hl.dsp.window.move({ direction = "up" })
}))
hl.bind(mainMod .. " + SHIFT + J", layoutBind({
              scrolling = hl.dsp.window.move({ direction = "down" }),
              dwindle = hl.dsp.window.move({ direction = "down" })
}))
hl.bind("MOD5 + TAB", layoutBind({
              scrolling = hl.dsp.layout("center")
}))
hl.bind(mainMod .. "+ M", layoutBind({
              scrolling = hl.dsp.layout("colresize +conf")
}))
hl.bind(mainMod .. "+ SHIFT + M", layoutBind({
              scrolling = hl.dsp.layout("colresize -conf")
}))
hl.bind(mainMod .. "+ SHIFT + LEFT", layoutBind({
              scrolling = hl.dsp.layout("consume_or_expel prev")
}))
hl.bind(mainMod .. "+ SHIFT + RIGHT", layoutBind({
              scrolling = hl.dsp.layout("consume_or_expel next")
}))
hl.bind(mainMod .. "+ SHIFT + F", layoutBind({
              scrolling = hl.dsp.layout("fit active")
}))
hl.bind(mainMod .. "+ CTRL + F", layoutBind({
              scrolling = hl.dsp.layout("fit visible")
}))

-- SUBMAPS
hl.define_submap("resize", function()
                    hl.bind("LEFT", layoutBind({
                                  scrolling = hl.dsp.layout("colresize -0.1"),
                                  dwindle = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
                                  master = hl.dsp.window.resize({ x = -100, y = 0, relative = true })
                                              }), { repeating = true, })
                    
                    hl.bind("RIGHT", layoutBind({
                                  scrolling = hl.dsp.layout("colresize +0.1"),
                                  dwindle = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
                                  master = hl.dsp.window.resize({ x = 100, y = 0, relative = true })
                                              }), { repeating = true, })

                    hl.bind("UP", layoutBind({
                                  dwindle = hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
                                  master = hl.dsp.window.resize({ x = 0, y = -100, relative = true })
                                            }), { repeating = true, })

                    hl.bind("DOWN", layoutBind({
                                  dwindle = hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
                                  master = hl.dsp.window.resize({ x = 0, y = 100, relative = true })
                                            }), { repeating = true, })

                    hl.bind("H", layoutBind({
                                  scrolling = hl.dsp.layout("colresize -0.1"),
                                  dwindle = hl.dsp.window.resize({ x = -100, y = 0, relative = true }),
                                  master = hl.dsp.window.resize({ x = -100, y = 0, relative = true })
                                           }), { repeating = true, })
                    
                    hl.bind("L", layoutBind({
                                  scrolling = hl.dsp.layout("colresize +0.1"),
                                  dwindle = hl.dsp.window.resize({ x = 100, y = 0, relative = true }),
                                  master = hl.dsp.window.resize({ x = 100, y = 0, relative = true })
                                               }), { repeating = true, })
                    
                    hl.bind("K", layoutBind({
                                  dwindle = hl.dsp.window.resize({ x = 0, y = -100, relative = true }),
                                  master = hl.dsp.window.resize({ x = 0, y = -100, relative = true })
                                            }), { repeating = true, })
                    
                    hl.bind("J", layoutBind({
                                  dwindle = hl.dsp.window.resize({ x = 0, y = 100, relative = true }),
                                  master = hl.dsp.window.resize({ x = 0, y = 100, relative = true })
                                            }), { repeating = true, })

                    -- Mouse resizing and dragging.
                    hl.bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
                    hl.bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("window_workspace", function()
                    hl.bind("H", layoutBind({
                                  scrolling = hl.dsp.layout("focus left"),
                                  dwindle   = hl.dsp.focus({ direction = "left" }),
                                  master    = hl.dsp.layout("cycleprev"),
                                  monocle   = hl.dsp.layout("cycleprev"),
                    }))
                    hl.bind("L", layoutBind({
                                  scrolling = hl.dsp.layout("focus right"),
                                  dwindle   = hl.dsp.focus({ direction = "right" }),
                                  master    = hl.dsp.layout("cyclenext"),
                                  monocle   = hl.dsp.layout("cyclenext")
                    }))
                    hl.bind("K", layoutBind({
                                  scrolling = hl.dsp.layout("focus up"),
                                  dwindle   = hl.dsp.focus({ direction = "up" })
                    }))
                    hl.bind("J", layoutBind({
                                  scrolling = hl.dsp.layout("focus down"),
                                  dwindle   = hl.dsp.focus({ direction = "down" })
                    }))
                    hl.bind("SHIFT + H", layoutBind({
                                  scrolling = hl.dsp.layout("swapcol l"),
                                  dwindle = hl.dsp.window.move({ direction = "left" }),
                                  master = hl.dsp.layout("swapprev")
                    }))
                    hl.bind("SHIFT + L", layoutBind({
                                  scrolling = hl.dsp.layout("swapcol r"),
                                  dwindle = hl.dsp.window.move({ direction = "right" }),
                                  master = hl.dsp.layout("swapnext")
                    }))
                    hl.bind("SHIFT + K", layoutBind({
                                  scrolling = hl.dsp.window.move({ direction = "up" }),
                                  dwindle = hl.dsp.window.move({ direction = "up" })
                    }))
                    hl.bind("SHIFT + J", layoutBind({
                                  scrolling = hl.dsp.window.move({ direction = "down" }),
                                  dwindle = hl.dsp.window.move({ direction = "down" })
                    }))
                    hl.bind("M", layoutBind({
                                  scrolling = hl.dsp.layout("colresize +conf")
                    }))
                    hl.bind("SHIFT + M", layoutBind({
                                  scrolling = hl.dsp.layout("colresize -conf")
                    }))
                    hl.bind("SHIFT + LEFT", layoutBind({
                                  scrolling = hl.dsp.layout("consume_or_expel prev")
                    }))
                    hl.bind("SHIFT + RIGHT", layoutBind({
                                  scrolling = hl.dsp.layout("consume_or_expel next")
                    }))
                    hl.bind("SHIFT + F", layoutBind({
                                  scrolling = hl.dsp.layout("fit active")
                    }))
                    hl.bind("CTRL + F", layoutBind({
                                  scrolling = hl.dsp.layout("fit visible")
                    }))
                    hl.bind("F", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))

                    hl.bind("PRIOR",  hl.dsp.window.cycle_next({ floating = true }))
                    hl.bind("NEXT",  hl.dsp.window.cycle_next({ tiled = true }))
                    
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
                    
                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("layout", function()
                    hl.bind("S", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "scrolling" }) end)
                    hl.bind("D", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "dwindle" }) end)
                    hl.bind("M", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "master" }) end)
                    hl.bind("O", function() hl.workspace_rule({ workspace = hl.get_active_workspace().id, layout = "monocle" }) end)

                    -- Display current layout as a notification.
                    hl.bind("N", u.layoutNotify())

                    -- Cycling layouts forward/backward.
                    local layouts  = { "dwindle", "master", "scrolling", "monocle" }
                    local cycle = u.cycleLayouts(layouts)
                    hl.bind("K", cycle(true))
                    
                    hl.bind("J", cycle(false))

                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

local function barBind(bindTable)
   return function()
      local bar = p and p.statusBar

      if not bar then
         return
      end

      local action = bindTable[bar]

      if action then
         if type(action) == "function" then
            action()
         else
            hl.exec_cmd(action)
         end
      end
   end
end

hl.define_submap("status_bar", function()
                    hl.bind("S", barBind({
                                  noctalia = "noctalia msg settings-toggle"           
                    }))
                    hl.bind("H", barBind({
                                  noctalia = "noctalia msg bar-toggle"
                    }))
                    hl.bind("W", barBind({
                                  noctalia = "noctalia msg panel-toggle wallpaper"
                    }))
                    hl.bind("C", barBind({
                                  noctalia = "noctalia msg panel-toggle control-center"
                    }))
                    hl.bind("N", barBind({
                                  noctalia = "noctalia msg panel-toggle control-center notifications"
                    }))
                    hl.bind("D", barBind({
                                  noctalia = "noctalia msg panel-toggle control-center calendar"
                    }))
                    hl.bind("A", barBind({
                                  noctalia = "noctalia msg panel-toggle control-center audio"
                    }))

                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("volume", function()
                    hl.bind("K", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
                    hl.bind("SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

hl.define_submap("brightness", function()
                    hl.bind("K", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })

                    hl.bind("BackSpace", u.previousSubmap())
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
                    hl.bind("I", barBind({
                                  noctalia = "noctalia msg caffeine-toggle"
                    }))
                    hl.bind("Q", barBind({
                                  noctalia = function()
                                     hl.exec_cmd("noctalia msg panel-toggle session")
                                     hl.dispatch(hl.dsp.submap("reset"))
                                  end
                    }))
                    
                    hl.bind("BackSpace", u.previousSubmap())
                    hl.bind("ESCAPE", hl.dsp.submap("reset"))
end)

-- General keybindings that work for every layout.
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(p.terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(p.menu))
hl.bind(mainMod .. " + T", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + ESCAPE", hl.dsp.window.fullscreen({mode = "fullscreen", action = "toggle"}))
hl.bind("MOD5 + F", hl.dsp.window.fullscreen({mode = "maximized", action = "toggle"}))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mainMod .. " + PRINT", hl.dsp.exec_cmd("hyprshot -m window"))
hl.bind("PRINT", hl.dsp.exec_cmd("flameshot gui"))
hl.bind("SHIFT + PRINT", hl.dsp.exec_cmd("hyprshot -m region"))
hl.bind(mainMod .. " + F12", barBind({
              noctalia = "noctalia msg session lock"
}))
-- hl.bind("ALT + TAB", function()
--      This is for the overview.
-- end)

-- Be careful with this one as it doesn't ask and might be unnintentionally pressed.
hl.bind("CTRL + ALT + DELETE", hl.dsp.exec_cmd("hyprshutdown -t 'Shutting down...' --post-cmd 'shutdown -P 0'"))

hl.bind(mainMod .. " + PRIOR",  hl.dsp.window.cycle_next({ floating = true }))
hl.bind(mainMod .. " + NEXT",  hl.dsp.window.cycle_next({ tiled = true }))

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
