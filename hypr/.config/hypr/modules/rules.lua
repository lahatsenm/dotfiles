------------------------------------
---- WINDOW AND WORKSPACE RULES ----
------------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Window rules that are useful
local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.window_rule({
      match = {
         class = "^org.kde.dolphin$",
      },

      workspace = "3 silent",
})

hl.window_rule({
      match = {
         class = "^brave-browser$",
      },

      workspace = "2 silent",
})

hl.window_rule({
      match = {
         class = "^pavucontrol-qt$",
      },

      float = true,
      size = {842, 512},
})

hl.window_rule({
      match = {
         class = "^org.gnome.Calendar$",
      },

      float = true,
      size = {1109, 799},
})

hl.window_rule({
      match = {
         class = "^io.missioncenter.MissionCenter$",
      },

      float = true,
      size = {1160, 761},
})

hl.window_rule({
      match = {
         class = "waypaper",
      },

      float = true,
      size = {882, 965},
})

hl.window_rule({
      match = {
         class = "^org.kde.gwenview$",
      },

      float = true,
      size = {925, 1001},
})

hl.window_rule({
      match = {
         class = "^io.github.Qalculate.qalculate-qt$",
      },

      float = true,
      size = {1104, 787},
})

hl.window_rule({
      match = {
         float = true,
      },

      animation = "popin",
})
