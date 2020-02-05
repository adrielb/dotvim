setlocal wrap
setlocal linebreak
setlocal showbreak
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal iskeyword+=!
setlocal commentstring=#%s
setlocal include=^\\s*\\(using\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal path+=~/apps/julia-bin/julia/share/julia/base/**
setlocal path+=~/.julia/packages/**
setlocal tags+=~/apps/julia-bin/tags
setlocal tags+=~/.julia/tags
let b:tmux_session = functions#BTmuxSession()
let b:tmux_window="julia"
let b:tmux_func="main"
let b:neomake_open_list=2
let s:bin_dir = expand('<sfile>:p:h:h:h') . '/bin'
let s:parse_julia_repl_sh = s:bin_dir . '/parse_julia_repl.sh'

let s:help_efm = ''
let s:help_efm .= '  [%m at %f:%l%.%#,'
let s:help_efm .= '%-G%.%#,'
let g:neomake_help_maker = {
      \ 'exe': 'tmux',
      \ 'args': ['capture-pane', '-p', '-S', '-20', '-J', '-t', b:tmux_session . ':' . b:tmux_window],
      \ 'append_file': 0,
      \ 'errorformat': s:help_efm
      \ }

let s:repl_efm = ''
let s:repl_efm .= '%EERROR: %m,'
let s:repl_efm .= '%CClosest candidates are:%.%#,'
let s:repl_efm .= '%C  %.%# at %.%#,'
let s:repl_efm .= '%C  ...%.%#,'
let s:repl_efm .= '%CStacktrace:%.%#,'
let s:repl_efm .= '%C [%.%# at ./%.%#:%.%#,'
let s:repl_efm .= '%C [%.%# at none:%.%#,'
let s:repl_efm .= '%C %.%# at REPL[%.%#]:%.%#,'
let s:repl_efm .= '%C [%.%# at %f:%l%.%#,'
let s:repl_efm .= '%Cin expression starting at %f:%l%.%#,'
let s:repl_efm .= '%Z,'
let s:repl_efm .= '%-G%.%#,'
let g:neomake_repl_maker = {
      \ 'exe': s:parse_julia_repl_sh,
      \ 'args': [b:tmux_session, b:tmux_window],
      \ 'append_file': 0,
      \ 'errorformat': s:repl_efm
      \ }

let s:all_efm = ''
let s:all_efm .= '%DBASE: %f,'
let s:all_efm .= '%-GWarning: replacing %.%#,'
let s:all_efm .= '%-G%.%# at none:%.%#,'
let s:all_efm .= '%-G%.%# at ./none:%.%#,'
let s:all_efm .= '%-G%.%# at REPL[%.%#]:%.%#,'
let s:all_efm .= '%-G%.%# at /buildworker/%.%#,'
let s:all_efm .= '%-G%.%# at %.%#/Revise/%.%#,'
let s:all_efm .= '%+G%.%# at ./boot.jl%.%#,'
let s:all_efm .= '%+G%.%# at ./loading.jl%.%#,'
let s:all_efm .= '%+G%.%# at ./sysimg.jl%.%#,'
let s:all_efm .= '%+G%.%# at ./client.jl%.%#,'
let s:all_efm .= '%\s%#%f\,%m: line %l%.%#,'
let s:all_efm .= '%m at %f:%l%.%#,'
let s:all_efm .= '%W%.%#Warning: %m,'
let s:all_efm .= '%Z%.%#@%.%# %f:%l%.%#,'
let g:neomake_all_maker = {
      \ 'exe': s:parse_julia_repl_sh,
      \ 'args': [b:tmux_session, b:tmux_window],
      \ 'append_file': 0,
      \ 'errorformat': s:all_efm
      \ }

augroup neomake_update
  autocmd BufEnter <buffer> let g:neomake_repl_maker['args'] = [b:tmux_session, b:tmux_window]
  autocmd BufEnter <buffer> let g:neomake_all_maker['args'] = [b:tmux_session, b:tmux_window]
augroup END

let s:julia_profile_sh = expand('<sfile>:p:h') . '/' . 'julia_profile.sh'
let s:profile_efm  = ''
let s:profile_efm .= '%m at %f:%l'
let g:neomake_profile_maker = {
      \ 'exe': s:julia_profile_sh,
      \ 'append_file': 0,
      \ 'errorformat': s:profile_efm
      \ }

" \ 'errorformat': '%f.%\\d%\\+.mem:%l:%m'
let s:julia_mem_profile_sh = expand('<sfile>:p:h') . '/' . 'julia_mem_profile.sh'
let g:neomake_julia_mem_profile_maker = {
      \ 'exe': s:julia_mem_profile_sh,
      \ 'args': ['%t'],
      \ 'append_file': 0,
      \ 'buffer_output': 0,
      \ 'errorformat': '%f.%n.mem:%l:%m'
      \ }

augroup NeomakeJuliaRepl
  au!
  autocmd FocusGained *.jl Neomake! repl all
  " autocmd FocusGained * Neomake! repl help all
augroup END

let s:efm  = "%+G %.%# at ./client.jl:%l,"
let s:efm .= "%+G %.%# at ./loading.jl:%l,"
let s:efm .= "%m at %f:%l,"
let s:efm .= "%m at %f:%l [inlined],"
let s:efm .= "%t%m at %f:%l.,"

" lint.jl
let s:efm .= "%f:%l %t%m,"

" reading /tmp/prof.txt
" let s:efm = '%m %f%*\s%*\S%*\s%l'
" using awk to rearrange columns
let s:efm .= '%l %f %m,'

" multi-line test error msgs
" let s:efm = '%EERROR: %m,'
" let s:efm .= '%+C %.%#,'
" let s:efm .= '%Zwhile loading %f\, in expression starting on line %l'
" let &efm = s:efm

" single line test error msg
let s:efm .= '%tRROR: %m,'
let s:efm .= 'while loading %f\, %m %l,'
" let &l:efm = s:efm


nnoremap <buffer> ]m /^\<function\><CR>
nnoremap <buffer> [m ?^\<function\><CR>
nnoremap <buffer> <leader>f :g/savefig/normal f"gx<CR>
nnoremap <buffer> <leader>m :JuliaSendTest<CR>:Neomake! repl all<CR>
nnoremap <buffer> <leader>M :JuliaSetFunc<CR>:JuliaSendTest<CR>:Neomake! repl all<CR>
nnoremap <buffer> <C-]>  :Tags <C-R><C-W><CR>
nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>
nnoremap <buffer> ,a :read !tmux capture-pane -p -J -t 0<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-c" )<CR>
nnoremap <buffer> ,d :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-d" )<CR>
nnoremap <buffer> ,h :SlimeSend1 head(<C-R><C-W>)<CR>
nnoremap <buffer> ,f :SlimeSend1 fieldnames(<C-R><C-W>)<CR>
nnoremap <buffer> ,j :call julia#toggle_function_blockassign()<CR>
nnoremap <buffer> ,m :SlimeSend1 methods(<C-R><C-W>)<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-l" )<CR>
nnoremap <buffer> ,p :SlimeSend1 display(<C-R><C-W>)<CR>
nnoremap <buffer> ,r :SlimeSend1 include("<C-R>%")<CR>
nnoremap <buffer> ,s :SlimeSend1 typeof(<C-R><C-W>)<CR>
nnoremap <buffer> ,t :SlimeSend1 tail(<C-R><C-W>)<CR>
nnoremap <buffer> ,u :SlimeSend1 summary(<C-R><C-W>)<CR>
nmap     <buffer> ,w yil:SlimeSend1 @which <C-R>"<CR>
xnoremap <buffer> K  y:<C-U>SlimeSend1 ?<C-R>"<CR>
xnoremap <buffer> ,f y:<C-U>SlimeSend1 fieldnames(<C-R>")<CR>
xnoremap <buffer> ,h y:<C-U>SlimeSend1 head(<C-R>")<CR>
xnoremap <buffer> ,m y:<C-U>SlimeSend1 methods(<C-R>")<CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 display(<C-R>")<CR>
xnoremap <buffer> ,s y:<C-U>SlimeSend1 typeof(<C-R>")<CR>
xnoremap <buffer> ,t y:<C-U>SlimeSend1 tail(<C-R>")<CR>
xnoremap <buffer> ,u y:<C-U>SlimeSend1 summary(<C-R>")<CR>
xnoremap <buffer> ,w y:<C-U>SlimeSend1 @which <C-R>"<CR>

" iabbrev <buffer> > <BAR>>

" clear REPL, jump to mark, send paragraph to REPL
nmap \a ,l'a<Plug>SlimeParagraphSend
nmap \b ,l'b<Plug>SlimeParagraphSend
nmap \c ,l'c<Plug>SlimeParagraphSend
nmap \d ,l'd<Plug>SlimeParagraphSend
nmap \e ,l'e<Plug>SlimeParagraphSend
nmap \f ,l'f<Plug>SlimeParagraphSend
nmap \g ,l'g<Plug>SlimeParagraphSend
nmap \h ,l'h<Plug>SlimeParagraphSend
nmap \i ,l'i<Plug>SlimeParagraphSend
nmap \j ,l'j<Plug>SlimeParagraphSend
nmap \k ,l'k<Plug>SlimeParagraphSend
nmap \l ,l'l<Plug>SlimeParagraphSend
nmap \m ,l'm<Plug>SlimeParagraphSend
nmap \n ,l'n<Plug>SlimeParagraphSend
nmap \o ,l'o<Plug>SlimeParagraphSend
nmap \p ,l'p<Plug>SlimeParagraphSend
nmap \q ,l'q<Plug>SlimeParagraphSend
nmap \r ,l'r<Plug>SlimeParagraphSend
nmap \s ,l's<Plug>SlimeParagraphSend
nmap \t ,l't<Plug>SlimeParagraphSend
nmap \u ,l'u<Plug>SlimeParagraphSend
nmap \v ,l'v<Plug>SlimeParagraphSend
nmap \w ,l'w<Plug>SlimeParagraphSend
nmap \x ,l'x<Plug>SlimeParagraphSend
nmap \y ,l'y<Plug>SlimeParagraphSend
nmap \z ,l'z<Plug>SlimeParagraphSend


function! MarkEvalMacro(marks)
	" inserts 'm<space><CR> for each mark 'm'
  let l:jumps=substitute(a:marks,"\\a","'\\0 ","g")
  let @q="m`" . l:jumps . "``"
  normal @q
endfunction

command! -nargs=1 MarkEvalMacro call MarkEvalMacro(<f-args>)

command! JuliaCTagsRefresh ! ctags-exuberant 
  \ --recurse
  \ --languages=julia
  \ --totals=yes
  \ -f ~/.julia/tags
  \ ~/.julia/packages

" vim-slime
" wrap multiple lines in begin...end block
function! _EscapeText_julia(text)
  if len(split(a:text, "\n")) > 1
    " multiple new lines will break block in REPL
    let empty_lines_pat = '\(^\|\n\)\zs\(\s*\n\+\)\+'
    let one_empty_line = substitute(a:text, empty_lines_pat, "\n", "g")
    return ["begin\n", one_empty_line."end\n"]
  endif
" pass single lines unaffected
  return a:text
endfunction

" jupyter_file:  /path/code.jl  --> /path/code.ipynb
let s:jupyter_file = expand('%:r') . '.ipynb'
if filereadable(s:jupyter_file)
  " file_root:  /path/code.jl  --> code
  let file_root = expand('%:t:r')
  let cmd = "xdotool search --name '" . file_root . " - Mozilla Firefox' windowfocus --sync key Control_L+r"
  execute "autocmd FocusLost <buffer> silent ! " . cmd
  execute "autocmd FocusGained <buffer> checktime " . expand('%')
endif

function! Send_test()
  let current_file = expand('%:t:r')
  let cmd = 'include("' . expand('%') . '"); ret = ' . current_file . '.' . b:tmux_func . '()'
  " let cmd = 'ret = ' . current_file . '.' . b:tmux_func . '()'
  execute 'SlimeSend1 ' . cmd
  sleep 1
endfunction

function! Parse_REPL()
  Neomake! all
  copen
  sleep 100m
  cnext
endfunction

function! Set_Julia_Func()
  call search('^\<function\>','b')
  normal wmm
  let b:tmux_func=expand('<cword>')
  echo b:tmux_func
endfunction

command! JuliaSendTest call Send_test()
command! JuliaParseREPL call Parse_REPL()
command! JuliaSetFunc call Set_Julia_Func()
