local config = {}

function config.dapui()
  local dap = require('dap')
  local dapui = require('dapui')
  local debug_open = function()
    dapui.open()
    vim.api.nvim_command('DapVirtualTextEnable')
    vim.api.nvim_command('NvimTreeClose')
  end
  local debug_close = function()
    dap.repl.close()
    dapui.close()
    vim.api.nvim_command('DapVirtualTextDisable')
    -- vim.api.nvim_command("bdelete! term:")   -- close debug temrinal
  end

  dap.listeners.after.event_initialized['dapui_config'] = function()
    debug_open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    debug_close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    debug_close()
  end
  dap.listeners.before.disconnect['dapui_config'] = function()
    debug_close()
  end
  dapui.setup({
    ui = {
      auto_open = true,
      notify = {
        threshold = vim.log.levels.INFO,
      },
      config = {
        icons = { expanded = '', collapsed = '', circular = '' },
        mappings = {
          -- Use a table to apply multiple mappings
          expand = { '<CR>', '<2-LeftMouse>' },
          open = 'o',
          remove = 'd',
          edit = 'e',
          repl = 'r',
          toggle = 't',
        },
        -- Use this to override mappings for specific elements
        element_mappings = {},
        expand_lines = true,
        layouts = {
          {
            elements = {
              { id = 'scopes', size = 0.33 },
              { id = 'breakpoints', size = 0.17 },
              { id = 'stacks', size = 0.25 },
              { id = 'watches', size = 0.25 },
            },
            size = 0.33,
            position = 'right',
          },
          {
            elements = {
              { id = 'repl', size = 0.45 },
              { id = 'console', size = 0.55 },
            },
            size = 0.27,
            position = 'bottom',
          },
        },
        controls = {
          enabled = true,
          -- Display controls in this element
          element = 'repl',
          icons = {
            pause = '',
            play = '',
            step_into = '',
            step_over = '',
            step_out = '',
            step_back = '',
            run_last = '',
            terminate = '',
          },
        },
        floating = {
          max_height = 0.9,
          max_width = 0.5, -- Floats will be treated as percentage of your screen.
          border = vim.g.border_chars, -- Border style. Can be 'single', 'double' or 'rounded'
          mappings = {
            close = { 'q', '<Esc>' },
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
          max_value_lines = 100, -- Can be integer or nil.
        },
      },
    },
  })
end

function config.dap_virtual_text()
  require('nvim-dap-virtual-text').setup()
end

return config
