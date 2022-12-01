-- Addtional Tools.
local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
}
plugin { 'rlue/vim-barbaric' }
plugin {
  'norcalli/nvim-colorizer.lua',
  config = conf.colorizer,
}
plugin {
  'hkupty/iron.nvim',
  config = conf.iron,
  ft = {'julia'},
}
plugin {
  'TimUntersberger/neogit',
  cmd = 'Neogit',
}
plugin {
  'lewis6991/gitsigns.nvim',
  config = conf.gitsigns,
  event = 'BufRead',
}
plugin {
  'numToStr/FTerm.nvim',
  config = conf.fterm
}
