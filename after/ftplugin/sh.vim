setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
let b:tmux_window="bash"

nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
