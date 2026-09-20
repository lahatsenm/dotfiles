------------------
----- EVENTS -----
------------------

local p = require("modules.programs")
local u = require("modules.utils")

hl.on("hyprland.start", function()
         -- Autostart necessary processes (like notifications daemons, status bars, etc.)
         -- See https://wiki.hypr.land/Configuring/Basics/Autostart/
         -- I have to use table.pack() here to handle nil values.
         local programs = table.pack(
            p.hyprpm,
            p.statusBar,
            p.menuDaemon,
            p.polkit,
            p.idleDaemon,
            p.screenShot,
            p.editor,
            p.terminal,
            p.browser
         )
         -- Run programs one by one.
         for i = 1, programs.n do
            if programs[i] ~= nil then
               hl.exec_cmd(programs[i])
            end
         end
end)

hl.on("keybinds.submap", function(submap)
         u.processSubmap(submap)
end)

hl.on("config.reloaded", function()
         -- Reset submap when config reloads.
         -- It looks like calling hl.dispatch(hl.dsp.submap("reset")) directly
         -- makes Hyprland crash at startup. So, it is necessary to
         -- only reset a submap when there is exactly one active.
         if hl.get_current_submap() ~= "" then
            hl.dispatch(hl.dsp.submap("reset"))
         end
end)
