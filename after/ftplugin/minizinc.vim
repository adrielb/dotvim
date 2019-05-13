setlocal shiftwidth=4
setlocal tabstop=4
" setlocal makeprg=minizinc
setlocal commentstring=%%s

let s:efm  = ""
let s:efm .= "%f:%l:,"
let s:efm .= "%f:%l.%c:,"
let s:efm .= "%f:%l.%c-%.%#,"
let &l:efm = s:efm
nnoremap <leader>m  :silent make -B %<CR>
" nnoremap <leader>m  :silent make -B %<BAR>redraw!<BAR>cc<CR>

