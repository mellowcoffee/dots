" .vimrc

set nocompatible
filetype plugin indent on
syntax enable

let mapleader = " "
let maplocalleader = "\\"

if has('clipboard')
  set clipboard^=unnamedplus
endif

set tabstop=4
set shiftwidth=4
set softtabstop=2
set shiftround
set expandtab " Use spaces instead of tabs
set smartindent
set autoindent
set nowrap

set scrolloff=2
set showmode
set showcmd
set number
set relativenumber
set cursorline
set showmatch
set signcolumn=number
set laststatus=0
set noruler

if exists('&guicursor')
  set guicursor=n:block,i:ver20,v:block
endif

set backspace=indent,eol,start
set nohlsearch
set incsearch
set ignorecase
set smartcase
set virtualedit=block
set undofile
set undodir=~/.vim/undo
if !isdirectory(expand('~/.vim/undo'))
  call mkdir(expand('~/.vim/undo'), 'p', 0700)
endif

set ttyfast
set mouse=a
set background=dark
if has('termguicolors')
  set termguicolors
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

set list
set listchars=tab:→\ ,extends:›,precedes:‹,nbsp:␣

set completeopt=menuone,noselect
set pumheight=12
set shortmess+=c
set omnifunc=syntaxcomplete#Complete
set complete=.,w,b,u,t
set wildmenu
set wildmode=longest:full,full
set wildignore+=*/.git/*,*/node_modules/*,*/target/*,*/build/*
set path+=**

" keymaps

" buffers
nnoremap <S-l> :bnext<CR>
nnoremap <S-h> :bprevious<CR>
nnoremap <leader>x :bdelete<CR>

" editing
nnoremap U <C-r>

" terminal mode
if has('terminal')
  tnoremap <Esc><Esc> <C-\><C-n>
endif

" centered scrolling
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap { {zz
nnoremap } }zz

" file explorer
nnoremap - :Explore<CR>
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_hide = 0
let g:netrw_localrmdir = 'rm -r'

" quickfix
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>

" hungarian layout remaps
nnoremap é ;
nnoremap É ,
nnoremap ő {
nnoremap ú }
nnoremap Ő [
nnoremap Ú ]

nnoremap <leader>fb :ls<CR>:buffer 
nnoremap <leader>fm :call JumpToMark()<CR>

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case
  set grepformat=%f:%l:%c:%m
endif

function! JumpToMark()
  marks
  let ch = nr2char(getchar())
  execute "normal! '" . ch
endfunction

colorscheme retrobox
