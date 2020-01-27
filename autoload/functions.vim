
" output all currently defined mappings
function! functions#PrintMappings()
  execute "redir! > /tmp/map.vim"
  execute "silent verbose map"
  execute "redir END"
  execute "tabnew /tmp/map.vim"
endfunction

"http://vim.wikia.com/wiki/Capture_ex_command_output
function! functions#PrintMessage(cmd)
  redir => mymessage
  silent execute a:cmd
  redir END
  tabnew
  silent put=mymessage
  setlocal readonly
  setlocal filetype=vim
  setlocal buftype=nofile
endfunction

function! functions#ReadLocalVimrc()
  let mylocalvimrc = expand( "%:p:h" ) . "/local.vimrc"
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

" Syntax colors duplicate lines
" http://stackoverflow.com/questions/1268032/marking-duplicate-lines
function! functions#HighlightRepeats() range
  let lineCounts = {}
  let lineNum = a:firstline
  while lineNum <= a:lastline
    let lineText = getline(lineNum)
    if lineText != ""
      let lineCounts[lineText] = (has_key(lineCounts, lineText) ? lineCounts[lineText] : 0) + 1
    endif
    let lineNum = lineNum + 1
  endwhile
  exe 'syn clear Repeat'
  for lineText in keys(lineCounts)
    if lineCounts[lineText] >= 2
      exe 'syn match Repeat "^' . escape(lineText, '".\^$*[]') . '$"'
    endif
  endfor
endfunction

"http://vim.wikia.com/wiki/View_all_colors_available_to_gvim
"   :VimColorTest    "(for console/terminal Vim)
"   :GvimColorTest   "(for GUI gvim)
function! functions#VimColorTest(outfile, fgend, bgend)
  let result = []
  for fg in range(a:fgend)
    for bg in range(a:bgend)
      let kw = printf('%-7s', printf('c_%d_%d', fg, bg))
      let h = printf('hi %s ctermfg=%d ctermbg=%d', kw, fg, bg)
      let s = printf('syn keyword %s %s', kw, kw)
      call add(result, printf('%-32s | %s', h, s))
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
endfunction

function! functions#GvimColorTest(outfile)
  let result = []
  for red in range(0, 255, 16)
    for green in range(0, 255, 16)
      for blue in range(0, 255, 16)
        let kw = printf('%-13s', printf('c_%d_%d_%d', red, green, blue))
        let fg = printf('#%02x%02x%02x', red, green, blue)
        let bg = '#fafafa'
        let h = printf('hi %s guifg=%s guibg=%s', kw, fg, bg)
        let s = printf('syn keyword %s %s', kw, kw)
        call add(result, printf('%s | %s', h, s))
      endfor
    endfor
  endfor
  call writefile(result, a:outfile)
  execute 'edit '.a:outfile
  source %
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

" http://blog.tommcdo.com/2014/03/manage-small-groups-of-related-files.html
" Manage small groups of related files with Vim's argument list
function! functions#StatuslineArglistIndicator()
    return '%{argc()>0?("A[".repeat("-",argidx()).(expand("%")==argv(argidx())?"+":"~").repeat("-",argc()-argidx()-1)."]"):""}'
endfunction

"http://vim.wikia.com/wiki/Easily_switch_between_source_and_header_file
function! functions#SwitchSourceHeader()
  if (expand ("%:e") == "c")
    find %:t:r.h
  else
    find %:t:r.c
  endif
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
  put =a:header
  " 'put' creates an empty top line, delete that then move cursor to bottom
  normal ggddG
  " call append(line('.'), l:header)
  execute "write" a:fname
endfunction

function! functions#SetBufferPWD()
  if !exists("b:setbufferpwd")
    silent! Glcd
    let b:setbufferpwd = 1
  endif
endfunction
