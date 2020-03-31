setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
let b:tmux_window="bash"

nnoremap <buffer> ,c :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-c" )<CR>
nnoremap <buffer> ,q :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " q" )<CR>
