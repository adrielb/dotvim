setlocal expandtab
setlocal autoindent
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal commentstring=//%s
setlocal makeprg=/home/abergman/apps/cmdstan/bin/stanc\ %

let s:efm  = "%PInput file=%f,"
let s:efm  = "%ESYNTAX ERROR%.%#,"
let s:efm .= "%C,"
let s:efm .= "%ZERROR at line %l,"
let s:efm .= "%+C%m,"   "message
" let &efm = s:efm . &efm
let &l:efm = s:efm

iabbrev <buffer> < <-

nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>

function! CmdStan()
  let b:cwd=expand("%:p:h")
  let b:stanfile=expand("%:p:r")
  lcd /home/abergman/apps/cmdstan
  execute "silent make " b:stanfile
  execute "lcd " b:cwd
endfunction
