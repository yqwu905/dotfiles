_G.close_buffer = function(force)
  local opts = {
    next = "cycle", -- how to retrieve the next buffer
    quit = false, -- exit when last buffer is deleted
  }
  local function switch_buffer(windows, buf)
    local cur_win = vim.fn.winnr()
    for _, winid in ipairs(windows) do
      winid = tonumber(winid) or 0
      vim.cmd(string.format("%d wincmd w", vim.fn.win_id2win(winid)))
      vim.cmd(string.format("buffer %d", buf))
    end
    vim.cmd(string.format("%d wincmd w", cur_win)) -- return to original window
  end

  local function get_next_buf(buf)
    local next = vim.fn.bufnr "#"
    if opts.next == "alternate" and vim.fn.buflisted(next) == 1 then
      return next
    end
    for i = 0, vim.fn.bufnr "$" - 1 do
      next = (buf + i) % vim.fn.bufnr "$" + 1 -- will loop back to 1
      if vim.fn.buflisted(next) == 1 then
        return next
      end
    end
  end

  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
    vim.cmd "close"
    return
  end

  if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
    if opts.quit then
      if force then
        vim.cmd "qall!"
      else
        vim.cmd "confirm qall"
      end
      return
    end

    local chad_term, _ = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    if chad_term then
      vim.cmd(string.format("setlocal nobl", buf))
      vim.cmd "enew"
      return
    end
    vim.cmd "enew"
    vim.cmd "bp"
  end

  local next_buf = get_next_buf(buf)
  local windows = vim.fn.getbufinfo(buf)[1].windows

  if force or vim.fn.getbufvar(buf, "&buftype") == "terminal" then
    local chad_term, type = pcall(function()
      return vim.api.nvim_buf_get_var(buf, "term_type")
    end)

    if chad_term then
      if type == "wind" then
        vim.cmd(string.format("%d bufdo setlocal nobl", buf))
        vim.cmd "BufferLineCycleNext"
      else
        local cur_win = vim.fn.winnr()
        vim.cmd(string.format("%d wincmd c", cur_win))
        return
      end
    else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format("bd! %d", buf))
    end
  else
    switch_buffer(windows, next_buf)
    vim.cmd(string.format("silent! confirm bd %d", buf))
  end
  if vim.fn.buflisted(buf) == 1 then
    switch_buffer(windows, buf)
  end
end

_G.AsyncRunCode = function()
  local path = '"' .. vim.fn.expand("%") .. '"'
  if vim.fn.filereadable("CMakeLists.txt") ~= 0 then
    vim.notify("Build Cmake Project")
    if vim.fn.isdirectory("cmake_build") == 0 then
      os.execute("mkdir cmake_build")
    end
    local handle = io.popen('sed -n "s/^.*add_executable(\\(\\S*\\).*$/\\1/p" CMakeLists.txt')
    local executable = handle:read("*a")
    handle:close()
    vim.cmd("AsyncRun -mode=term -pos=bottom cd cmake_build && cmake -G Ninja .. && ninja && ./" .. executable)
  elseif vim.bo.filetype == "cpp" then
    vim.cmd("AsyncRun -mode=term -pos=bottom g++ -std=c++11 -o a.out " .. vim.fn.expand("%") .. "&&./a.out")
  elseif vim.bo.filetype == "c" then
    vim.cmd("AsyncRun -mode=term -pos=bottom gcc -o a.out " .. vim.fn.expand("%") .. "&&./a.out")
  elseif vim.bo.filetype == "python" then
    vim.cmd("AsyncRun -mode=term -pos=bottom python " .. path)
  elseif vim.bo.filetype == "mma" then
    vim.cmd("AsyncRun -mode=term -pos=bottom wolframscript -f " .. vim.fn.expand("%"))
  elseif vim.bo.filetype == "julia" then
    vim.cmd("AsyncRun -mode=term -pos=bottom julia " .. path)
  elseif vim.bo.filetype == "tex" then
    vim.cmd("VimtexCompile")
  end
end

_G.GetVimwikiTodo = function(complete)
  vimwiki_dir = vim.g.vimwiki_list[1]['path'] .. '/*/*'
  if complete then
    vim.cmd("vimgrep /- \\[x\\]/ " .. vimwiki_dir)
  else
    vim.cmd("vimgrep /- \\[ \\]/ " .. vimwiki_dir)
  end
  vim.cmd("TroubleToggle quickfix")
end

_G.fterm_ft = ""
local fterm = require("FTerm")
local btop_term = fterm:new({ ft = "fterm_btop", cmd = "btop" })
local julia_term = fterm:new({ ft = "fterm_julia", cmd = "julia" })
local python_term = fterm:new({ ft = "fterm_python", cmd = "ipython" })

_G.__fterm_ft = function()
  if vim.bo.filetype == "julia" or fterm_ft == "julia" then
    julia_term:toggle()
    if fterm_ft == "" then
      fterm_ft = "julia"
    else
      fterm_ft = ""
    end
  elseif vim.bo.filetype == "python" or fterm_ft == "python" then
    python_term:toggle()
    if fterm_ft == "" then
      fterm_ft = "python"
    else
      fterm_ft = ""
    end
  end
end

_G.__fterm_btop = function()
  btop_term:toggle()
end
_G.__fterm_julia = function()
  julia_term:toggle()
end
_G.__fterm_python = function()
  python_term:toggle()
end
_G.Diffviewopen = 0

_G.SwitchConcealLevel = function()
  if vim.o.conceallevel ~= 0 then
    vim.o.conceallevel = 0
  else
    vim.o.conceallevel = 2
  end
end

_G.ToggleDiffView = function(isdir)
  if isdir then
    if Diffviewopen == 0 then
      vim.cmd("DiffviewFileHistory .")
      Diffviewopen = 1
    else
      vim.cmd("DiffviewClose")
      Diffviewopen = 0
    end
  else
    if Diffviewopen == 0 then
      vim.cmd("DiffviewFileHistory")
      Diffviewopen = 1
    else
      vim.cmd("DiffviewClose")
      Diffviewopen = 0
    end
  end
end

_G.MarpPreviewOn = 0
_G.ToggleMarkdownPreview = function()
  local marp_path = vim.api.nvim_buf_get_name(0)
  local extension = marp_path:match("^.+%.(.+)$")
  if extension == "md" then
    vim.cmd("MarkdownPreview")
  elseif extension == "marp" then
    if MarpPreviewOn == 0 then
      require("notify")("Start MARP Preview")
      vim.cmd("AsyncRun marp -w " .. '"' .. marp_path .. '"')
      vim.cmd(
        ':silent exec "!firefox.exe \\"file://///wsl.localhost/Arch/'
        .. marp_path:match("^(.+%.).+$")
        .. 'html\\""'
      )
      MarpPreviewOn = 1
    else
      require("notify")("Stop MARP Preview")
      vim.cmd("AsyncStop")
      MarpPreviewOn = 0
    end
  end
end

local function dorename(win)
  local new_name = vim.trim(vim.fn.getline("."))
  vim.api.nvim_win_close(win, true)
  vim.lsp.buf.rename(new_name)
end

local function rename()
  local opts = {
    relative = "cursor",
    row = 0,
    col = 0,
    width = 30,
    height = 1,
    style = "minimal",
    border = "single",
  }
  local cword = vim.fn.expand("<cword>")
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  local fmt = "<cmd>lua Rename.dorename(%d)<CR>"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { cword })
  vim.api.nvim_buf_set_keymap(buf, "i", "<CR>", string.format(fmt, win), { silent = true })
end

local function docommit(win)
  local commit_message = vim.trim(vim.fn.getline("."))
  vim.api.nvim_win_close(win, true)
  os.execute(string.format("git commit -m '%s'", commit_message))
end

local function commit()
  local opts = {
    relative = "editor",
    col = math.ceil(0.5 * (vim.o.columns - 60)),
    row = math.ceil(0.5 * (vim.o.lines - 4) - 1),
    width = 60,
    height = 4,
    style = "minimal",
    border = "double",
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  local fmt = "<cmd>lua Commit.docommit(%d)<CR>"

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  vim.api.nvim_buf_set_keymap(buf, "i", "<CR>", string.format(fmt, win), { silent = true })
end

_G.Commit = { commit = commit, docommit = docommit }

_G.Rename = { rename = rename, dorename = dorename }

_G.CodeAction = function()
  vim.lsp.buf.code_action()
end

_G.DynamicWorkspaceSymbol = function()
  require('telescope.builtin').lsp_dynamic_workspace_symbols()
end

_G.SyncVimWikiGitRepo = function()
  vim.cmd(
    'AsyncRun -mode=term -pos=bottom cd ~/repos/vimwiki && git add * && git commit -m "Update by vim" && git push'
  )
end

function OpenInkscapeFile(name)
  local job = require('plenary.job')
  job:new({
    command = 'inkscape.exe',
    args = { name },
    on_exit = vim.schedule_wrap(function(_, return_val)
      os.execute("inkscape.exe -D --export-latex --export-type=\"pdf\" " .. name)
    end),
  }):start()
end

function _G.GetInkscapeFileList()
  local svg_files = vim.split(vim.fn.glob(vim.fn.expand("%:h") .. '/*/*.svg'), '\n')
  vim.ui.select(svg_files, {
    prompt = 'Select one inkscape file'
  }, function(choice)
    OpenInkscapeFile(string.sub(choice, 1, -8) .. "svg")
  end)
end

local function getGitDir(path)
  local handle = io.popen(string.format("cd %s;git rev-parse --show-toplevel 2>&1 | grep -v fatal: | tr -d '\\n'", path))
  local res = handle:read("*a")
  handle:close()
  return res
end

function _G.NewInkscapeFile()
  vim.ui.input({ prompt = 'Enter image name:', default = 'image/' },
    function(input)
      if input ~= nil then
        local p, f, e = string.match(input, "(.-)([^\\/]-)%.?([^%.\\/]*)$")
        local cwd = vim.fn.expand("%:h")
        local cgd = getGitDir(cwd)
        if string.len(cgd) ~= 0 then
          local i_start, _ = string.find(cwd, cgd)
          if i_start == 1 then
            cwd = cgd
          end
        end
        if e ~= 'svg' then
          return -1
        end
        if vim.fn.filereadable(input) ~= 1 then
          os.execute('cp ' .. vim.fn.stdpath('config') .. '/static/drawing.svg ' .. cwd .. '/' .. input)
        end
        local status = pcall(OpenInkscapeFile, cwd .. '/' .. input)
        if status then
          if vim.bo.filetype == "tex" then
            InsertNewLineContentAtCursor({
              "\\begin{figure}[ht]",
              "\t\\centering",
              -- "\t\\includegraphics[width=0.8\\linewidth]{" .. input .."}",
              "\t\\def\\svgwidth{\\columnwidth}",
              "\t\\import{" .. p .. '}{' .. f .. ".pdf_tex}",
              "\t\\label{fig:}",
              "\t\\caption{}",
              "\\end{figure}"
            })
          elseif vim.bo.filetype == "markdown" or vim.bo.filetype == "vimwiki" then
            InsertNewLineContentAtCursor({
              "![](" .. p .. f .. ".svg)",
            })
          end
        end
      end
    end)
end

function InsertNewLineContentAtCursor(content)
  local cur_pos = vim.api.nvim_win_get_cursor(0)
  local r, c = unpack(cur_pos)
  vim.api.nvim_buf_set_lines(0, r, r, false, content)
end
