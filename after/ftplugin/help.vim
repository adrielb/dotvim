" use the :help command for 'K' in .vim files
setlocal keywordprg=":help"

nnoremap <silent><buffer> q :q<CR>
nnoremap <silent><buffer> <leader>v :vertical resize 78<CR>ze

wincmd L
vertical resize 78
normal ze
