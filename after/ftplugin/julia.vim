setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal commentstring=#%s
setlocal path+=~/apps/julia/base

let s:efm = "%m at %f:%l,"

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
let s:efm .= 'ERROR: %m,'
let s:efm .= 'while loading %f\, in expression starting on line %l,'
let &l:efm = s:efm

nmap <buffer> <down> ]`zx
nmap <buffer> <up> [`zx

nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>
nnoremap <buffer> ,a :read !tmux capture-pane -p<CR>
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
xnoremap <buffer> ,f y:<C-U>SlimeSend1 fieldnames(<C-R>")<CR>
xnoremap <buffer> ,h y:<C-U>SlimeSend1 head(<C-R>")<CR>
xnoremap <buffer> ,m y:<C-U>SlimeSend1 methods(<C-R>")<CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 print(<C-R>")<CR>
xnoremap <buffer> ,s y:<C-U>SlimeSend1 typeof(<C-R>")<CR>
xnoremap <buffer> ,t y:<C-U>SlimeSend1 tail(<C-R>")<CR>
xnoremap <buffer> ,u y:<C-U>SlimeSend1 summary(<C-R>")<CR>

iabbrev <buffer> > <BAR>>

" clear REPL, jump to mark, send paragraph to REPL
nmap \a ,l'a<Space><CR>
nmap \b ,l'b<Space><CR>
nmap \c ,l'c<Space><CR>
nmap \d ,l'd<Space><CR>
nmap \e ,l'e<Space><CR>
nmap \f ,l'f<Space><CR>
nmap \g ,l'g<Space><CR>
nmap \h ,l'h<Space><CR>
nmap \i ,l'i<Space><CR>
nmap \j ,l'j<Space><CR>
nmap \k ,l'k<Space><CR>
nmap \l ,l'l<Space><CR>
nmap \m ,l'm<Space><CR>
nmap \n ,l'n<Space><CR>
nmap \o ,l'o<Space><CR>
nmap \p ,l'p<Space><CR>
nmap \q ,l'q<Space><CR>
nmap \r ,l'r<Space><CR>
nmap \s ,l's<Space><CR>
nmap \t ,l't<Space><CR>
nmap \u ,l'u<Space><CR>
nmap \v ,l'v<Space><CR>
nmap \w ,l'w<Space><CR>
nmap \x ,l'x<Space><CR>
nmap \y ,l'y<Space><CR>
nmap \z ,l'z<Space><CR>

  



function! MarkEvalMacro(marks)
	" inserts 'm<space><CR> for each mark 'm'
  let l:jumps=substitute(a:marks,"\\a","'\\0 ","g")
  let @q="m`" . l:jumps . "``"
  normal @q
endfunction

command! -nargs=1 MarkEvalMacro call MarkEvalMacro(<f-args>)
