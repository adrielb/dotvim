setlocal formatoptions=tron
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal complete+=k,s
setlocal commentstring=*\ %s
setlocal nofoldenable

let s:moz_history_sh = expand('<sfile>:p:h') . '/' . 'moz_history.sh'

iabbrev <buffer> > `>`
iabbrev <buffer> < `<`
nnoremap <buffer> <leader>m  :MozHist yaml<CR>
nnoremap <buffer> <leader>i  :MozHist image<CR>
nnoremap <buffer> <leader>l  :MozHist link<CR>
nnoremap <buffer> <leader>b  :MozBookmark link<CR>
nnoremap <buffer> <leader>f  :MarkdownFiles<CR>
nnoremap <buffer> <leader>n  :NewNoteFromBookmark<CR>

command! NewNoteFromBookmark call fzf#run({
        \ 'source': s:moz_history_sh . ' bookmarks',
        \ 'sink': function('s:new_note'),
        \ })

command! MarkdownFiles call fzf#run({
        \ 'source': "find . \\( -iname '*.md' -or -iname '*.csv' \\) -printf '\033[32m%Tc\033[0m\t%f\t%P\n'",
        \ 'sink': function('s:inject_mozhist_link'),
        \ 'options': '--ansi'
        \ })

command! -nargs=1 MozHist call fzf#run({
        \ 'source': s:moz_history_sh,
        \ 'sink': function('s:inject_mozhist_' . <q-args>)
        \ })

command! -nargs=1 MozBookmark call fzf#run({
        \ 'source': s:moz_history_sh . ' bookmarks',
        \ 'sink': function('s:inject_mozhist_' . <q-args>)
        \ })


" fzf line format: 'date\ttitle\turl'

function! s:new_note(line)
  let l:lines = split(a:line, "\t")
  let l:date = l:lines[0]
  let l:title = l:lines[1]
  let l:url = l:lines[2]
  let l:header = "---\ndate: " . l:date . 
        \ "\ntitle: " . l:title . 
        \ "\nrefurl: " . l:url .
        \ "\n---\n" . l:url . "\n\n"
  let l:fname = functions#webify_filename(l:title)
  exec "e bookmarks/" . l:fname . ".md"
  put =l:header
  " 'put' creates an empty top line, delete that then move cursor to bottom
  normal ggddG
  write
endfunction

function! s:inject_mozhist_yaml(line)
  let l:line = "---\rdate: " . a:line . "\r---\r"
  let l:line = substitute(l:line, "\t", "\rtitle: ", "")
  let l:line = substitute(l:line, "\t", "\rrefurl: ", "")
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


augroup auto-save-markdown
  au!
  autocmd InsertLeave,TextChanged <buffer> update
augroup END
