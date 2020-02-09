nnoremap <buffer> ,i :normal 0v$hI<CR>
xnoremap <buffer> ,i :<C-U>exec ":'<,'>w! >> " expand('%:p:h')."/.todoignore.cfile"<CR>gvd

augroup auto-save-todocfile
  au!
  autocmd InsertLeave,TextChanged todo.cfile update
augroup END
