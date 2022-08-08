vim.api.nvim_command([[
autocmd BufNewFile,BufRead *.wls set filetype=mma
autocmd BufNewFile,BufRead *.wl set filetype=mma
autocmd BufNewFile,BufRead *.m set filetype=mma
autocmd BufNewFile,BufRead *.marp set filetype=markdown
autocmd BufNewFile,BufRead *.tex set filetype=tex

autocmd BufNewFile,BufRead *.md so $VIMRUNTIME/syntax/tex.vim
autocmd BufNewFile,BufRead *.marp so $VIMRUNTIME/syntax/tex.vim

" autocmd FileType mma AsyncRun wolframscript -f " .. "~/tools/lsp-wl/init.wls --tcp-server=6536
]])
