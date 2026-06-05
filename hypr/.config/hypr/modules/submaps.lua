-----------------
---- SUBMAPS ----
-----------------

-- Definitions of submaps.

local vars = require("modules.variables")
local utils = require("modules.utils")

-- "resize"
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
                                     local t = type(cmd)
                                     
                                     if t == "string" then
                                        hl.dispatch(hl.dsp.exec_cmd(cmd))
                                     else
                                        hl.dispatch(cmd)
                                     end
                                  end
                       end)
                    end

                    -- Mouse resizing and dragging.
                    hl.bind("mouse:272", hl.dsp.window.drag(),   { mouse = true })
                    hl.bind("mouse:273", hl.dsp.window.resize(), { mouse = true })
                    
                    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- "layout"
hl.define_submap("layout", function()
                    hl.bind("S", function() hl.workspace_rule({ workspace = vars.ws.id, layout = "scrolling" }) end)
                    hl.bind("D", function() hl.workspace_rule({ workspace = vars.ws.id, layout = "dwindle" }) end)
                    hl.bind("M", function() hl.workspace_rule({ workspace = vars.ws.id, layout = "master" }) end)
                    hl.bind("O", function() hl.workspace_rule({ workspace = vars.ws.id, layout = "monocle" }) end)
                    if hl.plugin.hy3 ~= nil then
                       hl.bind("H", function() hl.workspace_rule({ workspace = vars.ws.id, layout = "hy3" }) end)
                    end

                    -- Cycle scrolling/hy3 layouts.
                    hl.bind("Z", function()
                               utils.cycleLayouts({ general = false,
                                                    forward = true,
                                                    layouts = {
                                                       "scrolling",
                                                       "hy3",
                                                    },
                               })
                    end)
                    
                    -- Cycling layouts forward/backward.
                    hl.bind("K", function()
                               utils.cycleLayouts({ general = false,
                                                    forward = true,
                                                    layouts = vars.layoutNames,
                               })
                    end)
                    hl.bind("J", function()
                               utils.cycleLayouts({ general = false,
                                                    forward = false,
                                                    layouts = vars.layoutNames,
                               })
                    end)

                    --[[@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
                       These bindings below are useless in workspaces using
                       workspace rules because they require removing
                       these rules first and we don't have that feature yet.
                       I hope I get a good answer to this problem here:
                       https://github.com/hyprwm/Hyprland/discussions/14852
                       Edit: workspace rules removal will be implemented in v0.56.0, Thanks Vaxry.
                       https://github.com/hyprwm/Hyprland/issues/14876
                       
                       -- Cycle general layouts forward/backward.
                       hl.bind("SHIFT + K", function()
                       utils.cycleLayouts({ general = true,
                       forward = true,
                       layouts = vars.layoutNames,
                       
                       })
                       end)

                       hl.bind("SHIFT + J", function()
                       utils.cycleLayouts({ general = true,
                       forward = false,
                       layouts = vars.layoutNames,
                       
                       })
                       end)
                       --@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@]]
                    
                    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- status bar "sb"
hl.define_submap("sb", function()
                    local submaps = vars.sb
                       and vars.sb[vars.sb.name]
                       and vars.sb[vars.sb.name].binds
                       and vars.sb[vars.sb.name].binds.submaps

                    if submaps then
                       for key, cmd in pairs(submaps) do
                          hl.bind(key, function()
                                     if cmd then
                                        local t = type(cmd)
                                        
                                        if t == "string" then
                                           hl.dispatch(hl.dsp.exec_cmd(cmd))
                                        else
                                           hl.dispatch(cmd)
                                        end
                                     end
                          end)
                       end
                    end
                    
                    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- "volume"
hl.define_submap("volume", function()
                    hl.bind("K", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 3%+"), { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"),      { locked = true, repeating = true })
                    hl.bind("M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
                    hl.bind("SHIFT + M", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

                    hl.bind("catchall", hl.dsp.submap("reset"))
end)

-- "brightness"
hl.define_submap("brightness", function()
                    hl.bind("K", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("J", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })
                    hl.bind("L", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%+"),  { locked = true, repeating = true })
                    hl.bind("H", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 3%-"),  { locked = true, repeating = true })

                    hl.bind("catchall", hl.dsp.submap("reset"))
end)
