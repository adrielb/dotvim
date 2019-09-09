setlocal shiftwidth=4
setlocal makeprg=python3\ -c\ \'import\ yaml,\ pprint;pprint.pprint(yaml.load(open(\"%\")))\'

let s:efm = ''
let s:efm .= '%E%.%#Error: %m,'
let s:efm .= '%Z%.%#"%f"\, line %l\, column %c,'
let s:efm .= '%E%m,'
let s:efm .= '%Z%.%#"%f"\, line %l\, column %c,'
let &l:efm = s:efm

augroup YamlLint
  autocmd!
  " autocmd BufEnter <buffer> :so /home/abergman/projects/dotvim/after/ftplugin/yaml.vim
  autocmd InsertLeave,CursorHoldI,TextChanged <buffer> :Neomake
augroup END

