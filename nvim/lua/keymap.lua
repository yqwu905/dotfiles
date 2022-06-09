vim.cmd("let mapleader = \" \"")
require('utils')
local wk = require("which-key")
local opts = {
  mode = "n",
  prefix = "<leader>",
  buffer = nil,
  silent = true,
  noremap = true,
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
  ["/"] = { "<cmd>lua require('Comment.api').toggle_current_linewise()<cr>", "toggle comment" },
  ["1"] = { "<cmd>BufferLineGoToBuffer 1<cr>", "window 1" },
  ["2"] = { "<cmd>BufferLineGoToBuffer 2<cr>", "window 2" },
  ["3"] = { "<cmd>BufferLineGoToBuffer 3<cr>", "window 3" },
  ["4"] = { "<cmd>BufferLineGoToBuffer 4<cr>", "window 4" },
  ["5"] = { "<cmd>BufferLineGoToBuffer 5<cr>", "window 5" },
  ["6"] = { "<cmd>BufferLineGoToBuffer 6<cr>", "window 6" },
  ["7"] = { "<cmd>BufferLineGoToBuffer 7<cr>", "window 7" },
  ["8"] = { "<cmd>BufferLineGoToBuffer 8<cr>", "window 8" },
  ["9"] = { "<cmd>BufferLineGoToBuffer 9<cr>", "window 9" },
  c = {
    name = "+comments",
    c = { "<cmd>Dox<cr>", "dox function" },
    f = { "<cmd>DoxAuthor<cr>", "dox file" },
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
    s = { "<cmd>lua DynamicWorkspaceSymbol()<CR>", "workspace symbols" },
    t = { "<cmd>Telescope<CR>", "telescope" },
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
    r = { "<cmd>lua Rename.rename()<cr>", "rename" },
    f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "format" },
    a = { "<cmd>lua CodeAction()<cr>", "code actions" },
    d = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "diagnostics" },
  },
  p = {
    name = "+packer",
    c = { "<cmd>PackerCompile<cr>", "compile" },
    s = { "<cmd>PackerStatus<cr>", "status" },
    i = { "<cmd>PackerInstall<cr>", "install" },
    u = { "<cmd>PackerSync<cr>", "sync" },
  },
  q = {
    name = "+quickfix",
    f = { "<cmd>QFToggle<cr>", "open quickfix" },
    l = { "<cmd>LLToggle<cr>", "open loclist" },
    n = { "<cmd>QNext<cr>", "next quickfix/loclist item" },
    p = { "<cmd>QPrev<cr>", "prev quickfix/loclist item" },
  },
  u = {
    name = "+utils",
    r = { "<cmd>lua AsyncRunCode()<cr>", "run" },
    i = {
      name = "+inkscape",
      i = {"<cmd>lua NewInkscapeFile()<cr>", "new"},
      l = {"<cmd>lua GetInkscapeFileList()<cr>", "list"},
    },
    c = { "<cmd>lua SwitchConcealLevel()<cr>", "switch conceallevel" },
    s = { "<cmd>Vista<cr>", "taglist" },
    p = { "<cmd>lua ToggleMarkdownPreview()<cr>", "preview" },
    w = { "<cmd>lua SyncVimWikiGitRepo()<cr>", "sync vimwiki" },
    z = { "<cmd>TZAtaraxis<cr>", "zen mode" },
  },
  t = {
    name = "+term",
    w = { "<cmd>lua __fterm_wolfram()<cr>", "wolfram" },
    t = { "<cmd>lua __fterm_btop()<cr>", "top" },
    j = { "<cmd>lua __fterm_julia()<cr>", "julia" },
    p = { "<cmd>lua __fterm_python()<cr>", "python" },
  },
  w = {
    name = "+vimwiki",
    f = { "<cmd>Telescope vimwiki<cr>", "find file" },
    g = { "<cmd>Telescope vimwiki live_grep<cr>", "livegrep" },
  },
  x = { "<cmd>lua close_buffer()<cr>", "close buf" },
}, opts)

wk.register({
  ["/"] = { "<esc><cmd> :lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", "toggle comment" },
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

tnoremap <Esc> <C-\><C-n>
]]
