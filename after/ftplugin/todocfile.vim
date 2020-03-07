nnoremap <buffer> ,i :normal 0v$h,i<CR>
xnoremap <buffer> ,i :<C-U>exec ":'<,'>w! >> " expand('%:p:h')."/.todoignore.cfile"<CR>gvd
nmap     <buffer> ,f 0v/:\d*:\d*:<CR>hy:call writefile(getreg('"',1,1), expand('%:p:h')."/.todoignore", "a")<CR>
nnoremap <buffer> <PageUp>   :m0<CR>'.
xnoremap <buffer> <PageUp>   :m0<CR>'.
nnoremap <buffer> <PageDown> :m$<CR>'.
xnoremap <buffer> <PageDown> :m$<CR>'.
nmap     <buffer> <home>     [e
xmap     <buffer> <home>     [e
nmap     <buffer> <end>      ]e
xmap     <buffer> <end>      ]e

augroup auto-save-todocfile
  au!
  autocmd InsertLeave,TextChanged todo.cfile update
augroup END
