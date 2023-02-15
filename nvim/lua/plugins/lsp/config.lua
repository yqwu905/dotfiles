local config = {}

function config.lspsaga()
  require('lspsaga').setup({
    symbol_in_winbar = {
      enable = true,
    },
    code_action_lightbulb = {
      enable = false,
    },
  })
  local keymap = vim.keymap.set
  local bufopts = { noremap = true, silent = true }
  keymap('n', 'gD', '<cmd>Lspsaga lsp_finder<cr>', bufopts)
  keymap('n', 'gd', '<cmd>Lspsaga peek_definition<cr>', bufopts)
  keymap('n', 'gp', '<cmd>Lspsaga preview_definition<cr>', bufopts)
  keymap('n', 'K', '<cmd>Lspsaga hover_doc <cr>', bufopts)
  -- keymap('n', 'K', '<cmd>Lspsaga hover_doc ++keep<cr>', bufopts)
  keymap('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', bufopts)
  keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<cr>', bufopts)
end

function config.fidget()
  require('fidget').setup({})
end

function config.nullls()
  local null_ls = require('null-ls')
  null_ls.setup({
    on_init = function (new_client, _)
      new_client.offset_encoding = 'utf-16'
    end,
    sources = {
      null_ls.builtins.formatting.yapf,
      null_ls.builtins.formatting.stylua,
      null_ls.builtins.diagnostics.actionlint,
      -- null_ls.builtins.diagnostics.cpplint,
      null_ls.builtins.diagnostics.flake8,
    }
  })
end

return config
