setlocal formatoptions=tron
setlocal textwidth=80
setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal expandtab
setlocal complete+=k,s
setlocal commentstring=*\ %s
setlocal nofoldenable
setlocal conceallevel=1

let s:moz_history_sh = expand('<sfile>:p:h') . '/' . 'moz_history.sh'

iabbrev <buffer> > `>`
iabbrev <buffer> < `<`

inoremap <expr>   <c-x><c-p> fzf#vim#complete#path("find . -iname '*.png' -print \| sed 's:^..::'")
nnoremap <buffer> <leader>m  :MozHist yaml<CR>
nnoremap <buffer> ,i :MozHist image<CR>
nnoremap <buffer> <leader>l  :MozHist link<CR>
nnoremap <buffer> <leader>b  :MozBookmark link<CR>
nnoremap <buffer> <leader>f  :MarkdownFiles<CR>
nnoremap <buffer> ,b :NewNoteFromBookmark<CR>
nnoremap <buffer> ,n :NewNote<space>
nnoremap <buffer> ,l :WikiLink<CR>


command! -nargs=* NewNote call functions#new_note(<f-args>)

command! NewNoteFromBookmark call fzf#run({
        \ 'source': s:moz_history_sh . ' bookmarks',
        \ 'sink': function('functions#new_note_bookmark'),
        \ })

command! MarkdownFiles call fzf#run({
        \ 'source': "find . \\( -iname '*.md' -or -iname '*.csv' -or -iname '*.png'\\) -printf '\033[32m%Tc\033[0m\t%P\t%P\n'",
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

function! s:make_link(line)
  let l:has_column = 1
  let parts = split(a:line, '[^:]\zs:\ze[^:]')
  let filename = parts[0]
  let lnum = parts[1]
  let text = join(parts[(l:has_column ? 3 : 2):], ':')
  let link = "[" . text . "](" . filename . ")"
  put =link
endfunction


command! -bang -nargs=* WikiLink call fzf#vim#ag(<q-args>,
      \ fzf#vim#with_preview('left:88', {'sink': function('s:make_link')}))



" fzf line format: 'date\ttitle\turl'

function! s:inject_mozhist_yaml(line)
  let l:line = "---\rdate: " . a:line . "\r---\r"
  let l:line = substitute(l:line, "\t", "\rtitle: ", "")
  let l:line = substitute(l:line, "\t", "\rrefurl: ", "")
  let l:lines = split(l:line, "\r")
  call append(line('.'), l:lines)
endfunction

function! s:inject_mozhist_image(line)
  let l:lines = split(a:line, "\t")
  let l:url = l:lines[2]
  let l:img_dir = "img/"
  exec "silent !wget --directory-prefix=" . l:img_dir . " " . l:url
  let l:localimg = fnamemodify(l:url,':t')
  let l:md_img = "![FIG: ](/" . l:img_dir . l:localimg . ")"
  call append(line('.'), l:md_img)
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
