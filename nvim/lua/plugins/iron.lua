return function()
  local iron = require("iron.core")

  iron.setup({
    config = {
      scratch_repl = true,
      repl_definition = {
        julia = {
          command = { "julia", "--banner=no", "--startup-file=no", "-i", "/home/yqwu/.config/nvim/static/startup.jl" }
        }
      },
      repl_open_cmd = require('iron.view').split.vertical.botright(0.4),
    }
  })
end
