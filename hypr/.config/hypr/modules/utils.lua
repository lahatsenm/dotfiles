---------------------------
---- UTILITY FUNCTIONS ----
---------------------------

local vars = require("modules.variables")
local M = {}

-- Function that selects and uses the appropriate dispatcher
-- based on the current layout
-- This function is the old way of using layout specific
-- keybindings. Now, the configuration uses layout binding tables.
function M.action(layoutNames, sharedLayouts, sharedDispatcher)
   if sharedLayouts and #sharedLayouts ~= 0 and sharedDispatcher then      
      for _, layout in ipairs(sharedLayouts) do
         layoutNames[layout] = sharedDispatcher
      end
      -- else -- for debugging purposes only
      --    local cmd = string.format("hyprctl notify -1 2500 'rgb(00ffd5)' 'NO NO NO'")
      --    hl.dispatch(hl.dsp.exec_cmd(cmd))
   end
   
   -- get current layout
   local layout = hl.get_config("general.layout")

   -- use appropriate dispatcher
   if layoutNames[layout] then
      hl.dispatch(layoutNames[layout])
   end
end

-- Function that notifies when switching layout
function M.layoutSwitchNotify()
   local layout = hl.get_config("general.layout")
   local capitalized = layout:gsub("^%l", string.upper)
   local color = vars.layoutColors[layout]
   local cmd = string.format("hyprctl notify -1 2500 '%s' 'Layout: %s'", color, capitalized)
   
   hl.dispatch(hl.dsp.exec_cmd(cmd))
end

-- Function to cycle layouts forward/backward
function M.cycleLayouts(forward)
   forward = forward or 1

   if forward == 1 then
      vars.index = vars.index + 1
      if vars.index > #vars.layoutNames then
         vars.index = 1
      end
   elseif forward == -1 then
      vars.index = vars.index - 1
      if vars.index < 1 then
         vars.index = #vars.layoutNames
      end
   end

   local layout = hl.get_config("general.layout")

   if layout ~= vars.layoutNames[vars.index] then
      hl.config({
            general = { layout = vars.layoutNames[vars.index] }
      })
   end
   
   -- display the current layout
   M.layoutSwitchNotify()
end

-- Function to toggle between two layouts
function M.toggleLayouts(firstLayout, secondLayout)
   -- Get the current layout
   local layout = hl.get_config("general.layout")

   if layout == firstLayout then
      hl.config({
            general = { layout = secondLayout }
      })
   else
      hl.config({
            general = { layout = firstLayout }
      })
   end

   -- Display the curent layout
   M.layoutSwitchNotify()
end

return M
