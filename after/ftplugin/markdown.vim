setlocal formatoptions=tron
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal complete+=k,s
setlocal commentstring=*\ %s

let s:moz_history_sh = expand('<sfile>:p:h') . '/moz_history.sh'

command! MozHist call fzf#run({
        \ 'source': s:moz_history_sh,
        \ 'sink': function('s:inject_mozhist')
        \ })

function! s:inject_mozhist(line)
  let l:line = "---\rdate: " . a:line . "\r---\r"
  let l:line = substitute(l:line, "\t", "\rtitle: ", "")
  let l:line = substitute(l:line, "\t", "\rurl: ", "")
  let l:line = split(l:line, "\r")
  call append(line('.'), l:line)
endfunction



