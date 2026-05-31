local M = {}

function M.setup()
   if hl.plugin.hy3 ~= nil then
      hl.config({
            plugin = {
               hy3 = {
                  tabs = {
                     radius = 0,
                  },
               },
            },
      })
   end
end

return M
