return {
  {
    'andymass/vim-matchup',
    event = 'CursorMoved', -- Lazy load on cursor movement
    config = function()
      require('custom.matchup').setup()
    end,
  },
}
