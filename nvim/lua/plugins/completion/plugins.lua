local reg = require('core.lazy').reg
local conf = require('plugins.completion.config')


reg {
  'SirVer/ultisnips',
  event = 'InsertEnter',
}
reg {
  'quangnguyen30192/cmp-nvim-ultisnips',
  event = 'InsertEnter',
}
reg {
  'hrsh7th/nvim-cmp',
  config = conf.cmp,
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig' },
  },
}
reg {
  'windwp/nvim-autopairs',
  config = conf.autopairs,
  event = 'InsertEnter',
}
