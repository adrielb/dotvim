scriptencoding utf-8
let g:mapleader = "\<Space>"

" Installed Plugins {{{
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-git'
Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-markdown'
Plug 'plasticboy/vim-markdown'
" Plug 'gabrielelana/vim-markdown'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'gregsexton/gitv', {'on': ['Gitv']}
Plug 'jpalardy/vim-slime'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/vim-peekaboo'
Plug 'justinmk/vim-dirvish'
Plug 'davidhalter/jedi-vim'
Plug 'wellle/tmux-complete.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'kshenoy/vim-signature'
Plug 'benekastah/neomake'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'jaxbot/semantic-highlight.vim'
Plug 'machakann/vim-highlightedyank'
Plug '~/projects/dotvim'
Plug '~/projects/stan.vim'
Plug 'cespare/vim-toml'
Plug 'szw/vim-g'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'bash install.sh'}
Plug 'zchee/deoplete-jedi'
" Plug 'carlitux/deoplete-ternjs'
Plug 'mileszs/ack.vim'

" Haskell
" Plug 'raichoo/haskell-vim'
" Plug 'eagletmt/neco-ghc'
" Plug 'eagletmt/ghcmod-vim'
" Plug 'Twinside/vim-hoogle'
" Plug 'Shougo/vimproc', {'do' : 'make'}


call plug#end()
"}}}

" Basic Vim settings {{{
filetype plugin indent on
syntax on
set termguicolors
set history=10000
set nowrap
set wildmenu
set wildmode=list:longest:full
set backspace=indent,eol,start
set ruler
set showcmd
set mouse=n
set laststatus=2
set breakindent
set ignorecase
set nowrapscan
set smartcase
set incsearch
set hlsearch
set title
set number
set norelativenumber
set cursorline
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
set spellfile=~/projects/dotvim/en.utf-8.add
set thesaurus+=~/projects/dotvim/mthes10/mthesaur.txt
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
set listchars=trail:█,tab:>~,eol:¶,extends:»,precedes:«,nbsp:¬
set fillchars=vert:│,fold:\_,diff:⣿
set lazyredraw
set conceallevel=2
set concealcursor=i
set foldtext=functions#NeatFoldText()
set sessionoptions-=options
set sessionoptions-=help
set wildcharm=<C-z>
set inccommand=split
" }}}

" Mappings {{{
" line text object
vnoremap al :<C-U>normal! 0v$h<CR>
vnoremap il :<C-U>normal! ^vg_<CR>
onoremap al :norm val<CR>
onoremap il :norm vil<CR>
" _af fold text-object
vnoremap af :<C-U>silent! normal! [zV]z<CR>
vnoremap if :<C-U>silent! normal! [zjV]zk<CR>
omap     af :normal Vaf<CR>
omap     if :normal Vif<CR>
nnoremap n nzxzz
nnoremap N Nzxzz
nnoremap g/ :Ack<Space><C-R><C-W><Space>%:p:h<left><left><left><left><left><left>
xnoremap g/ y:<C-U>Ag <C-R>"<CR>
    nmap ga <Plug>(EasyAlign)
nnoremap gl :Lines<CR>
nnoremap go :GitFiles<CR>
nnoremap gO :FZF ~/projects/<CR>
nnoremap gb :Buffers<CR>
nnoremap gB :Files<CR>
nnoremap gs :Gstatus<CR>
nnoremap gV `[v`]
nnoremap Q @q
xnoremap Q :norm @q<CR>
xnoremap s :s/\%V
nnoremap Y y$
nnoremap ZZ :wqa<CR>
inoremap <C-U> <C-G>u<C-U>
nnoremap <C-Q> :setlocal bufhidden=delete<BAR>bnext<CR>
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>a  :call functions#CaptureTmux()<CR>
nnoremap <leader>g  :Googlef <C-R><C-W><CR>
xnoremap <leader>g  :Googlef<CR>
nnoremap <leader>l  :nohlsearch<CR><C-L>:checktime<CR>
nnoremap <leader>m  :silent make<BAR>redraw!<BAR>cc<CR>
nnoremap <leader>r  :NeomakeSh ./%<CR>
nnoremap <leader>s  :call functions#MySpell()<CR>
nnoremap <leader>t  :silent ! gnome-terminal &<CR>
nnoremap <leader>v  :vertical resize 88<CR>ze
nnoremap <leader>/  :Ggrep -i -- 
xnoremap <leader>/  y:<C-U>Ggrep <C-R>"<CR>
nmap     <leader><CR>         <Plug>SlimeParagraphSend
nmap     <leader><leader><CR> <Plug>SlimeLineSend
xmap     <leader><CR>         <Plug>SlimeRegionSend
nmap     <Leader><S-CR>       viw<leader><cr>
imap   <esc><space>
nnoremap <up>       :cprev<BAR>normal! zxzz<CR>
nnoremap <down>     :cnext<BAR>normal! zxzz<CR>
nnoremap <left>     :bprev<CR>
nnoremap <right>    :bnext<CR>
    vmap <CR>       <Plug>(EasyAlign)
nnoremap -          :Dirvish %<CR>
tnoremap <Esc>      <C-\><C-n>
" }}}

" Plugin Options {{{

" Prose {{{
let g:tex_flavor='latex'
let g:markdown_folding=1
"}}}

" vim-g {{{
let g:vim_g_open_command = 'firefox'
"}}}

" deoplete/jedi/LanguageClient {{{
let g:LanguageClient_diagnosticsEnable = 0
let g:LanguageClient_serverCommands = {
\    'python': ['pyls', '-v'],
\}
" let g:jedi#completions_enabled = 0
let g:jedi#auto_vim_configuration = 0
let g:jedi#rename_command = ''
let g:jedi#force_py_version = 3
let g:jedi#use_tag_stack = 0
" if !exists('g:deoplete#sources')
"     let g:deoplete#sources = {}
" endif
" let g:deoplete#sources.sql = ['buffer']
call deoplete#custom#source('_', 'matchers', ['matcher_fuzzy'])
let g:deoplete#ignore_sources = {'python': ['tag'],
      \ 'julia': ['dictionary']}
let g:deoplete#sources#jedi#show_docstring=1
let g:deoplete#sources#jedi#server_timeout=30
let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python3'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:deoplete#enable_at_startup = 1
" Enable jedi source debug messages
" let g:neomake_logfile = '/tmp/neomake.log'
let g:LanguageClient_loggingLevel = 'DEBUG'
let g:deoplete#sources#jedi#debug_server='/tmp/jedi.log'
" call deoplete#enable_logging('DEBUG', '/tmp/deoplete.log')
" let g:tmuxcomplete#capture_args="-s lines"
let g:tmuxcomplete#mode='WORD'
inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ Check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! Check_back_space() abort "{{{
  let l:col = col('.') - 1
  return !l:col || getline('.')[l:col - 1]  =~? '\s'
endfunction"}}}
"}}}

" signature {{{
let g:SignatureIncludeMarks='jkluiopmnhyasdfgqwertzxcvb'
"}}}

" colorscheme{{{
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_improved_warnings=1
colorscheme gruvbox
set background=dark
highlight Normal ctermbg=0 guibg=#000000
let g:semanticEnableFileTypes = { 'julia': 'jl', 'python': 'py' }
"}}}

" julia {{{
augroup julia-mem-profile-ft
  au!
  autocmd BufRead *.jl.mem setl ft=julia
augroup END
let g:latex_to_unicode_auto = 1
"}}}

" sql {{{
let g:sql_type_default = 'sqlanywhere'
"}}}

" UltiSnips"{{{
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "snippets"]
let g:UltiSnipsSnippetsDir=$HOME.'/projects/dotvim/UltiSnips'
let g:UltiSnipsExpandTrigger='<c-j>'
let g:UltiSnipsJumpForwardTrigger='<c-j>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" https://github.com/SirVer/ultisnips/issues/376
let g:ulti_expand_or_jump_res = 0
function! <SID>ExpandSnippetOrReturn()
  let l:snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return l:snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=<SID>ExpandSnippetOrReturn()<CR>" : "\<CR>"
" }}}

" vim-slime {{{
let g:slime_no_mappings = 1
let g:slime_target='tmux'
let g:slime_paste_file='/dev/shm/slime-paste'
let g:slime_default_config = {'socket_name': 'default', 'target_pane': '1.0'}
let g:slime_python_ipython=1
au BufRead,BufNewFile,BufNew *.hss setl ft=haskell.script
"}}}

" Airline {{{
let g:airline_theme='dark'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#whitespace#enabled = 0
let g:airline_detect_crypt=0
let g:airline_theme_patch_func = 'AirlineThemePatch'
function! AirlineThemePatch(palette)
  for l:colors in values(a:palette.inactive)
    let l:colors[2] = 245
  endfor
endfunction
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

augroup CursorLine
    au!
    au VimEnter * setlocal cursorline
    au WinEnter * setlocal cursorline
    au BufWinEnter * setlocal cursorline
    au WinLeave * setlocal nocursorline
augroup END

augroup switch_tmux
  autocmd!
  autocmd BufEnter,WinEnter * call functions#SwitchTmux()
augroup END

"}}}

" netrw {{{
let g:netrw_liststyle = 1
let g:netrw_list_hide = netrw_gitignore#Hide() . '^\.git/$'
" let g:netrw_list_hide = '\..*\.un\~,\..\.sw.'
let g:netrw_banner    = 0
let g:netrw_keepdir   = 0
" }}}

" gitv {{{
let g:Gitv_DoNotMapCtrlKey = 1
"}}}

"}}}

