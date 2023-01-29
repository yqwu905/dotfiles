local config = {}

function config.dapui()
  require('dapui').setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
      -- Use a table to apply multiple mappings
      expand = { 'o', '<2-LeftMouse>', '<CR>' },
      open = 'O',
      remove = 'd',
      edit = 'e',
      repl = 'r',
      toggle = 't',
    },
    layouts = { {
      elements = {
        'scopes',
      },
      size = 25,
      position = 'left',
    },
      {
        elements = {
          'watches',
        },
        size = 25,
        position = 'right',
      },
      {
        elements = {
          'console',
        },
        size = 5,
        position = 'bottom',
      },
      -- {
      --   elements = {
      --     'repl',
      --   },
      --   size = 12,
      --   position = 'bottom',
      -- },
    },
    -- sidebar = {
    --   -- You can change the order of elements in the sidebar
    --   elements = {
    --     -- Provide as ID strings or tables with "id" and "size" keys
    --     {
    --       id = "scopes",
    --       size = 0.35, -- Can be float or integer > 1
    --     },
    --     { id = "stacks", size = 0.35 },
    --     { id = "watches", size = 0.15 },
    --     { id = "breakpoints", size = 0.15 },
    --   },
    --   size = 40,
    --   position = "left", -- Can be "left", "right", "top", "bottom"
    -- },
    -- tray = {
    --   elements = { "repl" },
    --   size = 5,
    --   position = "bottom", -- Can be "left", "right", "top", "bottom"
    -- },
    floating = {
      max_height = nil, -- These can be integers or a float between 0 and 1.
      max_width = nil, -- Floats will be treated as percentage of your screen.
      border = 'single', -- Border style. Can be "single", "double" or "rounded"
      mappings = {
        close = { 'q', '<Esc>' },
      },
    },
    windows = { indent = 1 },
  })
  local dap, dapui = require('dap'), require('dapui')
  dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
  end
end

function config.dap_virtual_text()
  require('nvim-dap-virtual-text').setup()
end

return config
