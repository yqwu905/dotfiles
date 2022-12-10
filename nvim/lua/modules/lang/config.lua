local config = {}

function config.vimtex()
  vim.g.tex_flavor = 'latex'
  vim.g.vimtex_view_method = 'zathura'
  vim.g.vimtex_compiler_progname = 'nvr'
  vim.g.vimtex_compiler_method = 'latexmk'
  vim.g.vimtex_fold_enabled = true
  vim.g.vim_markdown_math = 1
  -- 禁止Vimtex自动打开Quickfix
  vim.g.vimtex_quickfix_mode = 0
end

return config
