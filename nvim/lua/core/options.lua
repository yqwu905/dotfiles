-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
local opt = vim.opt

opt.termguicolors = true
opt.shell = 'zsh'
opt.hidden = true
opt.magic = true
opt.virtualedit = 'block'
opt.clipboard = 'unnamedplus'
opt.wildignorecase = true
opt.swapfile = false
opt.history = 2000
opt.timeout = true
opt.ttimeout = true
opt.timeoutlen = 500
opt.ttimeoutlen = 10
opt.updatetime = 100
opt.redrawtime = 1500
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true

-- use rg in vim grep
if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

opt.completeopt = 'menu,menuone,noselect'
opt.showmode = false
opt.shortmess = 'aoOTIcF'
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false
opt.cmdheight = 0
opt.laststatus = 3
opt.list = true
opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- wrap
opt.linebreak = true
opt.whichwrap = 'h,l,<,>,[,],~'
opt.breakindentopt = 'shift:2,min:20'
opt.showbreak = '↳  '
opt.foldlevelstart = 99
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'

opt.number = true
opt.signcolumn = 'yes'
opt.spelloptions = 'camel'

opt.textwidth = 100
opt.colorcolumn = '80'
opt.conceallevel = 2
-- opt.concealcursor = 'niv'
opt.relativenumber = true
vim.g.python3_host_prog = '/usr/bin/python'
