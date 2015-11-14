" Neocomplete jedi omni completion
" setlocal omnifunc=jedi#completions
" let g:jedi#completions_enabled = 0
" let g:jedi#auto_vim_configuration = 0
" let g:neocomplete#force_omni_input_patterns.python =
" \ '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'

" from pymode
let s:efm  = '%+GTraceback%.%#,'
let s:efm .= '%E  File "%f"\, line %l\,%m%\C,'
let s:efm .= '%E  File "%f"\, line %l%\C,'
let s:efm .= '%C%p^,'
let s:efm .= '%+C    %.%#,'
let s:efm .= '%+C  %.%#,'
let s:efm .= '%Z%\S%\&%m,'
let s:efm .= '%+G%.%#'

let &efm .= ',' . s:efm

nnoremap <buffer> ,a :read !tmux capture-pane -p<CR>
nnoremap <buffer> ,c :call system( "tmux send-keys C-c" )<CR>
nnoremap <buffer> ,l :call system( "tmux send-keys C-l" )<CR>
nnoremap <buffer> ,p :SlimeSend1 <C-R><C-W><CR>
xnoremap <buffer> ,p y:<C-U>SlimeSend1 <C-R>"<CR>
