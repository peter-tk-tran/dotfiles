" Neovim will look for lua code in the runtimepath you’ve set in your settings. Additionally, it will append your
" runtimepath with /lua/?.lua and /lua/?/init.lua so it is common practice to see a /lua sub-directory inside
" .nvim. For more detailed information about where Neovim looks for lua code, check out :h lua-require.
set runtimepath^=~/.vim runtimepath+=~/.vim/after"
let &packpath=&runtimepath

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Vim Plug Setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $HOME/.vimrc
endif

call plug#begin('~/.vim/plugged')

" Appearance
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'morhetz/gruvbox'

" Git
Plug 'tpope/vim-fugitive'

"Python
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install' }

" Utility
Plug 'mbbill/undotree'
Plug 'bronson/vim-trailing-whitespace'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'preservim/nerdtree'
Plug 'mhinz/vim-startify'

" Search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'jremmen/vim-ripgrep'

" All of your Plugins must be added before the following line
call plug#end()            " required

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let mapleader=" "
"
" Sets number of lines of history VIM has to remember
set history=500

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to autoread when file is changed from outside
set autoread

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Fugitive
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>gs :G<CR>

" For Merging and choosing
nmap <leader>gf :diffget //2<CR>
nmap <leader>gj :diffget //3<CR>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text Editing
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" map sort function to a key
vnoremap <Leader>s :sort<CR>

" better indentation
vnoremap < <gv
vnoremap > >gv

" Rename word
" nmap <leader>rr <Plug>(coc-rename)

" Rename all instances of word in project
" nmap <leader>prw :CocSearch <C-R>=expand("<cword>")<CR><CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"=> Files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set path+=**
if executable('rg')
    let g:rg_derive_root='true'
endif

let g:cntrlp_user_command=['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" copy path of current buffer to clipbaord.
nmap cp :let @" = expand("%:p")<CR>

nmap <c-s> :w<CR>
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => UI
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set minimum space above and below cursor
set scrolloff=5

" Set line numbers
set relativenumber
set number

" Command autocompletion settings
set wildmenu " enable command autocompletion
set wildignore=*.o,*~,*.class,*/git,*/.DS_Store

" Always show current position
set ruler      " show line and char num
set cursorline " horizontal line on cursor

" Global status line
set laststatus=3

" Thing Window Separator
highlight WinSeparator guibg=None

" Set backspace to act like standard text editor
set backspace=indent,eol,start

" Search settings
set ignorecase " set search to be case insensitive
set smartcase " set search to be case sensitive when item has upper case letter
" set hlsearch " highlights search results
set incsearch " searches as editing search item

" Highlight matching brackets
set showmatch

" Error settings
"set noerrorbells " turn off error sounds
"set novisualbell " turn off error flash
set visualbell
set t_vb= " turn off error flash

" Don't redraw when executing macros
set lazyredraw

" Remove mode (shown in lightline anyways)
set noshowmode

" lua vim.o.ls = 0
" lua vim.o.ch = 0
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Color and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
lua << EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = false,
    disable = {},
  },
  ensure_installed = {
      'python',
      'sql',
      'typescript',
      'javascript',
      'rust'
  },
}
EOF

" Highlight keywords in language
syntax enable

" Syntax highlighting
filetype off
filetype plugin indent on
syntax on

" 120 char line length
match Error /\%121v.\+/ " Highlight chars over 80
set colorcolumn=120 " Column at 120 chars

" Colorscheme
set termguicolors
lua << EOF
require("catppuccin").setup({
    dim_inactive = {
		enabled = true,
		shade = "dark",
		percentage = 0.15,
	},
    integrations = {
        cmp = true,
        gitgutter = true,
        telescope = true,
		treesitter = true,
    }
})
EOF
let g:catppuccin_flavour = "mocha" " latte, frappe, macchiato, mocha
colorscheme catppuccin

" Highlight TODO, FIXME, NOTE etc.
if has('autocmd') && v:version > 701
    augroup todo
        autocmd!
        autocmd Syntax * call matchadd(
                    \ 'Debug',
                    \ '\v\W\zs<(NOTE|INFO|IDEA|TODO|FIXME|CHANGED|XXX|BUG|HACK|TRICKY)>'
                    \ )
    augroup END
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn backup off because git is superior (NOT RECOMMENDED)
set nobackup
set noswapfile
set nowritebackup

nnoremap <leader>u :UndotreeToggle<cr>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Tabbing
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Set tab to 4 spaces
set shiftwidth=4
set tabstop=4
set softtabstop=4

" Indentation
set autoindent " maintain indentation on newline
set smartindent " insert new indentation if needed

" Wrapping text
" set textwidth=120 " Set length to wrap at
set nowrap " No text wrapping
" set linebreak    " Set wrap to insert linebreak
if has('autocmd')
    autocmd FileType * setlocal formatoptions+=t " overrides filetype plugin
                                                 " format options setting
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Termianl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Excape in Terminal
tnoremap <Esc> <C-\><C-n>

" Who needs VSCode
set shell=/bin/zsh
map <silent><Leader>t :belowright split term://zsh<CR>
tnoremap <Esc> <C-\><C-n>
augroup myterm | au!
    au TermOpen * if &buftype ==# 'terminal' | resize 20 | endif
augroup end

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving Around
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For mouse normies like me
set mouse=a

" Mapping to move around windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Maintain column selection when moving around
set nostartofline

" Delete trailing white space on save
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.h,*.c,*.java,*.vimrc,*.txt,*.js,*.py,*.wiki,*.sh,*.coffee,*.sql,*.ino,*cs,*.yaml,*.md :call CleanExtraSpaces()
endif


" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Airline Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_theme='angr'
let g:airline_powerline_fonts = 1"
let g:lightline = {
    \ 'separator': { 'left': '', 'right': '' },
    \ 'subseparator': { 'left': '', 'right': '' }
    \ }
let g:airline#extensions#tabline#fnamemod = ':.'
let g:airline#extensions#tabline#fnamecollapse = 0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Python IDE Configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python Folding
set foldmethod=indent
set nofoldenable

" z as in zip ??? similar to fold
map z za

" adding noqa so black doesn't autoformat
nmap <silent> <Leader>b Obreakpoint()  # XXX<Esc>
" nmap <silent> <Leader>b Oimport pdb; pdb.set_trace()  # XXX<Esc>

" todo shortcut
"nmap <silent> <Leader>t O# TODO<Esc>a<SPACE>
" To make sure za doesn't fold everything on first use
set foldlevelstart=20
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Pydocstring
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <silent> <C-d> <Plug>(pydocstring)
let g:pydocstring_formatter = 'google'

" Map the functions to keys for usage
"vmap <C-c> :w !pbcopy<CR><CR>
vmap <C-c> "+y<CR><CR>

"nerd Tree Mapping
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

lua vim.g.snippets = "luasnip"
lua require('plugins')
lua require('language_setup')
lua require('snips')
lua require('auto_complete')

set mouse=a
