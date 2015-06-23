" Google's R Style Guide
" https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

nnoremap <buffer> K  :SlimeSend1 ?<C-R><C-W><CR>:call RemapSlimeMap()<CR>
nnoremap <buffer> ,h :SlimeSend1 head(<C-R><C-W>)<CR>
nnoremap <buffer> ,t :SlimeSend1 tail(<C-R><C-W>)<CR>
nnoremap <buffer> ,s :SlimeSend1 str(<C-R><C-W>)<CR>
xnoremap <buffer> ,s y:<C-U>SlimeSend1 str(<C-R>")<CR>
nnoremap <buffer> ,p :SlimeSend1 print(<C-R><C-W>)<CR>
nnoremap <buffer> ,u :SlimeSend1 summary(<C-R><C-W>)<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>

iabbrev <buffer> < <-
iabbrev <buffer> > %>%

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

