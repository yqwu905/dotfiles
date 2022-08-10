return function()
  vim.g.tex_flavor = "latex"
  vim.g.vimtex_view_general_viewer = "SumatraPDF.exe"
  vim.g.vimtex_view_general_options = "-reuse-instance -forward-search @tex @line @pdf"
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_fold_enabled = true
  -- 禁止Vimtex自动打开Quickfix
  vim.g.vimtex_quickfix_mode = 0
end
