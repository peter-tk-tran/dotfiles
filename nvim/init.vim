set runtimepath^=~/.vim runtimepath+=~/.vim/after"
let &packpath=&runtimepath

source ~/.vimrc
lua require('plugins')
lua require('nvim-cmp')
lua require('lspconfig').pyright.setup{}

" LSP config
nnoremap <silent> <Leader>gd <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> <Leader>gD <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <Leader>gr <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> <Leader>gi <cmd>lua vim.lsp.buf.implmentation()<CR>
nnoremap <silent> <Leader>K <cmd>lua vim.lsp.buf.hover()<CR>


"PackerSync
