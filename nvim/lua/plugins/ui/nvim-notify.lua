return {
  'rcarriga/nvim-notify',
  init = function ()
    require('notify').setup({
      background_colour = '#000000',
    })
    vim.notify = require('notify')
  end,
  lazy = true,
}
