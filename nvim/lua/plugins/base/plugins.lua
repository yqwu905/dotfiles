local reg = require('core.lazy').reg
local conf = require('plugins.base.config')

reg { 'nvim-lua/popup.nvim', lazy=true }
reg { 'nvim-lua/plenary.nvim', lazy=true }
reg {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  }
}
reg {
  'skywind3000/asyncrun.vim',
  cmd = 'AsyncRun',
}
reg {
  'kyazdani42/nvim-web-devicons',
  lazy = true
}
