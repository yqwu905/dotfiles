return function()
  require 'quarto'.setup {
    closePreviewOnExit = true, -- close preview terminal on closing of qmd file buffer
    diagnostics = {
      enabled = false, -- enable diagnostics for embedded languages
      languages = { 'r', 'python', 'julia' }
    }
  }
end
