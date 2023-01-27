-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap, imap, xmap, vmap = key.nmap, key.imap, key.xmap, key.vmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd
local utils = require('keymap.utils')

local wk = require('which-key')
local opts = {
  mode = 'n',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = false,
  nowait = false,
}

local vopts = {
  mode = 'v',
  prefix = '<leader>',
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

wk.register({
  ['/'] = { "<cmd>lua require('Comment.api').toggle.linewise()<cr>",
    'toggle comment' },
  ['1'] = { "<cmd>lua require('bufferline').go_to_buffer(1, true)<cr>",
    'buffer 1' },
  ['2'] = { "<cmd>lua require('bufferline').go_to_buffer(2, true)<cr>",
    'buffer 2' },
  ['3'] = { "<cmd>lua require('bufferline').go_to_buffer(3, true)<cr>",
    'buffer 3' },
  ['4'] = { "<cmd>lua require('bufferline').go_to_buffer(4, true)<cr>",
    'buffer 4' },
  ['5'] = { "<cmd>lua require('bufferline').go_to_buffer(5, true)<cr>",
    'buffer 5' },
  ['6'] = { "<cmd>lua require('bufferline').go_to_buffer(6, true)<cr>",
    'buffer 6' },
  ['7'] = { "<cmd>lua require('bufferline').go_to_buffer(7, true)<cr>",
    'buffer 7' },
  ['8'] = { "<cmd>lua require('bufferline').go_to_buffer(8, true)<cr>",
    'buffer 8' },
  ['9'] = { "<cmd>lua require('bufferline').go_to_buffer(9, true)<cr>",
    'buffer 9' },
  e = {
    name = '+enter',
    c = { '<cmd>e $MYVIMRC | :cd %:p:h <CR>', 'nvim config' },
    o = { '<cmd>e /home/yqwu/repos/notes/inbox.norg | :cd %:p:h <CR>', 'neorg' }
  },
  f = {
    name = '+find',
    a = { '<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>',
      'find all files' },
    f = { '<cmd>Telescope find_files<cr>', 'find files' },
    h = { '<cmd>Telescope help_tags<cr>', 'help tags' },
    r = { '<cmd>Telescope oldfiles<cr>', 'recent files' },
    o = { '<cmd>lua require("telescope.builtin").find_files({search_dirs={"~/repos/notes"}})<cr>',
      'org files' },
    n = {
      name = 'neorg',
      l = { '<cmd>Telescope neorg find_linkable<cr>', 'linkable' },
      c = { '<cmd>Telescope neorg find_context_tasks<cr>', 'context tasks' },
      p = { '<cmd>Telescope neorg find_project_tasks<cr>', 'project tasks' },
    },
    w = { '<cmd>Telescope live_grep<cr>', 'live grep' },
    s = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', 'workspace symbols' },
    t = { '<cmd>Telescope<CR>', 'telescope' },
    ['/'] = { '<cmd>Telescope current_buffer_fuzzy_find<CR>', 'current file' }
  },
  g = {
    name = '+git',
    b = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", 'git blame' },
    c = { utils.Commit.commit, 'git commit' },
    d = {
      name = '+git diff',
      f = { '<cmd>lua ToggleDiffView(false)<CR>', 'diff file' },
      d = { '<cmd>lua ToggleDiffView(true)<CR>', 'diff dir' },
      c = { '<cmd>lua :DiffviewClose<cr>', 'diff close' },
    },
    g = { '<cmd>Neogit<cr>', 'neogit' },
    h = { '<cmd>Telescope git_commits<cr>', 'git history' },
    j = { '<cmd>Gitsigns next_hunk<cr>', 'next hunk' },
    k = { '<cmd>Gitsigns prev_hunk<cr>', 'previous hunk' },
    p = { '<cmd>Gitsigns preview_hunk<cr>', 'git preview' },
    s = { '<cmd>:Gitsigns stage_hunk<cr>', 'git stage' },
  },
  l = {
    name = '+lsp',
    s = {
      name = '+server',
      i = { '<cmd>LspInfo<cr>', 'LSP Info' },
      r = { '<cmd>LspRestart<cr>', 'LSP Restart' },
      k = { '<cmd>LspStop<cr>', 'LSP Stop' },
      s = { '<cmd>LspStart<cr>', 'LSP Start' },
    },
    r = { '<cmd>Lspsaga rename()<cr>', 'rename' },
    f = { '<cmd>lua vim.lsp.buf.format({async=true})<cr>', 'format' },
    a = { '<cmd>lua CodeAction()<cr>', 'code actions' },
    d = { '<cmd>Trouble<cr>', 'diagnostics' },
  },
  s = {
    name = '+repl',
    l = { "<cmd>lua require('iron.core').send_line()<cr>", 'send line' },
    f = { "<cmd>lua require('iron.core').send(nil, vim.api.nvim_buf_get_lines(0, 0, -1, false))<cr>",
      'send file' },
    s = { '<cmd>IronFocus<cr>', 'focus repl' },
    ['<cr>'] = { "<cmd>lua require('iron.core').send(nil, string.char(13))<cr>",
      'send cr' },
  },
  o = {
    name = '+org',
    c = { '<cmd>Neorg toggle-concealer<cr>', 'conceal' },
    g = {
      name = '+gtd',
      v = { '<cmd>Neorg gtd views<cr>', 'view' },
      c = { '<cmd>Neorg gtd capture<cr>', 'capture' },
    },
    i = { '<cmd>Neorg workspace note<cr>', 'index' },
    m = {
      name = '+metadata',
      i = { '<cmd>Neorg inject-metadata<cr>', 'inject' },
      u = { '<cmd>Neorg update-metadata<cr>', 'update' },
    },
    t = {
      name = '+toc',
      i = { '<cmd>Neorg toc inline<cr>', 'inline' },
      s = { '<cmd>Neorg toc split<cr>', 'split' },
      c = { '<cmd>Neorg toc close<cr>', 'close' },
    },
  },
  p = {
    name = '+packer',
    c = { '<cmd>PackerCompile<cr>', 'compile' },
    s = { '<cmd>PackerStatus<cr>', 'status' },
    i = { '<cmd>PackerInstall<cr>', 'install' },
    u = { '<cmd>PackerSync<cr>', 'sync' },
  },
  q = {
    name = '+quit',
    q = { '<cmd>wqa<cr>', 'quit' },
    f = { '<cmd>qa!<cr>', 'force quit' },
    x = { utils.close_buffer, 'close buffer' }
  },
  u = {
    name = '+utils',
    r = { utils.async_run_code, 'run' },
    c = { utils.switch_conceallevel, 'switch conceallevel' },
    s = { '<cmd>LSoutlineToggle<cr>', 'taglist' },
    p = { utils.toggle_preview, 'preview' },
  },
  x = {
    name = 'trouble',
    d = { '<cmd>Trouble document_diagnostics<cr>', 'document' },
    w = { '<cmd>Trouble workspace_diagnostics<cr>', 'workspace' },
    q = { '<cmd>Trouble quickfix<cr>', 'quickfix' },
    l = { '<cmd>Trouble loclist<cr>', 'loclist' },
    r = { '<cmd>TroubleRefresh<cr>', 'refresh' },
    x = { '<cmd>TroubleToggle<cr>', 'toggle' },
  },
}, opts)

wk.register({
  ['/'] = { "<esc><cmd> :lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>",
    'toggle comment' },
  s = { ":<C-u>lua require('iron.core').send(nil, get_visual_selection())<cr>",
    'send visual' }
}, vopts)

vim.cmd [[
noremap <Tab> <cmd>BufferLineCycleNext<CR>
noremap <S-Tab> <cmd>BufferLineCyclePrev<CR>

noremap <C-n> <cmd>NvimTreeToggle<CR>

nmap ; <Plug>(eft-repeat)
xmap ; <Plug>(eft-repeat)
omap ; <Plug>(eft-repeat)

nmap f <Plug>(eft-f)
xmap f <Plug>(eft-f)
omap f <Plug>(eft-f)
nmap F <Plug>(eft-F)
xmap F <Plug>(eft-F)
omap F <Plug>(eft-F)

nmap t <Plug>(eft-t)
xmap t <Plug>(eft-t)
omap t <Plug>(eft-t)
nmap T <Plug>(eft-T)
xmap T <Plug>(eft-T)
omap T <Plug>(eft-T)

nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

nmap s <cmd>HopWord<cr>

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

tnoremap <Esc> <C-\><C-n>
]]
