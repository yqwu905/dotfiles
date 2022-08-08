return function()
  local servers = { "clangd", "pyright", "bashls", "cmake", "texlab", "ltex", "powershell_es", "jsonls" }
  require('nvim-lsp-installer').setup({
    ensure_installed = servers,
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


  require("lsp_signature").setup()

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({})
  end

  lspconfig['julials'].setup({})

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

  lspconfig.efm.setup({
    filetypes = { 'python' },
    root_dir = function() return vim.fn.getcwd() end;
    init_options = { documentFormatting = true },
    settings = {
      rootMarkers = { vim.fn.getcwd() },
      languages = {
        python = {
          { -- flake8
            lintCommand = "flake8 --max-line-length 160 --stdin-display-name ${INPUT} -",
            lintIgnoreExitCode = true,
            lintStdin = true,
            lintFormats = { "%f:%l:%c: %m" },
          },
          { -- yapf
            formatCommand = "yapf --quiet",
            formatStdin = true
          }
        }
      }
    }
  })

  -- configs.lsp_wl = {
  --   default_config = {
  --     cmd = { "nc", "localhost", "6536" },
  --     filetypes = { "mma", "wl" },
  --     root_dir = util.path.dirname,
  --   },
  -- }
  --
  -- lspconfig['lsp-wl'].setup({})
end
