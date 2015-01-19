let mapleader = "\<Space>"

" Installed Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'nielsmadan/harlequin'
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug '~/projects/dotvim'

call plug#end()
"}}}

" Basic Vim settings {{{
filetype plugin indent on
syntax on
colorscheme harlequin
set background=dark
set history=10000
set nowrap
set wildmenu
set wildmode=list:longest:full
set backspace=indent,eol,start
set ruler
set showcmd
set mouse-=a
set laststatus=2
set breakindent
set ignorecase
set nowrapscan
set smartcase
set incsearch
set hlsearch
set title
set number
set relativenumber
set colorcolumn=+1
set showmatch
set scrolloff=3
set sidescrolloff=3
set switchbuf=usetab
set hidden
set autoread
set autowriteall
set gdefault
set undofile
set foldmethod=marker
set spelllang=en_us
set spellfile=~/.vim/bundle/dotvim/en.utf-8.add
set thesaurus+=~/.vim/bundle/dotvim/mthes10/mthesaur.txt
set dictionary+=/usr/share/dict/words
set wildignore+=.git
set wildignore+=*.hi,*.x
set wildignore+=*.so,*.a,*.la,*.o
set wildignore+=*.sw?,*.un~,*.pyc,*.class
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.aux,*.dvi,*.toc,*.pdf,*.ps,*.fdb_latexmk
set wildignore+=*.mp3,*.m4a,*.wav,*.flac
set wildignore+=*.mp4,*.avi
set guifont=Droid\ Sans\ Mono\ Slashed\ 12
set guioptions-=m " no menubar
set guioptions-=T " no toolbar
set guioptions-=L " no left scrollbar
set guioptions-=r " no right scrollbar
set shortmess+=I  " no intro msg
set clipboard+=unnamedplus
set report=0
set noesckeys
set listchars=trail:█,tab:>~,eol:¶,extends:»,precedes:«
set fillchars=vert:│,fold:\_,diff:⣿
set completeopt-=preview
set lazyredraw
set conceallevel=2
set concealcursor=i
set foldtext=functions#NeatFoldText()
set sessionoptions-=options
set sessionoptions-=help
set wildcharm=<C-z>
" }}}

" Mappings {{{
inoremap <C-U> <C-G>u<C-U>
nnoremap <C-Q> :wincmd c<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
" }}}

" Airline {{{
let g:airline_theme='dark'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
"}}}

