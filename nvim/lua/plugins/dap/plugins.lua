local reg = require('core.lazy').reg
local dap = require('plugins.dap.dap')
local conf = require('plugins.dap.config')

reg {
  'mfussenegger/nvim-dap',
  event = 'BufEnter',
  ft = {'cpp'},
  config = dap,
}
reg {
  'rcarriga/nvim-dap-ui',
  after = 'nvim-dap',
  config = conf.dapui,
}
reg {
  'theHamsta/nvim-dap-virtual-text',
  after = 'nvim-dap',
  config = conf.dap_virtual_text,
}
