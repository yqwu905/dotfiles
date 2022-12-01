vim.cmd("let mapleader = \" \"")
require('utils')
local wk = require("which-key")
local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = false,
  nowait = false,
}

local vopts = {
  mode = "v",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
  nowait = false,
}

wk.register({
  ["/"] = { "<cmd>lua require('Comment.api').toggle.linewise()<cr>", "toggle comment" },
  ["1"] = { "<cmd>lua require('bufferline').go_to_buffer(1, true)<cr>", "buffer 1" },
  ["2"] = { "<cmd>lua require('bufferline').go_to_buffer(2, true)<cr>", "buffer 2" },
  ["3"] = { "<cmd>lua require('bufferline').go_to_buffer(3, true)<cr>", "buffer 3" },
  ["4"] = { "<cmd>lua require('bufferline').go_to_buffer(4, true)<cr>", "buffer 4" },
  ["5"] = { "<cmd>lua require('bufferline').go_to_buffer(5, true)<cr>", "buffer 5" },
  ["6"] = { "<cmd>lua require('bufferline').go_to_buffer(6, true)<cr>", "buffer 6" },
  ["7"] = { "<cmd>lua require('bufferline').go_to_buffer(7, true)<cr>", "buffer 7" },
  ["8"] = { "<cmd>lua require('bufferline').go_to_buffer(8, true)<cr>", "buffer 8" },
  ["9"] = { "<cmd>lua require('bufferline').go_to_buffer(9, true)<cr>", "buffer 9" },
  d = {
    name = "+debug",
    b = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "toggle breakpoint" },
    c = { "<cmd>lua require'dap'.continue()<cr>", "continue" },
    n = { "<cmd>lua require'dap'.step_over()<cr>", "step over" },
    ["N"] = { "<cmd>lua require'dap'.step_out()<cr>", "step out" },
    i = { "<cmd>lua require'dap'.step_into()<cr>", "step into" },
  },
  e = {
    name = "+enter",
    c = { "<cmd>e $MYVIMRC | :cd %:p:h <CR>", "nvim config" }
  },
  f = {
    name = "+find",
    a = { "<cmd>Telescope find_files follow=true no_ignore=true hidden=true <cr>", "find all files" },
    f = { "<cmd>Telescope find_files<cr>", "find files" },
    h = { "<cmd>Telescope help_tags<cr>", "help tags" },
    o = { "<cmd>Telescope oldfiles<cr>", "old files" },
    w = { "<cmd>Telescope live_grep<cr>", "live grep" },
    s = { "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "workspace symbols" },
    t = { "<cmd>Telescope<CR>", "telescope" },
    ["/"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "current file" }
  },
  g = {
    name = "+git",
    b = { "<cmd>lua require'gitsigns'.blame_line{full=true}<cr>", "git blame" },
    c = { "<cmd>lua Commit.commit()<cr>", "git commit" },
    d = {
      name = "+git diff",
      f = { "<cmd>lua ToggleDiffView(false)<CR>", "diff file" },
      d = { "<cmd>lua ToggleDiffView(true)<CR>", "diff dir" },
      c = { "<cmd>lua :DiffviewClose<cr>", "diff close" },
    },
    g = { "<cmd>Neogit<cr>", "neogit" },
    h = { "<cmd>Telescope git_commits<cr>", "git history" },
    j = { "<cmd>Gitsigns next_hunk<cr>", "next hunk" },
    k = { "<cmd>Gitsigns prev_hunk<cr>", "previous hunk" },
    p = { "<cmd>Gitsigns preview_hunk<cr>", "git preview" },
    s = { "<cmd>:Gitsigns stage_hunk<cr>", "git stage" },
  },
  l = {
    name = "+lsp",
    s = {
      name = "+server",
      i = { "<cmd>LspInfo<cr>", "LSP Info" },
      r = { "<cmd>LspRestart<cr>", "LSP Restart" },
      k = { "<cmd>LspStop<cr>", "LSP Stop" },
      s = { "<cmd>LspStart<cr>", "LSP Start" },
    },
    r = { "<cmd>lua Rename.rename()<cr>", "rename" },
    f = { "<cmd>lua vim.lsp.buf.format({async=true})<cr>", "format" },
    a = { "<cmd>lua CodeAction()<cr>", "code actions" },
    d = { "<cmd>lua vim.diagnostic.setloclist()<cr>", "diagnostics" },
  },
  s = {
    name = "+repl",
    l = { "<cmd>lua require('iron.core').send_line()<cr>", "send line" },
    f = { "<cmd>lua require('iron.core').send(nil, vim.api.nvim_buf_get_lines(0, 0, -1, false))<cr>",
      "send file" },
    s = { "<cmd>IronFocus<cr>", "focus repl" },
    ["<cr>"] = { "<cmd>lua require('iron.core').send(nil, string.char(13))<cr>", "send cr" },
  },
  p = {
    name = "+packer",
    c = { "<cmd>PackerCompile<cr>", "compile" },
    s = { "<cmd>PackerStatus<cr>", "status" },
    i = { "<cmd>PackerInstall<cr>", "install" },
    u = { "<cmd>PackerSync<cr>", "sync" },
  },
  q = {
    name = "+quit",
    q = { "<cmd>wqa<cr>", "quit" },
    f = { "<cmd>qa!<cr>", "force quit" },
    x = { "<cmd>lua close_buffer()<cr>", "close buffer" }
  },
  u = {
    name = "+utils",
    r = { "<cmd>lua AsyncRunCode()<cr>", "run" },
    c = { "<cmd>lua SwitchConcealLevel()<cr>", "switch conceallevel" },
    s = { "<cmd>SymbolsOutline<cr>", "taglist" },
    p = { "<cmd>lua ToggleMarkdownPreview()<cr>", "preview" },
  },
  t = {
    name = "+term",
    t = { "<cmd>lua __fterm_ft()<cr>", "term" },
    b = { "<cmd>lua __fterm_btop()<cr>", "top" },
    j = { "<cmd>lua __fterm_julia()<cr>", "julia" },
    p = { "<cmd>lua __fterm_python()<cr>", "python" },
  },
  x = {
    name = "+trouble",
    x = { "<cmd>TroubleToggle<cr>", "toggle" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
    l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
    n = { "<cmd>lua require('trouble').next({jump = true})", "next" },
    p = { "<cmd>lua require('trouble').previous({jump = true})", "prev" }
  }
}, opts)

wk.register({
  ["/"] = { "<esc><cmd> :lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "toggle comment" },
  s = { ":<C-u>lua require('iron.core').send(nil, get_visual_selection())<cr>", "send visual" }
}, vopts)

vim.cmd [[
noremap <Tab> <cmd>BufferLineCycleNext<CR>
noremap <S-Tab> <cmd>BufferLineCyclePrev<CR>

noremap <C-s> <cmd>w<CR>
inoremap <C-s> <C-O><cmd>w<CR>
vnoremap <C-s> <C-C><cmd>w<CR>

inoremap <C-l> <c-g>u<Esc>[s1z=1`]a<c-g>u

noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-h> <C-w>h
noremap <C-l> <C-w>l

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

noremap <A-i> <cmd>lua require('FTerm').toggle()<CR>
inoremap <A-i> <cmd>lua require('FTerm').toggle()<CR>
vnoremap <A-i> <cmd>lua require('FTerm').toggle()<CR>
tnoremap <A-i> <cmd>lua require('FTerm').toggle()<CR>

inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

tnoremap <Esc> <C-\><C-n>
]]
