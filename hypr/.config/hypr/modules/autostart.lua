-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

local vars = require("modules.variables")

hl.on("hyprland.start", function () 
  hl.exec_cmd(vars.statusBar)
  hl.exec_cmd(vars.launcherDaemon)
  hl.exec_cmd(vars.polkit)
  hl.exec_cmd("hyprpm reload -n")
  hl.exec_cmd(vars.screenShot)
  hl.exec_cmd(vars.idleDaemon)
  hl.exec_cmd(vars.editor)
  hl.exec_cmd(vars.browser)
end)
