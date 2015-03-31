let mapleader = "\<Space>"

" Installed Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'nielsmadan/harlequin', { 'do' : 'git co matchparen' }
Plug 'bling/vim-airline'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-git'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-repeat'
Plug 'jpalardy/vim-slime', { 'do' : 'git co myfork' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': 'yes \| ./install' }
Plug 'Valloric/YouCompleteMe', { 'do' : './install.sh' }
Plug '~/projects/dotvim'
Plug '~/projects/stan.vim'

call plug#end()
"}}}

" Basic Vim settings {{{
filetype plugin indent on
syntax on
colorscheme harlequin
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
nnoremap n nzxzz
nnoremap N Nzxzz
nnoremap gs :Gstatus<CR>
nnoremap gb :buffers<CR>:buffer <C-Z>
nnoremap Q @q
xnoremap Q :norm @q<CR>
nnoremap Y y$
nnoremap ZZ :wqa<CR>
inoremap <C-U> <C-G>u<C-U>
nnoremap <C-Q> :wincmd c<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>l  :nohlsearch<CR><C-L>:checktime<CR>
nnoremap <leader>m  :make<CR>:copen<CR>
nnoremap <leader>s  :call functions#MySpell()<CR>
nnoremap <leader>t  :silent ! gnome-terminal &<CR>
nnoremap <leader>v  :vertical resize 80<CR>ze
nnoremap <leader>/  :Ggrep 
nmap     <leader><CR>         <Plug>SlimeParagraphSend
nmap     <leader><leader><CR> <Plug>SlimeLineSend
xmap     <leader><CR>         <Plug>SlimeRegionSend
nmap     <Leader><S-CR>       viw<leader><cr>
" }}}

" Plugin Options {{{
" vim-slime {{{
let g:slime_no_mappings = 1
let g:slime_target="tmux"
let g:slime_paste_file="/dev/shm/slime-paste"
let g:slime_default_config = {"socket_name": "default", "target_pane": "1.0"}
"}}}

" Airline {{{
let g:airline_theme='dark'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
"}}}

" vim {{{
command! CD cd %:p:h

" Auto-Reload vimrc
" http://www.bestofvim.com/tip/auto-reload-your-vimrc/
augroup reload_vimrc
  autocmd!
  autocmd BufWritePost nvimrc nested source $MYVIMRC
augroup END

augroup localvimrc
  autocmd!
  autocmd VimEnter,BufNewFile,BufReadPost * nested call functions#ReadLocalVimrc()
  autocmd BufWritePost local.vimrc nested :bufdo call functions#ReadLocalVimrc()
augroup END

augroup vimrcEx
  au!
  " Force markdown for *.md files instead of the default modula-2 file type
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
augroup END
"}}}

" netrw {{{
let g:netrw_liststyle = 1
let g:netrw_list_hide = netrw_gitignore#Hide() . '^\.git/$'
" let g:netrw_list_hide = '\..*\.un\~,\..\.sw.'
let g:netrw_banner    = 0
let g:netrw_keepdir   = 0
" }}}

"}}}

