---------------------------
---- UTILITY FUNCTIONS ----
---------------------------

local M = {}

-- Function that notifies about the current layout.
function M.layoutNotify()
   local layoutColors = {
      dwindle   = "rgb(bd93f9)",
      master    = "rgb(ffb86c)",
      scrolling = "rgb(00ffd5)",
      monocle   = "rgb(ff79c6)",
   }
   hl.exec_scheduled_prop_refresh_immediately()
   local currentLayout = hl.get_active_workspace().tiled_layout
   local color = layoutColors[currentLayout] or 'rgb(b5b5b3)'
   local capitalized = currentLayout:gsub("^%l", string.upper)
   hl.notification.create({ text = "Layout: " .. capitalized, timeout = 2500, color = color })
end

-- For cycling layouts
local layoutIndex = 1

function M.cycleLayouts(layoutInfo)
   layoutInfo = layoutInfo or { forward = true,
                                layouts = { "scrolling",
                                            "dwindle" }
                              }
   if layoutInfo.forward then
      if layoutIndex == #layoutInfo.layouts then
         layoutIndex = 1
      else
         layoutIndex = layoutIndex + 1
      end
   else
      if layoutIndex == 1 then
         layoutIndex = #layoutInfo.layouts
      else
         layoutIndex = layoutIndex - 1
      end
   end

   local ws = hl.get_active_workspace()
   local currentLayout = ws.tiled_layout
   local nextLayout = layoutInfo.layouts[layoutIndex]

   if currentLayout ~= nextLayout then
      hl.workspace_rule({
            workspace = ws.id,
            layout = nextLayout,
      })
   end
end

-- Submaps Data
local submaps = {
   history = {},
   index = 0,
}

function M.processSubmap(submap)
   if submap == "" then
      -- Reset means new submap history.
      submaps.history = {}
      submaps.index = 0
   else
      -- Keep a record of previous submaps.
      populateSubmapHistory(submap)
   end
end

function populateSubmapHistory(submap)
   local insert = true
   -- Keep track of previous submaps so that we can go back to each one of them.
   for i = 1, #submaps.history do
      if submaps.history[i] == submap then
         insert = false
         break
      end
   end

   if insert then
      table.insert(submaps.history, submap)
      submaps.index = #submaps.history
   end
end

function M.previousSubmap()
   table.remove(submaps.history)
   submaps.index = #submaps.history
   local index = submaps.index
   
   if index == 0 then
      hl.dispatch(hl.dsp.submap("reset"))
   else
      hl.dispatch(hl.dsp.submap(submaps.history[index]))
   end
end

return M
