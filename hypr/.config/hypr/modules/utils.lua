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
      -- hl.notification.create({ text = "NO NO NO ", timeout = 2500, color = "rgb(00ffd5)" })
   end
   
   -- get current layout
   local layout = vars.currentLayout

   -- use appropriate dispatcher
   if layouts[layout] then
      hl.dispatch(layouts[layout])
   end
end

-- Function that notifies about the current layout
function M.layoutNotify()
   local color = vars.layouts[vars.currentLayout].color
   local capitalized = vars.currentLayout:gsub("^%l", string.upper)
   hl.notification.create({ text = "Layout: " .. capitalized, timeout = 2500, color = color })
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
   local nextLayout = nil
   
   -- Direction: forward/backward
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
      if vars.currentLayout ~= nextLayout then
         hl.config({
               general = { layout = nextLayout }
         })
      end
   else
      local ws = hl.get_active_workspace()
      
      if vars.currentLayout ~= nextLayout then
         hl.workspace_rule({ workspace = ws.id, layout = nextLayout })
      end
   end
end

return M
