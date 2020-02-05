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
normal zR

let s:moz_history_sh = expand('<sfile>:p:h:h:h') . '/bin/moz_history.sh'

iabbrev <buffer> > `>`
iabbrev <buffer> < `<`

inoremap <expr>   <c-x><c-p> fzf#vim#complete#path("find . -iname '*.png' -print \| sed 's:^..::'")
nnoremap <buffer> ,i :MozHist image<CR>
nnoremap <buffer> <leader>f  :MarkdownFiles<CR>
nnoremap <buffer> ,nh :NewNoteFromHistory<CR>
nnoremap <buffer> ,nb :NewNoteFromBookmark<CR>
nnoremap <buffer> ,n  :NewNote<space>
nnoremap <buffer> ,lh :MozHist link<CR>
nnoremap <buffer> ,lb :MozBookmark link<CR>
nnoremap <buffer> ,lw :WikiLink<CR>


command! -nargs=* NewNote call functions#new_note(<f-args>)

command! NewNoteFromBookmark call fzf#run({
        \ 'source': s:moz_history_sh . ' bookmarks',
        \ 'sink': function('functions#new_note_bookmark'),
        \ })

command! NewNoteFromHistory call fzf#run({
        \ 'source': s:moz_history_sh,
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
      \ fzf#vim#with_preview({'sink': function('s:make_link')}, 'left:88'))



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
