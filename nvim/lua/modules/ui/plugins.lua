-- UI plugins.
local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')


plugin { 'folke/tokyonight.nvim', config = conf.tokyonight }
plugin { 'kyazdani42/nvim-web-devicons' }
plugin {
  'nvim-tree/nvim-tree.lua',
  config = conf.nvimtree,
  cmd = 'NvimTreeToggle',
  requires = 'kyazdani42/nvim-web-devicons'
}
plugin {
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
}
plugin {
  'akinsho/bufferline.nvim',
  config = conf.bufferline,
}
plugin {
  'goolord/alpha-nvim',
  config = conf.alpha,
}
plugin {
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline
}
plugin { 'folke/which-key.nvim' }
plugin {
  'folke/trouble.nvim',
  config = conf.trouble
}
