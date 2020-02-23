" nnoremap <leader>r :!cd ~/.vim/bundle/dotvim && git pull<CR>

augroup dotvim-local
  au!
  autocmd BufEnter bin/todo.py call BufEnterBinTodoPy()
augroup END

function BufEnterBinTodoPy()
  setlocal makeprg=pytest\ --exitfirst\ bin/todo.py
  setlocal efm=%m
  nnoremap <buffer> <leader>m  :silent make!<CR>
endfunction
