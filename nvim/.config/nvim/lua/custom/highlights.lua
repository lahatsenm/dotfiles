local M = {}

function M.setup()
  vim.cmd [[
    highlight Normal guifg=#E0E0E0 guibg=#282828
    highlight NonText guibg=none
    highlight Normal ctermbg=none
    highlight NonText ctermbg=none
    highlight NormalFloat guibg=none
    highlight FloatBorder guifg=#E0E0E0 guibg=none
    highlight CursorLine guibg=none
    highlight NormalFloat ctermbg=none
    highlight CursorLine ctermbg=none
    highlight LineNr guifg=#555555 guibg=none
    highlight CursorLineNr guifg=#FFFFFF guibg=none gui=bold
    highlight Comment guifg=#A4A4A4 guibg=none gui=italic
    highlight StatusLine guifg=#282828 guibg=#c3c3c3
    highlight TabLine guifg=#000000 guibg=#c3c3c3
    highlight TabLineSel guifg=white guibg=none
    highlight TabLineFill guibg=#c3c3c3
    highlight ElNormal guifg=#282828 guibg=none gui=bold
    highlight ElCommand guifg=#282828 guibg=none gui=bold
    highlight TelescopeMatching guifg=#ef9b44 gui=bold

    highlight Identifier guifg=#E0E0E0
    highlight @variable guifg=#E0E0E0
    highlight link @variable.builtin @variable
    highlight link @variable.parameter @variable
    highlight link @variable.parameter.builtin @variable
    highlight link @variable.member @variable

    highlight link @constant @variable
    highlight link @constant.builtin @variable
    highlight link @constant.macro @variable

    highlight link @module @variable
    highlight link @module.builtin @variable
    highlight link @label @variable

    highlight link @keyword @variable

    highlight link @function @variable
    highlight Function guifg=#E0E0E0

    highlight link @string @variable
    highlight String guifg=#E0E0E0

    highlight link @punctuation @variable

    highlight link @type @variable

    highlight link @character @variable

    highlight link @boolean @variable

    highlight link @number @variable

    highlight link @operator @variable

    highlight link @attribute @variable

    highlight link @property @variable

    highlight Constant guifg=#E0E0E0

    highlight Statement guifg=#E0E0E0 cterm=none gui=none

    highlight PreProc guifg=#E0E0E0

    highlight Type guifg=#E0E0E0

    highlight Special guifg=#E0E0E0 ctermfg=none

    highlight LspReferenceText guibg=none

    highlight Visual guibg=#515050

    highlight link @constructor @variable

    highlight link @constructor @variable

    highlight OilDir guifg=#E0E0E0

    highlight DapUIPlayPauseNC      guibg=none
    highlight DapUIStopNC           guibg=none
    highlight DapUIRestartNC        guibg=none
    highlight DapUIUnavailableNC    guibg=none
    highlight DapUIStepOverNC       guibg=none
    highlight DapUIStepIntoNC       guibg=none
    highlight DapUIStepBackNC       guibg=none
    highlight DapUIStepOutNC        guibg=none
  ]]
end

return M
