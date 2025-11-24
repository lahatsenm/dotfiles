-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
-- This table will hold the configuration.
local config = {
   max_fps = 120,
   animation_fps = 120,
}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
   config = wezterm.config_builder()
end

-- Disable the "Beep Sound"
config.audible_bell = "Disabled"

-- Remove title bar and enable resizable border
-- config.window_decorations = "RESIZE"

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
-- config.color_scheme = "Batman"
-- config.color_scheme = "GruvboxDark"
-- config.color_scheme = 'nord'
config.color_scheme = 'Solarized (dark) (terminal.sexy)'

-- Set tab_bar colors to solarized theme
config.colors = {
   cursor_bg = "#93a1a1",    
   cursor_border = "#93a1a1",
  
   tab_bar = {
      -- Active tab colors
      active_tab = {
         bg_color = "#002b36", 
         fg_color = "#839496", 
         intensity = "Bold",
      },

      -- Inactive tab colors
      inactive_tab = {
         bg_color = "#073642", 
         fg_color = "#586e75", 
      },

      -- Inactive tab when hovered
      inactive_tab_hover = {
         bg_color = "#586e75", 
         fg_color = "#93a1a1", 
         italic = true,
      },

      -- New tab button colors
      new_tab = {
         bg_color = "#073642", 
         fg_color = "#586e75", 
      },

      -- Hover on new tab button
      new_tab_hover = {
         bg_color = "#586e75", 
         fg_color = "#93a1a1", 
         italic = true,
      },

      -- Tab bar background behind tabs
      background = "#002b36", 
   },
}

-- -- Set background to the same color as neovim, as well
-- -- config.colors.background = "#111111"
-- config.colors.background = "#282828"
-- -- config.colors.background = "#1d2021"

--- config.window_background_opacity = 1.0

config.font = wezterm.font_with_fallback({
      {
         family = "TX-02-XlabMono",
         harfbuzz_features = { "ss02" },
      },
      
      "Noto Sans Symbols2",      -- good fallback for misc symbols
      "Noto Sans CJK KR",        -- covers Korean/circled glyphs
      "Symbols Nerd Font Mono",

      {
    	family = "JetBrainsMono Nerd Font",
    	harfbuzz_features = { "cv01", "cv08", "cv12" },
      },

      -- {
      -- 	family = "Fira Code Nerd Font",
      -- 	harfbuzz_features = { "cv01", "cv02", "cv09", "cv14", "ss03" },
      -- },

      -- "Roboto Mono Nerd Font",
      --

      -- {
      --    family = "Iosevka",
      --    harfbuzz_features = { "dlig" },
      -- },

      -- "Noto Sans Mono",
      -- "CodeNewRoman Nerd Font",
      -- {
      --    family = "Comic Code",
      --    -- harfbuzz_features = { "dlig" },
      -- },
})

config.font_size = 13.0

-- config.underline_position = "-2px"
-- config.line_height = 1.1

-- default is true, has more "native" look
config.use_fancy_tab_bar = false

-- I don't like putting anything at the ege if I can help it.
config.enable_scroll_bar = false
config.window_padding = {
   left = 0,
   right = 0,
   top = 0,
   bottom = 0,
}

config.tab_bar_at_bottom = true
config.hide_tab_bar_if_only_one_tab = true
config.freetype_load_target = "HorizontalLcd"

-- Key bindings
config.keys = {}
for i = 1, 8 do
   -- CTRL+ALT + number to activate that tab
   table.insert(config.keys, {
                   key = tostring(i),
                   mods = "CTRL",
                   action = act.ActivateTab(i - 1),
   })
   -- -- F1 through F8 to activate that tab (deactivate it for now since I'm using some of those keys for DAP)
   -- table.insert(config.keys, {
   -- 	key = "F" .. tostring(i),
   -- 	action = act.ActivateTab(i - 1),
   -- })
end

for i = 1, 8 do
   -- CTRL+ALT + number to move to that position
   table.insert(config.keys, {
                   key = tostring(i),
                   mods = "CTRL|ALT",
                   action = act.MoveTab(i - 1),
   })
end

-- Activate relative tab
table.insert(config.keys, {
                key = "{",
                mods = "ALT",
                action = act.ActivateTabRelative(-1),
})
--
table.insert(config.keys, {
                key = "}",
                mods = "ALT",
                action = act.ActivateTabRelative(1),
})
--
-- Create a new tab in the same domain as the current pane.
table.insert(config.keys, {
                key = "c",
                mods = "CTRL|ALT",
                action = act.SpawnTab("CurrentPaneDomain"),
})
--
-- Close current tab
table.insert(config.keys, {
                key = "w",
                mods = "CTRL|ALT",
                action = wezterm.action.CloseCurrentTab({ confirm = true }),
})

-- and finally, return the configuration to wezterm
return config
