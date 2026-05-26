---------------------------
---- UTILITY FUNCTIONS ----
---------------------------

local vars = require("modules.variables")
local M = {}

-- Function that selects and uses the appropriate dispatcher
-- based on the current layout
function M.action(layoutTable, sharedLayouts, sharedDispatcher)
   if sharedLayouts and #sharedLayouts ~= 0 and sharedDispatcher then      
      for _, layout in ipairs(sharedLayouts) do
         layoutTable[layout] = sharedDispatcher
      end
      -- else -- for debugging purposes only
      --    local cmd = string.format("hyprctl notify -1 2500 'rgb(00ffd5)' 'NO NO NO'")
      --    hl.dispatch(hl.dsp.exec_cmd(cmd))
   end
   
   -- get current layout
   local layout = hl.get_config("general.layout")

   -- use appropriate dispatcher
   if layoutTable[layout] then
      hl.dispatch(layoutTable[layout])
   end
end

-- Function that notifies when switching layout
function M.layoutSwitchNotify()
   local layout = hl.get_config("general.layout")
   local capitalized = layout:gsub("^%l", string.upper)
   local color = vars.layoutColors[layout]
   local cmd = nil
   
   cmd = string.format("hyprctl notify -1 2500 '%s' 'Layout: %s'", color, capitalized)
   hl.dispatch(hl.dsp.exec_cmd(cmd))
end

return M
