setlocal expandtab
setlocal commentstring=--%s
let b:tmux_window="sqlite"
let b:tmux_command="python3 -c \\\"import apsw;apsw.main()\\\""

nnoremap <buffer> ,c :call system( "tmux send-keys -t " . b:tmux_session . ":" . b:tmux_window . " C-c" )<CR>
