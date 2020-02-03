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

