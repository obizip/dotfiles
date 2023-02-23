" Base
syntax enable
colorscheme default
set ttimeoutlen=10
set belloff=all
set mouse=a
set encoding=utf-8
set history=1000
set clipboard+=unnamed
set backspace=indent,eol,start
set nocompatible
" File
set noswapfile
set nobackup
set hidden
set autoread
set autowrite

" vim.o.undofile
" vim.opt.undodir=os.getenv("HOME") .. '/.local/share/nvim/undo'
" Display
set title
set termguicolors
set nonumber
set cmdheight=1
set laststatus=1
set showmode
set showmatch
set matchtime=1
set showcmd
set wildmenu
set wildmode=list:longest,full
" Tab & Indent
set tabstop=4
set shiftwidth=0
set softtabstop=-1
set expandtab "expand tab to spaces
set smarttab
set autoindent
set smartindent
set wrap
set linebreak
set showbreak=+\
set breakindent
" Search
set wrapscan
set ignorecase
set smartcase
set incsearch
set hlsearch

""" Commands
command! -count=4 Tab call Tab(<count>)
function Tab(count)
    execute 'set tabstop=' . a:count
endfunction

command! Numbertoggle setl number! number?

""" Mappings
let g:mapleader=" "
" Normal mode
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k
nnoremap H ^
nnoremap L $
nnoremap <Esc><Esc> :noh<CR>
nnoremap <Leader>e :E<CR>
nnoremap <C-h> :bp<CR>
nnoremap <C-l> :bn<CR>
nnoremap <C-d> :bwipe<CR>
nnoremap <Leader>c :e $MYVIMRC<CR>
nnoremap <Leader>n :Numbertoggle <CR>
nnoremap <Leader>2 :Tab 2<CR>
nnoremap <Leader>4 :Tab 4<CR>

inoremap <C-f> <right>
inoremap <C-b> <left>
inoremap <C-a> <home>
inoremap <C-e> <end>
inoremap <C-j> <C-o>o
inoremap <C-y> <C-o>p
inoremap <C-k> <C-o>D
inoremap { {}<Left>
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap ( ()<ESC>i
inoremap (<Enter> ()<Left><CR><ESC><S-o>

vnoremap j gj
vnoremap k gk
vnoremap gj j
vnoremap gk k

cnoremap <C-f> <right>
cnoremap <C-b> <left>
inoremap <C-a> <home>
inoremap <C-e> <end>

if has('vim_starting')
    "挿入モード時に非点滅の縦棒タイプのカーソル
    let &t_SI .= "\e[6 q"
    "ノーマルモード時に非点滅のブロックタイプのカーソル
    let &t_EI .="\e[2 q"
    "置換モード時に非点滅の下線タイプのカーソル
    let &t_SR .="\e[4 q"
endif
