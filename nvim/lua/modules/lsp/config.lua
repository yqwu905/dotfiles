local config = {}

function config.lspsaga()
  local saga = require('lspsaga')
  saga.init_lsp_saga({
    symbol_in_winbar = {
      enable = true,
    },
  })
end

function config.symbols_outline()
  require('symbols-outline').setup({
    autofold_depth = 1,
    auto_unfold_hover = false,
  })
end

return config
