-- This file provide some basic and common-use utilities.
local utils = {}

utils.split = function(inputString, sep)
  local fields = {}

  local pattern = string.format('([^%s]+)', sep)
  local _ = string.gsub(inputString, pattern, function(c)
    fields[#fields + 1] = c
  end)

  return fields
end

utils.path_join = function(...)
  local path_sep = vim.loop.os_uname().sysname == 'Windows' and '\\' or '/'
  local args = { ... }
  if #args == 0 then
    return ''
  end
  local all_parts = {}
  if type(args[1]) == 'string' and args[1]:sub(1, 1) == path_sep then
    all_parts[1] = ''
  end
  for _, arg in ipairs(args) do
    local arg_parts = utils.split(arg, path_sep)
    vim.list_extend(all_parts, arg_parts)
  end
  return table.concat(all_parts, path_sep)
end

return utils
