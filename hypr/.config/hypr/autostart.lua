-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)

hl.on("hyprland.start", function () 
  hl.exec_cmd("dms run")
  hl.exec_cmd("vicinae server")
  hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
  hl.exec_cmd("hyprpm reload -n")
  hl.exec_cmd("flameshot & swayidle")
  hl.exec_cmd("emacs")
  hl.exec_cmd("brave")
end)
