return function ()
  require('filetype').setup({
    overrides = {
      extensions = {
        wls = "mma",
        m = "mma"
      }
    }
  })
end
