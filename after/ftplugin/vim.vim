" use the :help command for 'K' in .vim files
setlocal keywordprg=":help"
nnoremap <buffer> K  :help <C-R><C-W><CR>

"r	Automatically insert the current comment leader after hitting
"   <Enter> in Insert mode.
setlocal formatoptions-=o

"o	Automatically insert the current comment leader after hitting 'o' or
"   'O' in Normal mode.
setlocal formatoptions-=r

