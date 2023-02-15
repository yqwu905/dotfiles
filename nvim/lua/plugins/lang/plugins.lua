local reg = require('core.lazy').reg
local conf = require('plugins.lang.config')

reg {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = { 'markdown' }
}
reg {
  'lervag/vimtex',
  config = conf.vimtex,
  ft = { 'tex', 'markdown', 'latex' }
}
reg {
  'nvim-neorg/neorg',
  commit = 'a79bf5969e27a3f1f1478c9b05c187815f2b2390',
  config = conf.neorg,
  build = ':Neorg sync-parsers',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neorg/neorg-telescope',
  },
  cmd = { 'Neorg' },
  ft = { 'norg' },
}

reg {
  'simrat39/rust-tools.nvim',
  config = conf.rust_tools,
}
