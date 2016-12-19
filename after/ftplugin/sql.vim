setlocal expandtab
setlocal commentstring=--%s
let b:tmux_window="sqlite"

nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
