return function()
  require("session_manager").setup(
    {
    autoload_mode = require('session_manager.config').AutoloadMode.Disabled,
  })

  local config_group = vim.api.nvim_create_augroup('SessionAuGroup', {}) -- A global group for all your config autocommands

  vim.api.nvim_create_autocmd({ 'SessionLoadPost' }, {
    group = config_group,
    callback = function()
      require('nvim-tree').toggle(false, true)
    end,
  })
end
