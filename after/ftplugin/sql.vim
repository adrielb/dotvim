setlocal expandtab
setlocal commentstring=--%s
let b:tmux_window="sqlite"

nnoremap <buffer> ,c :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-c" )<CR>
