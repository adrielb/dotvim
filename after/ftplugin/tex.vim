augroup TexAutoWrite
  " buffer local autocmd's shouldnt be cleared
  " autocmd!
  autocmd InsertLeave,CursorHoldI,TextChanged <buffer> :update|Neomake
augroup END
