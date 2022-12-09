-- Plugins provided edit and move enhancement.
local plugin = require('core.pack').register_plugin
local conf = require('modules.editor.config')

plugin { 'tpope/vim-surround' }
plugin {
  'numToStr/Comment.nvim',
  config = conf.comment,
}
plugin {
  'phaazon/hop.nvim',
  config = conf.hop
}
plugin { 'hrsh7th/vim-eft' }
plugin { 'rhysd/accelerated-jk' }
