local reg = require('core.lazy').reg
local conf = require('plugins.tools.config')

reg {
    'nvim-telescope/telescope.nvim',
    config = conf.telescope,
    cmd = 'Telescope',
}
reg {
    'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    lazy = true
}
reg {
  'nvim-telescope/telescope-project.nvim',
  lazy = true
}
reg {
    'rlue/vim-barbaric',
    event = 'InsertEnter',
    enabled = false,
}
reg {
    'norcalli/nvim-colorizer.lua',
    config = conf.colorizer,
}
reg {
    'TimUntersberger/neogit',
    cmd = 'Neogit',
}
reg {
    'lewis6991/gitsigns.nvim',
    config = conf.gitsigns,
    event = 'BufRead',
}
reg { 'f-person/git-blame.nvim' }
reg {
    'akinsho/toggleterm.nvim',
    config = conf.term,
    cmd = 'ToggleTerm',
}
reg {
    'wakatime/vim-wakatime',
    event = 'VeryLazy'
}
reg {
    'williamboman/mason.nvim',
    config = conf.mason,
}
reg {
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    config = conf.mason_installer,
}
