local utils = require('core.utils')
local lazy = {}
lazy.__index = lazy

-- Use in other file to add plugin to plugins list.
function lazy.reg(repo)
  if not lazy.repos then
    lazy.repos = {}
  end
  table.insert(lazy.repos, repo)
end

-- Require all ${config}/lua/plugins/*/plugins.lua
function lazy:load_plugins()
  local plugins_dir = utils.path_join(vim.fn.stdpath('config'), 'lua', 'plugins')
  self.repos = {}
  function lua_match(path)
    return path:sub(#path - 3, #path) == '.lua'
  end

  local list = vim.fs.find(lua_match,
      {path = plugins_dir, type = 'file', limit = 200})
  if #list == 0 then
    return
  end

  for _, f in pairs(list) do
    local _, pos = f:find(plugins_dir)
    f = f:sub(pos - 6, #f - 4)
    lazy.reg(require(f))
  end
end

-- Ensure lazy.nvim installation and setup.
function lazy:start()
  -- Bootstrap lazy.nvim
  local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      'https://github.com/folke/lazy.nvim.git',
      '--branch=stable', -- latest stable release
      lazypath,
    })
  end
  vim.opt.rtp:prepend(lazypath)
  require('lazy').setup(self.repos,
    {lockfile = utils.path_join(vim.fn.stdpath('data'), 'lazy-lock.json')})
end

return lazy
