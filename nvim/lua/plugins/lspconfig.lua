return function()
  require('nvim-lsp-installer').setup({
    ensure_installed = { "sumneko_lua", "bashls", "clangd", "cmake", "texlab", "pyright", "ltex" },
    -- automatic_installation = true,
    ui = {
      icons = {
        server_installed = "✓",
        server_pending = "➜",
        server_uninstalled = "✗"
      }
    },
  })

  local lspconfig = require("lspconfig")
  local util = require("lspconfig.util")
  local configs = require("lspconfig.configs")

  local servers = { "clangd", "pyright", "julials", "bashls", "cmake", "texlab", "ltex" }

  require("lsp_signature").setup()

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({})
  end

  lspconfig.sumneko_lua.setup({
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = {
            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
          },
          maxPreload = 100000,
          preloadFileSize = 10000,
        },
      },
    }
  })

  configs.lsp_wl = {
    default_config = {
      cmd = { "nc", "localhost", "6536" },
      filetypes = { "mma", "wl" },
      root_dir = util.path.dirname,
    },
  }

  lspconfig.lsp_wl.setup({})
end
