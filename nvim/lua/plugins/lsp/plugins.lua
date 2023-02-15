-- LSP relevant plugins.
local reg = require('core.lazy').reg
local conf = require('plugins.lsp.config')
local lspconfig = require('plugins.lsp.lspconfig')

reg {
  'neovim/nvim-lspconfig',
  config = lspconfig,
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

reg {
  'jose-elias-alvarez/null-ls.nvim',
  config = conf.nullls,
}
