-- Language specific plugins.
local plugin = require('core.pack').register_plugin
local conf = require('modules.lang.config')

plugin {
  'iamcco/markdown-preview.nvim',
  run = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = { 'markdown' }
}
plugin {
  'lervag/vimtex',
  config = conf.vimtexm,
  ft = { 'tex', 'markdown', 'latex' }
}
plugin {
  'nvim-neorg/neorg',
  commit = 'a79bf5969e27a3f1f1478c9b05c187815f2b2390',
  config = conf.neorg,
  run = ':Neorg sync-parsers',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-neorg/neorg-telescope',
  },
  after = { 'nvim-treesitter' },
  cmd = { 'Neorg' },
  ft = { 'norg' },
}
