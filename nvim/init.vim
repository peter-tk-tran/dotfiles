" Run time is a list of base folders that nvim considers important. Kinda like an environment
set runtimepath^=~/.vim runtimepath+=~/.vim/after"
let &packpath=&runtimepath

source ~/.vimrc

" gets installed plugins
lua require('plugins')
lua require('telescope')
lua require('python_setup')
lua require('auto_complete')
