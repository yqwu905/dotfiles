-- Base plugins that provide basic function for other plugins.
local plugin = require('core.pack').register_plugin
local conf = require('modules.base.config')

plugin { 'lewis6991/impatient.nvim' }
plugin { 'nvim-lua/popup.nvim' }
plugin { 'nvim-lua/plenary.nvim' }
plugin {
  'nvim-treesitter/nvim-treesitter',
  event = 'BufRead',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
}
plugin { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
plugin { 'skywind3000/asyncrun.vim' }
plugin {
  'rcarriga/nvim-notify',
  config = conf.notify
}
plugin {
  'nathom/filetype.nvim',
  config = conf.filetype
}
