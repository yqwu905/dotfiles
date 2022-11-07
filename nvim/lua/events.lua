vim.cmd[[
au FileType qmd setl filetype=markdown
augroup latex
  au FileType tex AsyncRun -mode=hide inkscape-figures watch
]]

