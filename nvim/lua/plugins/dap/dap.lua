return function()
  local dap_breakpoint = {
    error = {
      text = '',
      texthl = 'GlyphPalette1',
      linehl = '',
      numhl = '',
    },
    rejected = {
      text = '',
      texthl = 'GlyphPalette2',
      linehl = '',
      numhl = '',
    },
    stopped = {
      text = '⭐️',
      texthl = 'GlyphPalette3',
      linehl = 'DiagnosticUnderlineInfo',
      numhl = 'LspDiagnosticsSignInformation',
    },
  }

  vim.fn.sign_define('DapBreakpoint', dap_breakpoint.error)
  vim.fn.sign_define('DapStopped', dap_breakpoint.stopped)
  vim.fn.sign_define('DapBreakpointRejected', dap_breakpoint.rejected)

  local dap = require('dap')
  dap.adapters.lldb = {
    type = 'executable',
    command = '/usr/sbin/lldb-vscode',
    name = 'lldb',
  }
  dap.configurations.cpp = {
    {
      name = 'Launch',
      type = 'lldb',
      request = 'launch',
      program = function()
        return vim.fn.getcwd() .. '/a.out'
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = true,
      args = {},
    },
  }
end
