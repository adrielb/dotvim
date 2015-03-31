" Google's R Style Guide
" https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab

nnoremap <buffer> K :SlimeSend1 ?<C-R><C-W><CR>
nnoremap <buffer> KK :SlimeSend1 q<CR>
nnoremap <buffer> ,s :SlimeSend1 str(<C-R><C-W>)<CR>
nnoremap <buffer> ,p :SlimeSend1 print(<C-R><C-W>)<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>

iabbrev <buffer> < <-
iabbrev <buffer> > %>%
