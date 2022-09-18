vim.cmd[[
augroup latex
  au FileType tex AsyncRun -mode=hide inkscape-figures watch
]]
