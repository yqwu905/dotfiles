return {
  'simrat39/rust-tools.nvim',
  opts = {
    server = {
      on_attach = function (_, bufnr)
        vim.keymap.set('n', 'K', rt.hover_actions.hover_actions, {buffer = bufnr})
        vim.keymap.set('n', '<Leader>la', rt.code_action_group.code_action_group, {buffer = bufnr})
      end,
    },
  },
}
