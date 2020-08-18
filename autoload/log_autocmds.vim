" https://github.com/lervag/dotvim/blob/master/personal/plugin/log-autocmds.vim
let s:log_file = '/tmp/vim_log_autocommands'

function! log_autocmds#log_autocmds_toggle()
  augroup LogAutocmd
    autocmd!
  augroup END

  let l:date = strftime('%F', localtime())
  let s:activate = get(s:, 'activate', 0) ? 0 : 1
  if !s:activate
    call s:log('Stopped autocmd log (' . l:date . ')', '')
    exec "vsplit" s:log_file
    return
  endif

  call s:log('Started autocmd log (' . l:date . ')', '')
  augroup LogAutocmd
    for l:au in s:aulist
      silent! execute 'autocmd' l:au '* call s:log(''' . l:au . ''', expand("<afile>"))'
    endfor
  augroup END
endfunction

function! s:log(message, afile)
  silent execute '!echo "'
        \ . strftime('%T', localtime()) . ' - ' . a:message . ' - ' . a:afile . '"'
        \ '>> ' . s:log_file
endfunction

" These are deliberately left out due to side effects
" - SourceCmd
" - FileAppendCmd
" - FileWriteCmd
" - BufWriteCmd
" - FileReadCmd
" - BufReadCmd
" - FuncUndefined

let s:aulist = [
      \ 'BufNewFile',
      \ 'BufReadPre',
      \ 'BufRead',
      \ 'BufReadPost',
      \ 'FileReadPre',
      \ 'FileReadPost',
      \ 'FilterReadPre',
      \ 'FilterReadPost',
      \ 'StdinReadPre',
      \ 'StdinReadPost',
      \ 'BufWrite',
      \ 'BufWritePre',
      \ 'BufWritePost',
      \ 'FileWritePre',
      \ 'FileWritePost',
      \ 'FileAppendPre',
      \ 'FileAppendPost',
      \ 'FilterWritePre',
      \ 'FilterWritePost',
      \ 'BufAdd',
      \ 'BufCreate',
      \ 'BufDelete',
      \ 'BufWipeout',
      \ 'BufFilePre',
      \ 'BufFilePost',
      \ 'BufEnter',
      \ 'BufLeave',
      \ 'BufWinEnter',
      \ 'BufWinLeave',
      \ 'BufUnload',
      \ 'BufHidden',
      \ 'BufNew',
      \ 'SwapExists',
      \ 'FileType',
      \ 'Syntax',
      \ 'EncodingChanged',
      \ 'TermChanged',
      \ 'VimEnter',
      \ 'GUIEnter',
      \ 'GUIFailed',
      \ 'TermResponse',
      \ 'QuitPre',
      \ 'VimLeavePre',
      \ 'VimLeave',
      \ 'FileChangedShell',
      \ 'FileChangedShellPost',
      \ 'FileChangedRO',
      \ 'ShellCmdPost',
      \ 'ShellFilterPost',
      \ 'CmdUndefined',
      \ 'SpellFileMissing',
      \ 'SourcePre',
      \ 'VimResized',
      \ 'FocusGained',
      \ 'FocusLost',
      \ 'CursorHold',
      \ 'CursorHoldI',
      \ 'CursorMoved',
      \ 'CursorMovedI',
      \ 'WinEnter',
      \ 'WinLeave',
      \ 'TabEnter',
      \ 'TabLeave',
      \ 'CmdwinEnter',
      \ 'CmdwinLeave',
      \ 'InsertEnter',
      \ 'InsertChange',
      \ 'InsertLeave',
      \ 'InsertCharPre',
      \ 'TextChanged',
      \ 'TextChangedI',
      \ 'ColorScheme',
      \ 'RemoteReply',
      \ 'QuickFixCmdPre',
      \ 'QuickFixCmdPost',
      \ 'SessionLoadPost',
      \ 'MenuPopup',
      \ 'CompleteDone',
      \ 'User',
      \ ]

