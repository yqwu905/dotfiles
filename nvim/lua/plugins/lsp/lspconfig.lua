return {
  'neovim/nvim-lspconfig',
  config = function ()
    local servers = {
      'rust_analyzer',
      'clangd',
      'cmake',
      'html',
      'jsonls',
      'julials',
      'texlab',
      'marksman',
      'jedi_language_server',
      'taplo',
      -- 'lua_ls',
      'yamlls',
    }

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
      vim.fn.sign_define(hl, {text = icon, texthl = hl, numhl = hl})
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

    local on_attach = function (client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    end

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.offsetEncoding = {'utf-16'}

    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup({
        on_attach = on_attach,
        capabilities = capabilities,
      })
    end

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = 'LuaJIT',
          },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = {'vim'},
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
          -- Do not send telemetry data containing a randomized but unique identifier
          telemetry = {
            enable = false,
          },
        },
      },
    })
  end,
}
