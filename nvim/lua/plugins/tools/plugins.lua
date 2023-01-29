local reg = require('core.lazy').reg
local conf = require('plugins.tools.config')

reg {
  'nvim-telescope/telescope.nvim',
  config = conf.telescope,
  cmd = 'Telescope',
}
reg {
  'nvim-telescope/telescope-fzf-native.nvim',
  run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
  lazy = true
}
reg {
  'rlue/vim-barbaric',
  event = 'InsertEnter'
}
reg {
  'norcalli/nvim-colorizer.lua',
  config = conf.colorizer,
}
reg {
  'TimUntersberger/neogit',
  cmd = 'Neogit',
}
reg {
  'lewis6991/gitsigns.nvim',
  config = conf.gitsigns,
  event = 'BufRead',
}
reg { 'f-person/git-blame.nvim' }
