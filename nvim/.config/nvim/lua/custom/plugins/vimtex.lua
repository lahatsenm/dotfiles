return {
  'lervag/vimtex',
  ft = { 'tex', 'latex' }, -- Load only for LaTeX files
  lazy = false, -- Disable lazy loading (set to true if you prefer lazy loading)
  enabled = true, -- Enable this plugin
  config = function()
    require 'custom.vimtex' -- Load the VimTeX configuration
  end,
}
