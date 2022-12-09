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
