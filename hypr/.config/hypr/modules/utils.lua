---------------------------
---- UTILITY FUNCTIONS ----
---------------------------

local vars = require("modules.variables")
local M = {}

-- Function that selects and uses the appropriate dispatcher
-- based on the current layout
-- This function is the old way of setting up layout specific
-- keybindings. Now, the configuration uses layouts table.
function M.action(layouts, sharedLayouts, sharedDispatcher)
   if sharedLayouts and #sharedLayouts ~= 0 and sharedDispatcher then      
      for _, layout in ipairs(sharedLayouts) do
         layouts[layout] = sharedDispatcher
      end
      -- else -- for debugging purposes only
      --    local cmd = string.format("hyprctl notify -1 2500 'rgb(00ffd5)' 'NO NO NO'")
      --    hl.dispatch(hl.dsp.exec_cmd(cmd))
   end
   
   -- get current layout
   -- local layout = hl.get_config("general.layout")
   local layout = hl.get_active_workspace().tiled_layout -- again, this is the best call for my current setup

   -- use appropriate dispatcher
   if layouts[layout] then
      hl.dispatch(layouts[layout])
   end
end

-- Function that notifies about the current layout
function M.layoutNotify(layout)
   layout = layout or hl.get_active_workspace().tiled_layout
   local color = vars.layouts[layout].color
   local capitalized = layout:gsub("^%l", string.upper)
   cmd = string.format("hyprctl notify -1 2500 '%s' 'Layout: %s'", color, capitalized)

   hl.dispatch(hl.dsp.exec_cmd(cmd))
end

-- Function to cycle layouts
function M.cycleLayouts(layoutInfo)
   layoutInfo = layoutInfo or { general = false,
                                forward = true,
                                layouts = {
                                   "scrolling",
                                   "dwindle",
                                },
                              }
   local layout = nil
   local nextLayout = nil
   
   -- direction: forward/backward
   if layoutInfo.forward then
      vars.index = vars.index + 1
      if vars.index > #layoutInfo.layouts then
         vars.index = 1
      end
   else 
      vars.index = vars.index - 1
      if vars.index < 1 then
         vars.index = #layoutInfo.layouts
      end
   end

   -- Get the next layout
   nextLayout = layoutInfo.layouts[vars.index]
   
   if layoutInfo.general then
      layout = hl.get_config("general.layout")
      
      if layout ~= nextLayout then
         hl.config({
               general = { layout = nextLayout }
         })
      end
   else
      local ws = hl.get_active_workspace()
      layout = ws.tiled_layout
      
      if layout ~= nextLayout then
         hl.workspace_rule({ workspace = ws.id, layout = nextLayout })
      end
   end

   -- Update the current layout
   layout = nextLayout
   -- Display the current layout
   M.layoutNotify(layout)
end

return M
