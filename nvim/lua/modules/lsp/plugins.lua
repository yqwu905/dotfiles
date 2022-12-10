-- LSP relevant plugins.
local plugin = require('core.pack').register_plugin
local conf = require('modules.lsp.config')
local lspconfig = require('modules.lsp.lspconfig')

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

plugin {
  'neovim/nvim-lspconfig',
  config = lspconfig,
  ft = enable_lsp_filetype
}
plugin {
  'glepnir/lspsaga.nvim',
  after = 'nvim-lspconfig',
  config = conf.lspsaga,
}
plugin {
  'j-hui/fidget.nvim',
  after = 'nvim-lspconfig',
  config = conf.fidget,
}
