return function()
  local servers = { "pyright", "bashls", "cmake", "texlab", "jsonls" }
  local manually_install_servers = { "clangd" }
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

  local signs = {
    Error = ' ',
    Warn = ' ',
    Info = ' ',
    Hint = 'ﴞ ',
  }

  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  vim.diagnostic.config({
    signs = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    virtual_text = {
      source = true,
    },
  })

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  end

  require("lsp_signature").setup()

  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = on_attach
    })
  end

  for _, lsp in ipairs(manually_install_servers) do
    lspconfig[lsp].setup({
      on_attach = on_attach
    })
  end

  lspconfig['julials'].setup({
    on_attach = on_attach
  })

  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
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
    on_attach = on_attach,
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
