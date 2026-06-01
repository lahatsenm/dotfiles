------------------
----- EVENTS -----
------------------

local vars = require("modules.variables")
local utils = require("modules.utils")

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
-- Autostart necessary processes (like notifications daemons, status bars, etc.)
hl.on("hyprland.start", function ()
         -- I have to use table.pack() here to handle nil values.
         local programs = table.pack(
            vars.hyprpm,
            vars.sb[vars.sb.name].daemon,
            vars.sb[vars.sb.name].cmd,
            vars.menuDaemon,
            vars.polkit,
            vars.screenShot,
            vars.idleDaemon,
            vars.editor,
            vars.browser
         )
         -- Run programs one by one.
         for i = 1, programs.n do
            if programs[i] ~= nil then
               hl.exec_cmd(programs[i])
            end
         end
end)

-- Things to do when monitor arrangements changes (like config, layout, workspace rules, monitor resolution, ...)
hl.on("monitor.layout_changed", function()
         -- It looks like this event is called multiple times
         -- because something like this:
         --     vars.currentLayout = hl.get_active_workspace().tiled_layout
         --     utils.layoutNotify()
         -- will give two notifications and that is not what I want. So,
         -- I need to make sure that it will notify me only when the
         -- layout has changed and that needs a comparison:
         -- First, we get the new layout
         local newLayout = hl.get_active_workspace().tiled_layout
         -- Next we compare the current layout to the new one
         -- and notify me only if they are different.
         -- This ensures that we get exactly one notification.
         if vars.currentLayout ~= newLayout then
            -- Update the current layout.
            vars.currentLayout = newLayout
            utils.layoutNotify()
         end
end)

-- Things to do when active workspace changes.
hl.on("workspace.active", function(ws)
         vars.currentLayout = hl.get_active_workspace().tiled_layout
end)
