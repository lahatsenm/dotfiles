-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

local vars = require("modules.variables")

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
