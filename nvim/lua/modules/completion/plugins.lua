-- Plugins provided auto completion.
local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')


plugin {
  'SirVer/ultisnips',
  -- event = 'InsertEnter',
}
plugin {
  'quangnguyen30192/cmp-nvim-ultisnips',
  event = 'InsertEnter',
}
plugin {
  'hrsh7th/nvim-cmp',
  config = conf.cmp,
  -- event = 'InsertEnter',
  requires = {
    {'hrsh7th/cmp-path', after = 'nvim-cmp'},
    {'hrsh7th/cmp-buffer', after = 'nvim-cmp'},
    {'hrsh7th/cmp-cmdline', after = 'nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp', after = 'nvim-lspconfig'},
  },
}
plugin {
  'windwp/nvim-autopairs',
  config = conf.autopairs,
  event = 'InsertEnter',
}
