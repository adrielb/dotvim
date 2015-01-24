" Google's R Style Guide
" https://google-styleguide.googlecode.com/svn/trunk/Rguide.xml
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

nnoremap <buffer> K :SlimeSend1 ?<C-R><C-W><CR>
nnoremap <buffer> KK :SlimeSend1 q<CR>

iabbrev <buffer> < <-
iabbrev <buffer> > %>%
