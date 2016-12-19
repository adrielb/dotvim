" Google's R Style Guide
" https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
let b:tmux_window="R"

nmap <buffer> <down> ]`zx
nmap <buffer> <up> [`zx

nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>:call RemapSlimeMap()<CR>
nnoremap <buffer> ,a :read !tmux capture-pane -p<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
nnoremap <buffer> ,h :SlimeSend1 head(<C-R><C-W>)<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,p :SlimeSend1 print(<C-R><C-W>)<CR>
nnoremap <buffer> ,r :SlimeSend1 rm(<C-R><C-W>)
nnoremap <buffer> ,s :SlimeSend1 str(<C-R><C-W>)<CR>
nnoremap <buffer> ,t :SlimeSend1 tail(<C-R><C-W>)<CR>
nnoremap <buffer> ,u :SlimeSend1 summary(<C-R><C-W>)<CR>
xnoremap <buffer> ,h y:<C-U>SlimeSend1 head(<C-R>")<CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 print(<C-R>")<CR>
xnoremap <buffer> ,r y:<C-U>SlimeSend1 rm(<C-R>")
xnoremap <buffer> ,s y:<C-U>SlimeSend1 str(<C-R>")<CR>
xnoremap <buffer> ,t y:<C-U>SlimeSend1 tail(<C-R>")<CR>
xnoremap <buffer> ,u y:<C-U>SlimeSend1 summary(<C-R>")<CR>

iabbrev <buffer> < <-
iabbrev <buffer> > %>%

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

function! RemapSlimeMap()
  nmap <leader><CR> :call ResetSlimeMap()<CR>
endfunction
  
function! ResetSlimeMap()
  " quit the man page in the console
  SlimeSend1 q

  " remap back to original state (sync with vimrc)
  nmap <leader><CR> <Plug>SlimeParagraphSend

  " execute  the original mapping
  exec ":normal \<Plug>SlimeParagraphSend"
endfunction

function! MarkEvalMacro(marks)
	" inserts 'm<space><CR> for each mark 'm'
  let l:jumps=substitute(a:marks,"\\a","'\\0 ","g")
  let @q="m`" . l:jumps . "``"
  normal @q
endfunction

command! -nargs=1 MarkEvalMacro call MarkEvalMacro(<f-args>)
