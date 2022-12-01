return function()
  local servers = { "pyright", "bashls", "cmake", "texlab", "jsonls",
    "sumneko_lua", "tsserver", "taplo", "marksman" }
  local manually_config_servers = {}
  local manually_install_servers = { "clangd" }
  for i = 1, #manually_config_servers do
    servers[#servers + 1] = manually_config_servers[i]
  end
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
    local status, saga = pcall(require, "lspsaga")
    if status then
      saga.init_lsp_saga({})
      vim.keymap.set('n', 'gD', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'gd', "<cmd>Lspsaga lsp_finder<cr>", bufopts)
      vim.keymap.set('n', 'gp', "<cmd>Lspsaga preview_definition<cr>", bufopts)
      vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>', bufopts)
      vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '[e', "<cmd>Lspsaga diagnostic_jump_prev<cr>", bufopts)
      vim.keymap.set('n', ']e', "<cmd>Lspsaga diagnostic_jump_next<cr>", bufopts)
    end
  end

  -- require("lsp_signature").setup()

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
    cmd = { "julia", "-e", "using LanguageServer; runserver()" },
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
end
