local reg = require('core.lazy').reg
local conf = require('plugins.editor.config')


reg {
  'tpope/vim-surround',
  event = 'VeryLazy',
}
reg {
  'numToStr/Comment.nvim',
  config = conf.comment,
  lazy = true,
}
reg {
  'phaazon/hop.nvim',
  -- event = 'VeryLazy',
  config = conf.hop,
  cmd = 'HopWord',
}
reg {
  'hrsh7th/vim-eft',
  event = 'VeryLazy',
}
reg {
  'rhysd/accelerated-jk',
  event = 'VeryLazy',
}
