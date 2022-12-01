local config = {}

function config.nvim_treesitter()
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    sync_install = true,
    ignore_install = {'latex', 'markdown', 'phpdoc'},
    highlight = {
      enable = true,
    },
    textobjects = {
      select = {
        enable = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner'
        },
      },
    },
  })
end

function config.notify()
  require('notify').setup({
    background_colour = "#000000"
  })
  vim.notify = require('notify')
end

return config
