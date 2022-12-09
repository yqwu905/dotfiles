return function()
  local servers = { 'pyright', 'bashls', 'cmake', 'texlab', 'jsonls', 'tsserver',
    'taplo', 'marksman' }

  local lspconfig = require('lspconfig')
  local util = require('lspconfig.util')
  local configs = require('lspconfig.configs')

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
  end


  for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup({
      on_attach = on_attach
    })
  end

  lspconfig.julials.setup({
    on_attach = on_attach
  })

  lspconfig.sumneko_lua.setup({
    on_attach = on_attach,
    settings = {
      Lua = {
        diagnostics = {
          globals = { 'vim' },
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
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
            lintCommand = 'flake8 --max-line-length 160 --stdin-display-name ${INPUT} -',
            lintIgnoreExitCode = true,
            lintStdin = true,
            lintFormats = { '%f:%l:%c: %m' },
          },
          { -- yapf
            formatCommand = 'yapf --quiet',
            formatStdin = true
          }
        }
      }
    }
  })
end
