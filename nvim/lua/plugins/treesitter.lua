return function()
  require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    sync_install = true,
    ignore_install = { "latex" },

    highlight = {
      enable = true,
      disable = { "c", "rust" },
      additional_vim_regex_highlighting = false,
    },
  }
end
