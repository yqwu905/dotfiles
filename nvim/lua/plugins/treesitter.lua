return function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = true,
    ignore_install = { "latex", "markdown", "phpdoc" },

    highlight = {
      enable = true,
      disable = {},
    },
  }
end
