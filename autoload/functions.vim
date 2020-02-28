let s:bin_dir = expand('<sfile>:p:h:h') . '/bin'
let s:moz_history_sh = s:bin_dir . '/moz_history.sh'

function! functions#ReadLocalVimrc()
  let mylocalvimrc = "local.vimrc"
  if filereadable( mylocalvimrc )
    execute "source " . fnameescape( mylocalvimrc )
    redraw
    echo mylocalvimrc . " sourced"
  endif
endfunction

" Toggle spell mode
function! functions#MySpell()
  setlocal spell!
  if &spell
    echo "Spell Mode"
    nnoremap <buffer> k [s
    nnoremap <buffer> j ]s
    nnoremap <buffer> l 1z=
    nnoremap <buffer> h ea<C-x><C-s>
  else
    echo "Spell off"
    nunmap <buffer> h
    nunmap <buffer> j
    nunmap <buffer> k
    nunmap <buffer> l
  endif
endfunction

"http://dhruvasagar.com/2013/03/28/vim-better-foldtext
"VIM Better FoldText
function! functions#NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf("%10s", lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

function! functions#BTmuxSession()
  let file = expand('%:p')
  let pat = '\v/home/abergman/projects/([^/]*)/.*'
  let project = substitute(file, pat, '\1', '')
  if project == file
    return
  endif
  return project
endfunction

function! functions#TmuxClient() abort
  return system('tmux list-clients -F "#{client_tty}" | head -n 1')
endfunction

function! functions#SwitchTmux(...)
  if !exists( 'b:tmux_session' )
    let b:tmux_session = functions#BTmuxSession()
  endif
  if exists('a:1')
    let b:tmux_session = a:1
  endif
  if !exists( 'b:tmux_window' )
    return
  endif
  let l:win = b:tmux_session . ':' . b:tmux_window
  if !exists( 'g:tmux_client' ) || g:tmux_client == ''
    let g:tmux_client = functions#TmuxClient()
  endif
  call system('tmux switch-client -t ' . l:win . ' -c ' . g:tmux_client)
  let b:slime_config = {"socket_name": "default"
                     \ ,"target_pane": l:win }
endfunction

function! functions#CaptureTmux()
  silent !tmux capture-pane -p -S -20 -J -t 0 > /dev/shm/tmux_capture
  cfile /dev/shm/tmux_capture
  copen
endfunction

command! OpenBookmark call fzf#run({
        \ 'source': s:moz_history_sh . ' bookmarks',
        \ 'sink*': function('functions#open_bookmark'),
        \ 'options': ['--expect=ctrl-g','--print-query']
        \ })

function! functions#open_bookmark(fzfout)
  let l:query = a:fzfout[0]
  let l:expect = a:fzfout[1]
  let l:url = split(a:fzfout[2], "\t")[2]
  if l:expect == "ctrl-g"
    call functions#Google(0, l:query)
  else
    exec "silent !firefox " l:url
  endif
endfunction

command! -nargs=1 Google call functions#Google(0, <f-args>)
command! -nargs=1 GoogleL call functions#Google(1, <f-args>)

function! functions#Google(lucky, query)
  python3 << EOF
import vim
import urllib.parse
import subprocess

lucky = int(vim.eval('a:lucky'))
query = vim.eval('a:query')

params = {'q': query}
if lucky:
    params['btnI'] = ''
params = urllib.parse.urlencode(params)

url = 'http://www.google.com/search?' + params

subprocess.run(["firefox", "--private-window", url])
EOF
endfunction

let g:wiki_location = "~/projects/wiki/"

function! functions#webify_filename(title)
  " convert spaces to underscore
  " convert symbols to dash
  let l:fname = substitute(a:title, "[^[:alnum:][:space:]]", "-", "g")
  let l:fname = substitute(l:fname, "[[:space:]]", "_", "g")
  let l:fname = l:fname[:127]
  return l:fname
endfunction

command! -nargs=* NewNote call functions#new_note(<f-args>)

function! functions#new_note(...) abort
  let l:fname = expand(g:wiki_location) . strftime("%F-%H%M")
  if len(a:000) == 0
    let l:title = ""
    let l:fname = l:fname . ".md"
  else
    let l:title = join(a:000)
    let l:fname = l:fname . "-" . functions#webify_filename(l:title) . ".md"
  endif
  let l:header = 
        \ "---\n" .
        \ "date: " . strftime("%FT%T%z") . "\n" .
        \ "title: " . l:title . "\n" .
        \ "---\n\n"
  call functions#write_note(fname, header)
endfunction

function! functions#new_note_bookmark(line)
  let l:lines = split(a:line, "\t")
  let l:date = l:lines[0]
  let l:title = l:lines[1]
  let l:url = l:lines[2]
  let l:header = 
        \ "---\n" .
        \ "date: " . l:date . "\n" .
        \ "title: >\n    " . l:title . "\n" .
        \ "refurl: " . l:url . "\n" .
        \ "tags: [todo]\n" .
        \ "---\n\n"
  let l:fname = expand(g:wiki_location) . "/bookmarks/" . 
        \ functions#webify_filename(l:title) . ".md"
  call functions#write_note(fname, header)
endfunction

function! functions#write_note(fname, header)
  if filereadable(a:fname)
    exec "edit" a:fname
    return
  endif
  enew
  call append(0, split(a:header,"\n"))
  execute "write" a:fname
endfunction

function! functions#SetBufferCWD()
  if exists("b:CWD")
    exec "lcd" b:CWD
  else
    try
      Glcd
      let b:CWD = getcwd()
    catch /.*/
    endtry
  endif
endfunction


command! Todo call functions#UpdateTodo()

function! functions#UpdateTodo()
  exec "!" . s:bin_dir . "/todo.py"
  silent cfile todo.cfile
  copen
endfunction

function! TodoPostpone()
  let title = getqflist({'title':0}).title
  echo title == ':  silent cfile todo.cfile'
  let idx = getqflist({'idx':0,'items':0}).idx
  let items = getqflist()
  echo items[idx].text
  " TODO: verify that 'text' matches cfile text
  " reload cfile
  " jump to error idx+1
endfunction

function! TodoPrioritize()
 " TODO: send existing task to the top of the queue
endfunction


command! YouTubePause silent !xdotool search --name 'YouTube' key --window \%@ k
command! YouTubeRewind silent !xdotool search --name 'YouTube' key --window \%@ j
