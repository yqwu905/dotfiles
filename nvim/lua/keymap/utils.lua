local utils = {}

function utils.close_buffer(force)
  local opts = {
    next = 'cycle', -- how to retrieve the next buffer
    quit = false, -- exit when last buffer is deleted
  }
  local function switch_buffer(windows, buf)
    local cur_win = vim.fn.winnr()
    for _, winid in ipairs(windows) do
      winid = tonumber(winid) or 0
      vim.cmd(string.format('%d wincmd w', vim.fn.win_id2win(winid)))
      vim.cmd(string.format('buffer %d', buf))
    end
    vim.cmd(string.format('%d wincmd w', cur_win)) -- return to original window
  end

  local function get_next_buf(buf)
    local next = vim.fn.bufnr '#'
    if opts.next == 'alternate' and vim.fn.buflisted(next) == 1 then
      return next
    end
    for i = 0, vim.fn.bufnr '$' - 1 do
      next = (buf + i) % vim.fn.bufnr '$' + 1 -- will loop back to 1
      if vim.fn.buflisted(next) == 1 then
        return next
      end
    end
  end

  local buf = vim.fn.bufnr()
  if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
    vim.cmd 'close'
    return
  end

  if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
    if opts.quit then
      if force then
        vim.cmd 'qall!'
      else
        vim.cmd 'confirm qall'
      end
      return
    end

    local chad_term, _ = pcall(function()
      return vim.api.nvim_buf_get_var(buf, 'term_type')
    end)

    if chad_term then
      vim.cmd(string.format('setlocal nobl', buf))
      vim.cmd 'enew'
      return
    end
    vim.cmd 'enew'
    vim.cmd 'bp'
  end

  local next_buf = get_next_buf(buf)
  local windows = vim.fn.getbufinfo(buf)[1].windows

  if force or vim.fn.getbufvar(buf, '&buftype') == 'terminal' then
    local chad_term, type = pcall(function()
      return vim.api.nvim_buf_get_var(buf, 'term_type')
    end)

    if chad_term then
      if type == 'wind' then
        vim.cmd(string.format('%d bufdo setlocal nobl', buf))
        vim.cmd 'BufferLineCycleNext'
      else
        local cur_win = vim.fn.winnr()
        vim.cmd(string.format('%d wincmd c', cur_win))
        return
      end
    else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format('bd! %d', buf))
    end
  else
    switch_buffer(windows, next_buf)
    vim.cmd(string.format('silent! confirm bd %d', buf))
  end
  if vim.fn.buflisted(buf) == 1 then
    switch_buffer(windows, buf)
  end
end

function utils.async_run_code()
  local path = '"' .. vim.fn.expand('%') .. '"'
  if vim.fn.filereadable('CMakeLists.txt') ~= 0 then
    vim.notify('Build Cmake Project')
    if vim.fn.isdirectory('cmake_build') == 0 then
      os.execute('mkdir cmake_build')
    end
    local handle = io.popen('sed -n "s/^.*add_executable(\\(\\S*\\).*$/\\1/p" CMakeLists.txt')
    local executable = handle:read('*a')
    handle:close()
    first_breakline_idx, _ = string.find(executable, '\n')
    if first_breakline_idx ~= nil then
      executable = executable:sub(1, first_breakline_idx)
    end
    vim.cmd(string.format('AsyncRun -mode=term -pos=bottom cd cmake_build && cmake -G Ninja .. && ninja && ./%s'
      , executable))
  elseif vim.bo.filetype == 'cpp' then
    vim.cmd('AsyncRun -mode=term -pos=bottom g++ -std=c++11 -o a.out ' ..
      vim.fn.expand('%') .. '&&./a.out')
  elseif vim.bo.filetype == 'c' then
    vim.cmd('AsyncRun -mode=term -pos=bottom gcc -o a.out ' ..
      vim.fn.expand('%') .. '&&./a.out')
  elseif vim.bo.filetype == 'python' then
    vim.cmd('AsyncRun -mode=term -pos=bottom python ' .. path)
  elseif vim.bo.filetype == 'mma' then
    vim.cmd('AsyncRun -mode=term -pos=bottom wolframscript -f ' ..
      vim.fn.expand('%'))
  elseif vim.bo.filetype == 'julia' then
    vim.cmd('AsyncRun -mode=term -pos=bottom julia ' .. path)
  elseif vim.bo.filetype == 'tex' then
    vim.cmd('VimtexCompile')
  end
end

function utils.toggle_preview()
  local md_path = vim.api.nvim_buf_get_name(0)
  local extension = md_path:match('^.+%.(.+)$')
  if extension == 'md' then
    vim.cmd('MarkdownPreview')
  elseif extension == 'qmd' then
    vim.cmd('AsyncRun -mode=term -pos=hide quarto preview ' .. md_path)
  end
end

utils.Commit = {}

function utils.Commit.docommit(win)
  local commit_message = vim.trim(vim.fn.getline('.'))
  vim.api.nvim_win_close(win, true)
  os.execute(string.format("git commit -m '%s'", commit_message))
end

function utils.Commit.commit()
  local opts = {
    relative = 'editor',
    col = math.ceil(0.5 * (vim.o.columns - 60)),
    row = math.ceil(0.5 * (vim.o.lines - 4) - 1),
    width = 60,
    height = 4,
    style = 'minimal',
    border = 'double',
  }
  local buf = vim.api.nvim_create_buf(false, true)
  local win = vim.api.nvim_open_win(buf, true, opts)
  local fmt = '<cmd>lua Commit.docommit(%d)<CR>'

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, {})
  vim.api.nvim_buf_set_keymap(buf, 'i', '<CR>', string.format(fmt, win),
    { silent = true })
end

_G.get_visual_selection = function()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return lines
end

function utils.switch_conceallevel()
  if (vim.bo.filetype == 'norg') then
    vim.cmd('Neorg toggle-concealer')
  else
    if (vim.o.conceallevel == 2) then
      vim.o.conceallevel = 0
    else
      vim.o.conceallevel = 2
    end
  end
end

return utils
