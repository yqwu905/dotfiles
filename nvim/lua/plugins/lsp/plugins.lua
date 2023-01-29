-- LSP relevant plugins.
local reg = require('core.lazy').reg
local conf = require('plugins.lsp.config')
local lspconfig = require('plugins.lsp.lspconfig')

local enable_lsp_filetype = {
  'julia',
  'tex',
  'sh',
  'c',
  'cpp',
  'python',
  'markdown',
  'typescript',
  'json',
  'toml',
  'lua',
  'cmake'
}

reg {
  'neovim/nvim-lspconfig',
  config = lspconfig,
  ft = enable_lsp_filetype
}
reg {
  'glepnir/lspsaga.nvim',
  after = 'nvim-lspconfig',
  config = conf.lspsaga,
}
reg {
  'j-hui/fidget.nvim',
  after = 'nvim-lspconfig',
  config = conf.fidget,
}
