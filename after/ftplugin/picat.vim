setlocal softtabstop=4
setlocal tabstop=4
setlocal shiftwidth=4
setlocal expandtab
setlocal suffixesadd=.pi
setlocal commentstring=%%s
let b:tmux_window="picat"

function! Send_main()
  let current_file = expand('%:t')
  let cmd = 'cl("' . current_file . '"), main'
  execute 'SlimeSend1 ' . cmd
  sleep 1
endfunction

command! PicatSendMain call Send_main()

nnoremap <buffer> <C-]> :Ack -A0 --picat <C-R><C-W> ~/apps/picat<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,d :call system( "tmux send-keys C-d" )<CR>
nnoremap <buffer> <leader>m :update<CR>:PicatSendMain<CR>
" nmap <leader>m :PicatSendMain<CR>:Neomake! all<CR>:sleep 100m<CR>:copen<CR>:cnext<CR>


