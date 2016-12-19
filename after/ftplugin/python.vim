setlocal path+=~/.local/lib/python3.5/site-packages/
let b:tmux_window="ipython"

" Neocomplete jedi omni completion
" setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:neocomplete#force_omni_input_patterns.python =
" \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" from pymode
let s:efm  = '%+GTraceback%.%#,'
let s:efm .= '%E  File "%f"\, line %l\,%m%\C,'
let s:efm .= '%E  File "%f"\, line %l%\C,'
let s:efm .= '%C%p^,'
let s:efm .= '%+C    %.%#,'
let s:efm .= '%+C  %.%#,'
let s:efm .= '%Z%\S%\&%m,'
let s:efm .= '%+G%.%#'

let &efm .= ',' . s:efm

nnoremap <buffer> ,a :read !tmux capture-pane -p -J -t 0<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,p :SlimeSend1 print(<C-R><C-W>)<CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 <C-R>"<CR>
nnoremap <buffer> ,s :SlimeSend1 dir(<C-R><C-W>)<CR>
xnoremap <buffer> ,s y:<C-U>SlimeSend1 dir(<C-R>")<CR>
nnoremap <buffer> ,t :SlimeSend1 type(<C-R><C-W>)<CR>
xnoremap <buffer> ,t y:<C-U>SlimeSend1 type(<C-R>")<CR>
nnoremap <buffer> ,r :SlimeSend1 repr(<C-R><C-W>)<CR>
xnoremap <buffer> ,r y:<C-U>SlimeSend1 repr(<C-R>")<CR>
nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>
xnoremap <buffer> K  y:<C-U>SlimeSend1 ?<C-R>"<CR>


" jump to mark, send paragraph to REPL
nmap \a 'a<Plug>SlimeParagraphSend
nmap \b 'b<Plug>SlimeParagraphSend
nmap \c 'c<Plug>SlimeParagraphSend
nmap \d 'd<Plug>SlimeParagraphSend
nmap \e 'e<Plug>SlimeParagraphSend
nmap \f 'f<Plug>SlimeParagraphSend
nmap \g 'g<Plug>SlimeParagraphSend
nmap \h 'h<Plug>SlimeParagraphSend
nmap \i 'i<Plug>SlimeParagraphSend
nmap \j 'j<Plug>SlimeParagraphSend
nmap \k 'k<Plug>SlimeParagraphSend
nmap \l 'l<Plug>SlimeParagraphSend
nmap \m 'm<Plug>SlimeParagraphSend
nmap \n 'n<Plug>SlimeParagraphSend
nmap \o 'o<Plug>SlimeParagraphSend
nmap \p 'p<Plug>SlimeParagraphSend
nmap \q 'q<Plug>SlimeParagraphSend
nmap \r 'r<Plug>SlimeParagraphSend
nmap \s 's<Plug>SlimeParagraphSend
nmap \t 't<Plug>SlimeParagraphSend
nmap \u 'u<Plug>SlimeParagraphSend
nmap \v 'v<Plug>SlimeParagraphSend
nmap \w 'w<Plug>SlimeParagraphSend
nmap \x 'x<Plug>SlimeParagraphSend
nmap \y 'y<Plug>SlimeParagraphSend
nmap \z 'z<Plug>SlimeParagraphSend
