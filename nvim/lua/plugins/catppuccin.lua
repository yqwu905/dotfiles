return function()
  vim.g.catppuccin_flavour = "mocha"
  vim.cmd("colorscheme catppuccin")
  vim.cmd[[
  highlight DiagnosticHint cterm=NONE ctermbg=0 ctermfg=16 gui=NONE guifg=#94E2D5 guibg=NONE
  highlight DiagnosticInfo cterm=NONE ctermbg=0 ctermfg=16 gui=NONE guifg=#89DCEB guibg=NONE
  highlight DiagnosticWarn cterm=NONE ctermbg=0 ctermfg=16 gui=NONE guifg=#F9E2AF guibg=NONE
  highlight DiagnosticError cterm=NONE ctermbg=0 ctermfg=16 gui=NONE guifg=#F38BA8 guibg=NONE
  ]]

end
