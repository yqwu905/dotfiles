return function()
  local flag, iron = pcall(require, "iron.core")
  if flag then
    iron.setup({
      config = {
        scratch_repl = true,
        repl_definition = {
          python = {
            command = "ipython --no-autoindent"
          },
          julia = {
            command = "julia"
          },
          lua = {
            command = "lua"
          }
        },
        repl_open_cmd = require('iron.view').curry.right(function()
          return vim.o.columns / 2
        end),
        highlight = {
          italic = true
        }
      }
    })
  end
end
