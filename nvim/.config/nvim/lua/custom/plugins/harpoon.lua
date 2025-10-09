return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    vim.keymap.set('n', '<leader>a', function()
      harpoon:list():add()
    end, { desc = '[harpoon]: add current file to list' })
    vim.keymap.set('n', '<leader>y', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = '[harpoon]: toggle quick menu' })

    -- Set <space>1..<space>5 be my shortcuts to moving to the files
    for _, idx in ipairs { 1, 2, 3, 4, 5 } do
      vim.keymap.set('n', string.format('<A-%d>', idx), function()
        harpoon:list():select(idx)
      end, { desc = string.format('[harpoon]: move to file %d', idx) })
    end
  end,
}
