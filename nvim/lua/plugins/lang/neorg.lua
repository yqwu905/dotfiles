return {
  'nvim-neorg/neorg',
  -- commit = 'a79bf5969e27a3f1f1478c9b05c187815f2b2390',
  build = ':Neorg sync-parsers',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-neorg/neorg-telescope',
  },
  cmd = {'Neorg'},
  ft = {'norg'},
  opts = {

    load = {
      ['core.defaults'] = {}, -- Default module
      ['core.norg.concealer'] = {}, -- Conceal support
      ['core.norg.dirman'] = {-- Workspace
        config = {
          workspaces = {
            note = '~/repos/notes',
          },
          default_workspace = 'note',
        },
      },
      ['core.norg.completion'] = {
        config = {
          engine = 'nvim-cmp',
        },
      },
      -- ['core.gtd.base'] = {
      --     config = {
      --         workspace = 'note',
      --         exclude = { 'archive/' },
      --     },
      -- },
      ['core.integrations.telescope'] = {},
    },
  },
}
