setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal commentstring=#%s
setlocal include=^\\s*\\(using\\\|import\\)
setlocal includeexpr=substitute(v:fname,'\\.','/','g')
setlocal path+=~/apps/julia-bin/julia-1.0.1/share/julia/base/**
setlocal path+=~/.julia/packages/**
setlocal tags+=~/apps/julia/tags
setlocal tags+=~/.julia/tags
let b:tmux_window="julia"

let s:help_efm = ''
let s:help_efm .= '  [%m at %f:%l%.%#,'
let s:help_efm .= '%-G%.%#,'
let g:neomake_help_maker = {
      \ 'exe': 'tmux',
      \ 'args': ['capture-pane', '-p', '-S', '-20', '-J'],
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
let s:repl_efm .= '%C [%.%# at %f:%l%.%#,'
let s:repl_efm .= '%Cin expression starting at %f:%l%.%#,'
let s:repl_efm .= '%Z,'
let s:repl_efm .= '%-G%.%#,'
let g:neomake_repl_maker = {
      \ 'exe': 'tmux',
      \ 'args': ['capture-pane', '-p', '-S', '-20', '-J'],
      \ 'append_file': 0,
      \ 'errorformat': s:repl_efm
      \ }

augroup NeomakeJuliaRepl
  au!
  autocmd FocusGained * Neomake! repl help
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


nnoremap <buffer> <C-]>  :Tags <C-R><C-W><CR>
nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>
nnoremap <buffer> ,a :read !tmux capture-pane -p -J -t 0<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
nnoremap <buffer> ,h :SlimeSend1 head(<C-R><C-W>)<CR>
nnoremap <buffer> ,f :SlimeSend1 fieldnames(<C-R><C-W>)<CR>
nnoremap <buffer> ,m :SlimeSend1 methods(<C-R><C-W>)<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,p :SlimeSend1 print(<C-R><C-W>)<CR>
nnoremap <buffer> ,r :SlimeSend1 include("<C-R>%")<CR>
nnoremap <buffer> ,s :SlimeSend1 typeof(<C-R><C-W>)<CR>
nnoremap <buffer> ,t :SlimeSend1 tail(<C-R><C-W>)<CR>
nnoremap <buffer> ,u :SlimeSend1 summary(<C-R><C-W>)<CR>
nmap     <buffer> ,w yil:SlimeSend1 @which <C-R>"<CR>
xnoremap <buffer> K  y:<C-U>SlimeSend1 ?<C-R>"<CR>
xnoremap <buffer> ,f y:<C-U>SlimeSend1 fieldnames(<C-R>")<CR>
xnoremap <buffer> ,h y:<C-U>SlimeSend1 head(<C-R>")<CR>
xnoremap <buffer> ,m y:<C-U>SlimeSend1 methods(<C-R>")<CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 print(<C-R>")<CR>
xnoremap <buffer> ,s y:<C-U>SlimeSend1 typeof(<C-R>")<CR>
xnoremap <buffer> ,t y:<C-U>SlimeSend1 tail(<C-R>")<CR>
xnoremap <buffer> ,u y:<C-U>SlimeSend1 summary(<C-R>")<CR>
xnoremap <buffer> ,w y:<C-U>SlimeSend1 @which <C-R>"<CR>

iabbrev <buffer> > <BAR>>

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
