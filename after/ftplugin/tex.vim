
imap <buffer> [[     \begin{
imap <buffer> ]]     <Plug>LatexCloseCurEnv
imap <buffer> ((     \eqref{
nmap <buffer> cr     <Plug>LatexChangeEnv
vmap <buffer> <F7>   <Plug>LatexWrapSelection
vmap <buffer> <S-F7> <Plug>LatexEnvWrapSelection

map  <silent> <buffer> ¶ :call LatexBox_JumpToNextBraces(0)<CR>
map  <silent> <buffer> § :call LatexBox_JumpToNextBraces(1)<CR>
imap <silent> <buffer> ¶ <C-R>=LatexBox_JumpToNextBraces(0)<CR>
imap <silent> <buffer> § <C-R>=LatexBox_JumpToNextBraces(1)<CR>

augroup TexAutoWrite
  autocmd! TexAutoWrite InsertLeave <buffer> :update
augroup END
