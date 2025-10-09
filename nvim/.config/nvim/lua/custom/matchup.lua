local M = {}

M.setup = function()
  -- Enable vim-matchup features
  vim.g.matchup_matchparen_enabled = 1 -- Enable MatchParen highlighting for more elements (including quotes)
  vim.g.matchup_delim_noskips = 1 -- Match quotes even when they are surrounded by text

  -- Explicitly include quotes in matching
  vim.g.matchup_delim_start_plaintext = 1 -- Match plain text quotes
  vim.g.matchup_matchquotes = 1 -- Enable quote matching
  vim.g.matchup_override_vimtex = 1

  -- Default behavior: disable
  vim.g.matchup_matchparen_offscreen = {
    method = 'disable',
  }

  -- Function to toggle the off-screen match method
  function _G.toggle_matchparen_offscreen()
    if vim.g.matchup_matchparen_offscreen and vim.g.matchup_matchparen_offscreen.method == 'popup' then
      -- Disable the popup
      vim.g.matchup_matchparen_offscreen = { method = 'disable' }
    else
      -- Enable the popup with custom settings
      vim.g.matchup_matchparen_offscreen = {
        method = 'popup',
        fullwidth = true,
        border = 'rounded',
      }
    end

    -- Force the popup to update immediately after toggling
    -- This triggers vim-matchup to check the current match and show the popup
    vim.cmd 'silent! call matchup#matchparen#update()'
  end

  -- Keybinding to toggle the offscreen method
  vim.keymap.set('n', '<leader>p', ':lua toggle_matchparen_offscreen()<CR>', { noremap = true, silent = true, desc = 'Toggle off-screen match' })

  -- Optional: Fine-tune timeout settings for matching
  -- vim.g.matchup_matchparen_timeout = 200
  -- vim.g.matchup_matchparen_offscreen = {}

  -- Customize highlights for MatchParen
  vim.cmd [[
    highlight MatchParen guifg=yellow guibg=none gui=bold
  ]]
end

return M
