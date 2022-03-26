" Run time is a list of base folders that nvim considers important. Kinda like an environment
set runtimepath^=~/.vim runtimepath+=~/.vim/after"
let &packpath=&runtimepath

" gets installed plugins
lua require('plugins')
lua require('telescope')

" LSP config
" nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> <Leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
" nnoremap <silent> <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
" nnoremap <silent> <Leader>h <cmd>lua vim.lsp.buf.hover()<CR>

source ~/.vimrc
"PackerSync
