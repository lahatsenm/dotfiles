-- VimTeX Configuration
vim.g.vimtex_view_method = 'general'
vim.g.vimtex_view_general_viewer = 'okular'
vim.g.vimtex_view_general_options = '--unique file:@pdf\\#src:@line@tex'
vim.g.vimtex_compiler_method = 'latexmk' -- Use latexmk for compilation
vim.g.vimtex_quickfix_mode = 0 -- Disable quickfix by default

-- Additional keybindings for VimTeX
vim.api.nvim_set_keymap('n', '<leader>ll', ':VimtexCompile<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>lv', ':VimtexView<CR>', { noremap = true, silent = true })
