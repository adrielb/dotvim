nnoremap <buffer> ,i :normal 0v$hI<CR>
xnoremap <buffer> ,i :<C-U>exec ":'<,'>w! >> " expand('%:p:h')."/.todoignore.cfile"<CR>gvd
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
