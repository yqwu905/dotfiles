local config = {}

function config.lspsaga()
  local saga = require('lspsaga')
  saga.init_lsp_saga({
    symbol_in_winbar = {
      enable = true,
    },
  })
  local keymap = vim.keymap.set
  local bufopts = { noremap = true, silent = true }
  keymap('n', '<A-i>', '<cmd>Lspsaga open_floaterm<CR>', { silent = true })
  keymap('t', '<A-i>', [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]],
    { silent = true })
  keymap('n', 'gD', '<cmd>Lspsaga lsp_finder<cr>', bufopts)
  keymap('n', 'gd', '<cmd>Lspsaga peek_definition<cr>', bufopts)
  keymap('n', 'gp', '<cmd>Lspsaga preview_definition<cr>', bufopts)
  keymap('n', 'K', '<cmd>Lspsaga hover_doc<cr>', bufopts)
  keymap('i', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '[e', '<cmd>Lspsaga diagnostic_jump_prev<cr>', bufopts)
  keymap('n', ']e', '<cmd>Lspsaga diagnostic_jump_next<cr>', bufopts)
end

function config.fidget()
  require('fidget').setup({})
end

return config
