local plugin = require('core.pack').register_plugin
local dap = require('modules.dap.dap')
local conf = require('modules.dap.config')

plugin {
  'mfussenegger/nvim-dap',
  event = 'BufEnter',
  ft = {'cpp'},
  config = dap,
}
plugin {
  'rcarriga/nvim-dap-ui',
  after = 'nvim-dap',
  config = conf.dapui,
}
plugin {
  'theHamsta/nvim-dap-virtual-text',
  after = 'nvim-dap',
  config = conf.dap_virtual_text,
}
