local reg = require('core.lazy').reg
local conf = require('plugins.ui.config')

reg {
  'rcarriga/nvim-notify',
  init = conf.notify,
  lazy = true,
}
reg {
  'folke/tokyonight.nvim',
  priority = 1000
}
reg {
  'nvim-tree/nvim-tree.lua',
  config = conf.nvimtree,
  cmd = {'NvimTreeToggle', 'NvimTreeClose', 'NvimTreeToggle'},
}
reg {
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
}
reg {
  'akinsho/bufferline.nvim',
  config = conf.bufferline,
  event = 'VeryLazy',
}
reg {
  'goolord/alpha-nvim',
  config = conf.alpha,
}
reg {
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  event = 'VeryLazy',
}
reg {
  'folke/which-key.nvim',
  lazy = true
}
reg {
  'folke/trouble.nvim',
  config = conf.trouble,
  cmd = 'Trouble'
}
reg { 'stevearc/dressing.nvim' }
