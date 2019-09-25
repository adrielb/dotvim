setlocal formatoptions=tron
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal complete+=k,s
setlocal commentstring=*\ %s
setlocal nofoldenable

let s:moz_history_sh = expand('<sfile>:p:h') . '/moz_history.sh'

nnoremap <leader>m  :MozHist yaml<CR>
nnoremap <leader>i  :MozHist image<CR>
nnoremap <leader>l  :MozHist link<CR>

command! -nargs=1 MozHist call fzf#run({
        \ 'source': s:moz_history_sh,
        \ 'sink': function('s:inject_mozhist_' . <q-args>)
        \ })

function! s:inject_mozhist_yaml(line)
  let l:line = "---\rvisitdate: " . a:line . "\r---\r"
  let l:line = substitute(l:line, "\t", "\rtitle: ", "")
  let l:line = substitute(l:line, "\t", "\rurl: ", "")
  let l:lines = split(l:line, "\r")
  call append(line('.'), l:lines)
endfunction

function! s:inject_mozhist_image(line)
  let l:lines = split(a:line, "\t")
  let l:img = "![FIG: ](" . l:lines[2] . ")"
  call append(line('.'), l:img)
endfunction

function! s:inject_mozhist_link(line)
  let l:lines = split(a:line, "\t")
  let l:img = "[" . l:lines[1] . "](" . l:lines[2] . ")"
  call append(line('.'), l:img)
endfunction
