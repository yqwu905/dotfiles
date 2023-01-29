local config = {}

function config.comment()
  require('Comment').setup()
end

function config.hop()
  require('hop').setup()
end

return config
