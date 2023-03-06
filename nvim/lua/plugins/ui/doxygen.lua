return {
  'vim-scripts/DoxygenToolkit.vim',
  config = function ()
    vim.g.DoxygenToolkit_blockHeader =
    '--------------------------------------------------------------------------'
    vim.g.DoxygenToolkit_blockFooter =
    '--------------------------------------------------------------------------'
    vim.g.DoxygenToolkit_authorName = 'pingline'
    vim.g.DoxygenToolkit_licenseTag = 'GPLv3'
  end,
}
